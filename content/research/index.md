---
title: Research & Initiatives
subtitle: Where we look for challenges to solve
type: landing

sections:
  - block: markdown
    content:
      title: |
        <style>
          /* Default desktop styles */
          .banner-title, .banner-text {
            margin-left: 15rem;
            max-width: 600px;
            color: black;
          }
          /* Photo credit */
          .photo-credit {
            position: absolute;
            bottom: -5rem;
            right: -4.5rem;
            font-size: 0.7rem;
            color: #ccc;
          }
          /* Mobile adjustments */
          @media (max-width: 768px) {
            .banner-title, .banner-text {
              margin-left: 5rem !important;
              max-width: 90vw;
              padding-right: 1rem;
              font-size: 1.2rem;
              color: black !important; /* Make sure color stays black */
            }
            /* Adjust photo credit */
            .photo-credit {
              bottom: -2rem;
              right: 1rem;
            }
          }
        </style>

        <div class="banner-title">Where we think on challenges to solve</div>
      text: |
        <div class="banner-text">
          We explore critical health challenges through research and data.
        </div>
        <div class="photo-credit">
          Photo by Ian Ward
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
      title: "Featured Projects"
      subtitle: "A curated selection"
      text: |
        <div class="container">
          <div class="row">
            <!-- Project 1 -->
            <div class="col-md-6 mb-4">
              <div class="card">
                <a href="link1">
                  <img src="/media/icutimpel.jpg" alt="critical care ICU EIT" class="card-img-top"  style="height: 400px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Critical Care Science & Innovation</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 2 -->
            <div class="col-md-6 mb-4">
              <div class="card">
                <a href="link2">
                  <img src="https://www.ifrc.org/sites/default/files/styles/article_press_release_featured_image/public/2024-06/p-BRA0431.jpg?" alt="climate change" class="card-img-top"  style="height: 400px; object-fit: smart;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Climate Change & Environmental Stressors</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 3 -->
            <div class="col-md-6 mb-4">
              <div class="card">
                <a href="link3">
                  <img src="https://live.staticflickr.com/65535/51614500271_3576a2364d_o.jpg" alt="Project 3" class="card-img-top"  style="height: 400px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Infectious Diseases & Vaccines</h5>
                  </div>
                </a>
              </div>
            </div>
            <!-- Project 4 -->
            <div class="col-md-6 mb-4">
              <div class="card">
                <a href="link4">
                  <img src="/media/chicken_amazon.jpg" alt="Project 4" class="card-img-top"  style="height: 400px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title text-center">Post-Acute Infection & Chronic Manifestations</h5>
                  </div>
                </a>
              </div>
            </div>
          </div>
        </div>
    design:
      spacing:
        padding: ["2rem", "0", "2rem", "0"]
---
