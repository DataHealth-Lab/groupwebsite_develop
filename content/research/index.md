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
      
        ## Problems we are currently actively working on:
        - Mechanisms by which Temperature and Air Pollutants Acutely affect Heart, Brain and Lung, and Adaptation actions
        - Epidemiology, Mechanisms and Treatment of Post-Infectious Syndromes: Chikungunya, Tuberculosis, COVID-19, and Pneumonia
        - Respiratory viruses, Dengue, HPV and Herpes-Zoster Vaccines Effectiveness and Impact
        - Innovation, Implementation and Clinical Trials in Critical Care: Telemedicine, A.I, Antimicrobial Stewardship and Resistance  
        <div class="container">
          <div class="row justify-content-center"> <!-- Added justify-content-center -->
            <!-- Project 1 -->
            <div class="col-md-5 mb-3">
              <div class="card">
                <a href="link1">
                  <img src="/media/icutimpel.jpg" alt="critical care ICU EIT" class="card-img-top"  style="height: 350px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Critical Care Science & Innovation</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 2 -->
            <div class="col-md-5 mb-3">
              <div class="card">
                <a href="link2">
                  <img src="/media/flood_brazil.jpeg" alt="climate change" class="card-img-top"  style="height: 350px; object-fit: smart;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Climate Change & Environment</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 3 -->
            <div class="col-md-5 mb-3">
              <div class="card">
                <a href="link3">
                  <img src="https://live.staticflickr.com/65535/51356159980_0c373cc805_h.jpg" alt="Project 3" class="card-img-top"  style="height: 350px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Infectious Diseases & Vaccines</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 4 -->
            <div class="col-md-5 mb-3">
              <div class="card">
                <a href="link4">
                  <img src="/media/chicken_amazon.jpg" alt="Project 4" class="card-img-top"  style="height: 350px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Post-Infectious Syndromes</h5>
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