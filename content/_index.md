---
# Leave the homepage title empty to use the site title
title:
date: 2022-10-24
type: landing

sections:
  - block: hero
    content:
      title: |
        
        Science for Better Health
      image:
        filename: welcome.jpg
      # text: |
      #   Turning **DATA** into action against Climate Health threats, Superbugs, and Broken systems.

  - block: collection
    content:
      title: Latest News
      subtitle:
      text:
      count: 6
      filters:
        author: ''
        category: ''
        exclude_featured: false
        publication_type: ''
        tag: ''
      order: desc
      page_type: post
    design:
      view: compact
      columns: '3'

  # - block: collection
  #   content:
  #     title: Latest Preprints
  #     text: ""
  #     count: 5
  #     filters:
  #       folders:
  #         - publication
  #       publication_type: 'article'
  #   design:
  #     view: citation
  #     columns: '1'

  - block: markdown
    content:
      title:
      subtitle:
      text: |
        <div style="display: flex; justify-content: center; gap: 1rem;">
        {{% cta cta_link="./people/" cta_text="Meet the team →" %}}
        {{% cta cta_link="./research/" cta_text="We’re working on →" %}}
        {{% cta cta_link="./join/" cta_text="Join Us →" %}}
    design:
      columns: '1'
---
