---
title: Contact
date: 2022-10-24

type: landing

sections:
  - block: contact
    content:
      title: Visit Us
      text: |-
        If you want to visit us, find us, etc.

      email: labdatahealth at gmail dot com
      address:
        street: Carrer de Sant Quintí, 77-79
        city: Barcelona
        region: Catalonia
        postcode: '08041'
        country: Spain
        country_code: ES
      coordinates:
        latitude: '41.41517420645786'
        longitude: '2.1756747530393192'
      directions: Enter Sant Pau Research Institute Building, Office P3-035 on Floor 3
      
      #contact_links:
      #  - icon: comments
      #    icon_pack: fas
      #    name: Discuss on Forum
      #    link: 'https://discourse.gohugo.io'
    
      # Automatically link email and phone or display as text?
      autolink: true
    
      # Email form provider
      #form:
      #  provider: netlify
      #  formspree:
      #    id:
      #  netlify:
      #    # Enable CAPTCHA challenge to reduce spam?
      #    captcha: false
    design:
      columns: '1'
  - block: markdown
    content:
      title:
      subtitle: ''
      text:
    design:
      columns: '1'
      background:
        image: 
          filename: contact.jpg
          filters:
            brightness: 1
          parallax: false
          position: center
          size: cover
          text_color_light: true
      spacing:
        padding: ['10px', '0', '10px', '0']
      css_class: fullscreen
---