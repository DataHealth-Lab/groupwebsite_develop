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
      text: |
        <br>
        
        Turning **DATA** into action against Climate Health threats, Superbugs, and Broken systems.  
        </br>
    # design:
    #     background:
    #         image:
    #             filename: welcome.jpg
  - block: collection
    content:
      title: Latest News
      subtitle:
      text:
      count: 5
      filters:
        author: ''
        category: ''
        exclude_featured: false
        publication_type: ''
        tag: ''
      offset: 0
      order: desc
      page_type: post
    design:
      view: card
      columns: '1'
  # 
  # - block: markdown
  #   content:
  #     title:
  #     subtitle: ''
  #     text:
  #   design:
  #     columns: '1'
  #     background:
  #       image: 
  #         filename: coders.jpg
  #         filters:
  #           brightness: 1
  #         parallax: false
  #         position: center
  #         size: cover
  #         text_color_light: true
  #     spacing:
  #       padding: ['20px', '0', '20px', '0']
  #     css_class: fullscreen

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
