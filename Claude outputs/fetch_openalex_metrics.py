"""Fetch citation/impact metrics from OpenAlex for every publication.

Run this script (manually or via CI) after publications are committed.
It reads every content/publication/*/index.md, queries OpenAlex in batches
by DOI, and patches each file's YAML frontmatter with an auto-managed block
containing: cited_by_count, fwci, citation_percentile, top-percentile flags,
OA status, and yearly citation counts for a sparkline.

Re-runs are idempotent: the managed block is stripped and rewritten each time.

Usage:
    pip install requests
    python fetch_openalex_metrics.py
"""

import json
import os
import re
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

import requests

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

USER_AGENT = "DataHealthLab/1.0 (mailto:oranzani@santpau.cat)"
MAILTO = "oranzani@santpau.cat"

# Hugo Blox publications directory
PUBLICATIONS_DIR = Path("content/publication")

# Output JSON (useful for debugging / downstream use)
METRICS_JSON = Path("assets/openalex_metrics.json")

SPARKLINE_YEARS = 8
OPENALEX_BATCH_SIZE = 50

# Markers for the auto-managed YAML block inside each index.md
METRICS_BEGIN = "# --- openalex metrics (auto-managed; do not edit) ---"
METRICS_END   = "# --- end openalex metrics ---"

# ---------------------------------------------------------------------------
# DOI helpers
# ---------------------------------------------------------------------------

def normalize_doi(doi: str) -> str:
    if not doi:
        return ""
    doi = str(doi).strip().strip('"').strip("'")
    doi = re.sub(r"^https?://(dx\.)?doi\.org/", "", doi, flags=re.IGNORECASE)
    doi = re.sub(r"^doi:\s*", "", doi, flags=re.IGNORECASE)
    return doi.strip().lower()


# ---------------------------------------------------------------------------
# Frontmatter parsing (no PyYAML — keeps deps minimal)
# ---------------------------------------------------------------------------

FRONTMATTER_RE = re.compile(r"^---[ \t]*\r?\n(.*?)\r?\n---[ \t]*\r?\n", re.DOTALL)


def split_frontmatter(text: str):
    """Return (frontmatter_str, body_str) or (None, text)."""
    m = FRONTMATTER_RE.match(text)
    if not m:
        return None, text
    return m.group(1), text[m.end():]


def extract_doi(fm: str) -> str:
    """Pull the doi: value from raw frontmatter text."""
    if not fm:
        return ""
    for line in fm.splitlines():
        m = re.match(r"""^\s*doi:\s*["']?([^"'\n]+?)["']?\s*$""", line)
        if m:
            return normalize_doi(m.group(1))
    return ""


def strip_managed_block(fm: str) -> str:
    pat = re.compile(
        re.escape(METRICS_BEGIN) + r".*?" + re.escape(METRICS_END) + r"\n?",
        re.DOTALL,
    )
    return pat.sub("", fm)


def render_managed_block(m: dict) -> str:
    lines = [METRICS_BEGIN]

    if m.get("cited_by_count") is not None:
        lines.append(f"cited_by_count: {int(m['cited_by_count'])}")

    fwci = m.get("fwci")
    if fwci is not None:
        lines.append(f"fwci: {float(fwci):.2f}")

    pct = m.get("citation_percentile")
    if pct is not None:
        lines.append(f"citation_percentile: {float(pct):.1f}")

    if m.get("is_top_1_percent"):
        lines.append("is_top_1_percent: true")
    if m.get("is_top_10_percent"):
        lines.append("is_top_10_percent: true")
    if m.get("is_oa"):
        lines.append("is_oa: true")

    oa_status = m.get("oa_status")
    if oa_status:
        lines.append(f"oa_status: {oa_status}")

    counts = m.get("counts_by_year_compact") or []
    if counts:
        lines.append("counts_by_year:")
        for year, count in counts:
            lines.append(f"  - [{int(year)}, {int(count)}]")

    updated = m.get("metrics_updated")
    if updated:
        lines.append(f'metrics_updated: "{updated}"')

    lines.append(METRICS_END)
    return "\n".join(lines)


def patch_file(path: Path, metrics: dict | None) -> bool:
    """Rewrite path's frontmatter with (or without) the managed metrics block."""
    text = path.read_text(encoding="utf-8")
    fm, body = split_frontmatter(text)
    if fm is None:
        return False

    fm_clean = strip_managed_block(fm).rstrip() + "\n"
    if metrics:
        fm_clean = fm_clean + render_managed_block(metrics) + "\n"

    new_text = f"---\n{fm_clean}---\n{body}"
    if new_text != text:
        path.write_text(new_text, encoding="utf-8")
        return True
    return False


# ---------------------------------------------------------------------------
# OpenAlex
# ---------------------------------------------------------------------------

OPENALEX_SELECT = ",".join([
    "doi",
    "cited_by_count",
    "counts_by_year",
    "fwci",
    "citation_normalized_percentile",
    "open_access",
])


def request_json(url, params=None, timeout=30, retries=2):
    headers = {"User-Agent": USER_AGENT}
    for attempt in range(retries + 1):
        try:
            r = requests.get(url, params=params, headers=headers, timeout=timeout)
            if r.status_code == 429:
                wait = 2 + attempt * 3
                print(f"  rate-limited; waiting {wait}s")
                time.sleep(wait)
                continue
            if r.status_code == 404:
                return None
            if r.status_code >= 400:
                print(f"  HTTP {r.status_code} from {url}")
                return None
            return r.json()
        except Exception as exc:
            print(f"  error: {exc}")
            if attempt < retries:
                time.sleep(1 + attempt)
    return None


def fetch_batch(dois: list[str]) -> dict:
    out = {}
    if not dois:
        return out
    data = request_json(
        "https://api.openalex.org/works",
        params={
            "filter": "doi:" + "|".join(dois),
            "per-page": len(dois),
            "select": OPENALEX_SELECT,
            "mailto": MAILTO,
        },
    )
    if not data:
        return out
    for work in data.get("results", []) or []:
        doi = normalize_doi(work.get("doi") or "")
        if not doi:
            continue
        cnp = work.get("citation_normalized_percentile") or {}
        oa  = work.get("open_access") or {}
        pct = cnp.get("value")
        out[doi] = {
            "cited_by_count": work.get("cited_by_count"),
            "fwci": work.get("fwci"),
            "citation_percentile": (pct * 100) if isinstance(pct, (int, float)) else None,
            "is_top_1_percent":  bool(cnp.get("is_in_top_1_percent")),
            "is_top_10_percent": bool(cnp.get("is_in_top_10_percent")),
            "is_oa":    bool(oa.get("is_oa")),
            "oa_status": oa.get("oa_status"),
            "counts_by_year": work.get("counts_by_year") or [],
        }
    return out


def fetch_all(dois: list[str]) -> dict:
    metrics = {}
    unique = sorted(set(d for d in dois if d))
    for i in range(0, len(unique), OPENALEX_BATCH_SIZE):
        batch = unique[i : i + OPENALEX_BATCH_SIZE]
        print(f"  batch {i // OPENALEX_BATCH_SIZE + 1}: {len(batch)} DOIs")
        metrics.update(fetch_batch(batch))
        time.sleep(0.2)          # polite delay
    return metrics


def compact_yearly(counts_by_year: list, n: int = SPARKLINE_YEARS) -> list:
    """Last n years as [(year, count), ...] oldest→newest, zero-filled."""
    if not counts_by_year:
        return []
    by_year = {int(c["year"]): int(c.get("cited_by_count") or 0) for c in counts_by_year}
    end   = max(by_year)
    start = end - n + 1
    return [(y, by_year.get(y, 0)) for y in range(start, end + 1)]


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def collect_publications() -> list[tuple[Path, str]]:
    pairs = []
    if not PUBLICATIONS_DIR.exists():
        print(f"Publications dir not found: {PUBLICATIONS_DIR}")
        return pairs
    for index_md in sorted(PUBLICATIONS_DIR.glob("*/index.md")):
        text = index_md.read_text(encoding="utf-8")
        fm, _ = split_frontmatter(text)
        doi = extract_doi(fm or "")
        pairs.append((index_md, doi))
    return pairs


def main() -> int:
    pairs = collect_publications()
    dois  = [doi for _, doi in pairs if doi]
    print(f"Found {len(pairs)} publications, {len(dois)} with DOIs")

    if not dois:
        print("Nothing to fetch.")
        return 0

    print("Querying OpenAlex…")
    raw = fetch_all(dois)
    now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    enriched: dict[str, dict] = {}
    for doi, m in raw.items():
        m = dict(m)
        m["counts_by_year_compact"] = compact_yearly(m.pop("counts_by_year", []))
        m["metrics_updated"] = now
        enriched[doi] = m

    # Write canonical JSON
    METRICS_JSON.parent.mkdir(parents=True, exist_ok=True)
    METRICS_JSON.write_text(
        json.dumps(
            {"generated_at": now, "source": "openalex", "count": len(enriched), "metrics": enriched},
            indent=2, sort_keys=True,
        ),
        encoding="utf-8",
    )
    print(f"Wrote {METRICS_JSON} ({len(enriched)} entries)")

    # Patch publication files
    patched = 0
    for path, doi in pairs:
        m = enriched.get(doi) if doi else None
        if patch_file(path, m):
            patched += 1
    print(f"Patched {patched}/{len(pairs)} publication files")

    missing = [d for d in dois if d not in enriched]
    if missing:
        print(f"OpenAlex returned no data for {len(missing)} DOI(s):")
        for d in missing[:10]:
            print(f"  - {d}")
        if len(missing) > 10:
            print(f"  … and {len(missing) - 10} more")

    return 0


if __name__ == "__main__":
    sys.exit(main())
