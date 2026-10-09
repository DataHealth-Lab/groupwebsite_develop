---
title: Contact/Join us
date: 2022-10-24
aliases:
  - /join/

type: landing

sections:
  - block: slider
    content:
      slides:
      - title: 👋 Welcome to the group
        content: Take a look at what we're working on...
        align: center
        background:
          image:
            filename: contact.jpg
            filters:
              brightness: 0.7
          position: right
          color: '#666'
      - title: Lunch & Learn ☕️
        content: Health’s biggest fights need your brain... and your hands.
        align: left
        background:
          image:
            filename: ocean_climatechange_ianward_bw.jpeg
            filters:
              brightness: 0.7
          position: center
          color: '#555'
      - title: Global, World-Class Lab for Science and Health
        content: 'We’re always seeking talented and innovative minds.'
        align: right
        background:
          image:
            filename: welcome.jpg
            filters:
              brightness: 0.5
          position: center
          color: '#333'
    design:
      slide_height: '500px'
      is_fullscreen: false
      # Automatically transition through slides
      loop: true
      interval: 3500
  - block: markdown
    id: jobs
    content:
      title: "Jobs"
      subtitle: "Current Openings"
      text: |
        We periodically have openings for **Postdoctoral Researchers**, **PhD Students**, and **Research Assistants**.
        
        Even when no formal calls are active, feel free to send your CV and research interests to [DataHealth Lab](mailto:labdatahealth@gmail.com) for future opportunities.  
        <br>
        **Regularly check:**  
        • [Euraxess](https://euraxess.ec.europa.eu/)  
        • [IR SANT PAU Careers](https://www.recercasantpau.cat/en/the-institute/human-resources/job-openings/)  
        • This page (regularly updated)     
        <br>
      columns: '1'
  - block: markdown
    content:
      title: "Personal Fellowships"
      subtitle: "Seeking motivated researchers!"
      text: |
        ### We Support Your Fellowship Applications
  
         If you're interested in applying for your own funding, we <span style="color: #2a5c99; font-weight: 600;">welcome your initiative</span> and provide full institutional support.
         #### Popular Fellowship Programmes:
         - **Marie Skłodowska-Curie Actions** (Postdoctoral Fellowships)  
         - **European Respiratory Society (ERS)** Fellowships  
         - **CAPES PrInt** (Brazilian researchers)  
         - National fellowships from your home country
  
         #### Our Support Includes:
         ✓ Project development guidance  
         ✓ Administrative assistance  
         ✓ Access to research facilities  
         ✓ Mentorship throughout the process  
         <br>
         **Next Steps:** Please prepare a 1-page research concept and your CV, then [email me](mailto:oranzani@santpau.cat) to discuss possibilities.
    design:
      columns: '1'

  - block: contact
    content:
      title: Visit us
      subtitle: ":recycle: The IR building received LEED Gold certification from the U.S. Green Building Council for its sustainability :seedling:"
      text: |-
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
        padding: ['20px', '0', '20px', '0']
      css_class: fullscreen
---