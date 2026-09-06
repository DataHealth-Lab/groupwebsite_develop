---
title: Research & Initiatives
subtitle: Where we look for challenges to solve
type: landing

sections:
  - block: markdown
    content:
      title: |
        <style>
          /* Desktop styles */
          .banner-title, .banner-text {
            margin-left: 18rem;
            max-width: 900px;
            color: black; /* Force black text */
          }

          /* Photo credit */
          .photo-credit {
            position: absolute;
            bottom: -5rem;
            right: -2rem;
            font-size: 0.7rem;
            color: #ccc;
          }
          /* Mobile adjustments */
          @media (max-width: 768px) {
            .banner-title, .banner-text {
              margin-left: 5rem !important;  /* Push text more right */
              max-width: 90vw;
              padding-right: 1rem;
              font-size: 1.2rem;
              color: black !important; /* Make sure color stays black */
            }
            /* Adjust photo credit */
            .photo-credit {
              bottom: 0.5rem;
              right: 0.5rem;
              font-size: 0.6rem;
            }
          }
        </style>
        <div class="banner-title">Where we think on challenges to solve</div>
      text: |
        <div style="position: relative;">
          <div class="photo-credit">
            Photo by Ian Ward
          </div>
        </div>
    design:
      background:
        image:
          filename: ocean_climatechange_ianward.jpeg
        image_darken: 0.4
        color: "#000000"
        position: center
        size: cover
      spacing:
        padding: ["5rem", "3rem", "5rem", "3rem"]
      height: "auto"
      alignment: center



  - block: markdown
    content:
      title: "Research Areas"
      subtitle: "Where we explore critical health challenges through research and data"
      text: |

        <style>
        .ra-topics { display: flex; flex-direction: column; gap: 10px; margin: 1.4rem 0 2.2rem; }
        .ra-row { display: flex; align-items: baseline; gap: 12px; }
        .ra-tag {
          flex-shrink: 0; font-size: 0.63rem; font-weight: 700;
          text-transform: uppercase; letter-spacing: 0.09em;
          padding: 3px 10px; border-radius: 20px; color: #fff !important;
          line-height: 1.6; white-space: nowrap;
        }
        .ra-cc { background: #2a7a2a; }
        .ra-cl { background: #1a7070; }
        .ra-vx { background: #8a5500; }
        .ra-pi { background: #5a3a88; }
        .ra-desc { font-size: 0.91rem; line-height: 1.55; }
        .ra-card-cc { border-top: 4px solid #2a7a2a !important; }
        .ra-card-cl { border-top: 4px solid #1a7070 !important; }
        .ra-card-vx { border-top: 4px solid #8a5500 !important; }
        .ra-card-pi { border-top: 4px solid #5a3a88 !important; }
        .ra-card-label {
          font-size: 0.62rem; font-weight: 700; text-transform: uppercase;
          letter-spacing: 0.1em; margin-bottom: 4px; display: block;
        }
        .ra-card-cc .ra-card-label { color: #2a7a2a; }
        .ra-card-cl .ra-card-label { color: #1a7070; }
        .ra-card-vx .ra-card-label { color: #8a5500; }
        .ra-card-pi .ra-card-label { color: #5a3a88; }
        @media (max-width: 600px) {
          .ra-row { flex-direction: column; gap: 5px; }
          .ra-tag { align-self: flex-start; }
          .ra-topics { gap: 14px; }
        }
        </style>

        <div class="ra-topics">
          <div class="ra-row">
            <span class="ra-tag ra-cc">Critical Care</span>
            <span class="ra-desc">Innovation in intensive care: telemedicine, AI, antimicrobial stewardship and resistance</span>
          </div>
          <div class="ra-row">
            <span class="ra-tag ra-cl">Climate &amp; Environment</span>
            <span class="ra-desc">How temperature and air pollutants acutely affect heart, brain and lung... and adaptation actions</span>
          </div>
          <div class="ra-row">
            <span class="ra-tag ra-vx">Vaccines</span>
            <span class="ra-desc">Effectiveness and impact of dengue, HPV, herpes-zoster and respiratory virus vaccines</span>
          </div>
          <div class="ra-row">
            <span class="ra-tag ra-pi">Post-Infectious</span>
            <span class="ra-desc">Epidemiology, mechanisms and treatment of syndromes after COVID-19, TB, Chikungunya, Pneumonia and Sepsis</span>
          </div>
        </div>

        <div class="container">
          <div class="row justify-content-center">
            <!-- Project 1 — Critical Care -->
            <div class="col-md-5 mb-3">
              <div class="card ra-card-cc">
                <a href="critical-care">
                  <img src="/media/icutimpel.jpg" alt="Critical Care ICU EIT" class="card-img-top" style="height: 280px; object-fit: cover;">
                  <div class="card-body">
                    <span class="ra-card-label">Critical Care</span>
                    <h5 class="card-title text-center" style="font-size:1rem; margin:0;">Critical Care Science &amp; Innovation</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 2 — Climate -->
            <div class="col-md-5 mb-3">
              <div class="card ra-card-cl">
                <a href="climate-environment-health">
                  <img src="/media/flood_brazil.jpeg" alt="Climate change" class="card-img-top" style="height: 280px; object-fit: cover;">
                  <div class="card-body">
                    <span class="ra-card-label">Climate &amp; Environment</span>
                    <h5 class="card-title text-center" style="font-size:1rem; margin:0;">Climate Change &amp; Environment</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 3 — Vaccines -->
            <div class="col-md-5 mb-3">
              <div class="card ra-card-vx">
                <a href="infectious-diseases-vaccines">
                  <img src="https://live.staticflickr.com/65535/51356159980_0c373cc805_h.jpg" alt="Infectious Diseases & Vaccines" class="card-img-top" style="height: 280px; object-fit: cover;">
                  <div class="card-body">
                    <span class="ra-card-label">Infectious Diseases &amp; Vaccines</span>
                    <h5 class="card-title text-center" style="font-size:1rem; margin:0;">Infectious Diseases &amp; Vaccines</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 4 — Post-Infectious -->
            <div class="col-md-5 mb-3">
              <div class="card ra-card-pi">
                <a href="post-infectious-syndromes">
                  <img src="/media/chicken_amazon.jpg" alt="Post-Infectious Syndromes" class="card-img-top" style="height: 280px; object-fit: cover;">
                  <div class="card-body">
                    <span class="ra-card-label">Post-Infectious Syndromes</span>
                    <h5 class="card-title text-center" style="font-size:1rem; margin:0;">Post-Infectious Syndromes</h5>
                  </div>
                </a>
              </div>
            </div>
          </div>

          <!-- Project 5 — full-width cross-cutting card -->
          <div class="row justify-content-center mt-2">
            <div class="col-md-10">
              <div class="card" style="border-top: 4px solid #2a7a2a; overflow: hidden;">
                <a href="clinical-trials" style="text-decoration: none; color: inherit;">
                  <div class="d-flex flex-column flex-md-row">
                    <img src="/media/clinical_trials_implementation.jpeg" alt="Clinical Trials & Implementation Science"
                         style="width: 100%; max-width: 320px; height: 200px; object-fit: cover; flex-shrink: 0;">
                    <div class="card-body d-flex flex-column justify-content-center px-4 py-3">
                      <div style="font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; color: #2a7a2a; margin-bottom: 0.4rem;">Cross-cutting methodology</div>
                      <h5 class="card-title mb-2" style="font-size: 1.1rem;">Clinical Trials &amp; Implementation Science</h5>
                      <p class="card-text text-muted" style="font-size: 0.88rem; margin-bottom: 0;">
                        Our experience in Randomised trials and Implementation frameworks that translate evidence across all our research areas, from ICU telemedicine to dengue vector control.
                      </p>
                    </div>
                  </div>
                </a>
              </div>
            </div>
          </div>
        </div>
    design:
      spacing:
        padding: ["1rem", "0", "1rem", "0"]
---


      # text: |
      #   <img src="/media/banner_climatechange_ianward.jpeg" alt="Climate Change Banner" style="width: 100vw; height: auto; display: block; margin: 0; padding: 0;" />
# sections:
#   - block: markdown
#     content:
#       text: |
#         <style>
#           .force-full-width {
#             position: relative;
#             left: 50%;
#             right: 50%;
#             margin-left: -50vw;
#             margin-right: -50vw;
#             width: 100vw;
#             max-width: 100vw;
#             height: auto;
#             display: block;
#           }
#         </style>
# 
#         <img src="/media/banner_climatechange_ianward.jpg" alt="climate change banner" class="full-width-banner">