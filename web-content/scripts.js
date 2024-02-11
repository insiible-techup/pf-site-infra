  // Function to handle smooth scrolling
  function smoothScroll(target) {
    const element = document.querySelector(target);
    if (element) {
      window.scrollTo({
        top: element.offsetTop,
        behavior: "smooth" // Add smooth scrolling behavior
      });
    }
  }

  // Add click event listeners to the navigation links
  document.querySelectorAll("nav a").forEach(anchor => {
    anchor.addEventListener("click", function(e) {
      e.preventDefault();
      const targetId = this.getAttribute("href");
      smoothScroll(targetId);
    });
  });
        let slideIndex = 0; // Start at the first slide (index 0)
        showSlide();

        function changeSlide(n) {
            showSlide(slideIndex += n);
        }

        function showSlide() {
            let i;
            const slides = document.getElementsByClassName("slider-image");
            if (slideIndex >= slides.length) {
                slideIndex = 0; // Start over from the first slide
            }
            if (slideIndex < 0) {
                slideIndex = slides.length - 1; // Go to the last slide if at the beginning
            }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slides[slideIndex].style.display = "block";

            // Auto-advance the slider every 3 seconds (adjust as needed)
            setTimeout(changeSlide.bind(null, 1), 3000);
        }

        function adjustFontSize() {
            // Define the base font size (change as needed)
            const baseFontSize = 16; // In pixels

            // Get the current screen width
            const screenWidth = window.innerWidth;

            // Define breakpoints and corresponding font size multipliers
            const breakpoints = [
                { width: 320, multiplier: 0.8 },
                { width: 480, multiplier: 0.9 },
                { width: 768, multiplier: 1 }, // Default font size at this breakpoint
                { width: 1024, multiplier: 1.2 },
            ];

            // Calculate the font size multiplier based on the screen width
            let fontSizeMultiplier = 1;
            for (const breakpoint of breakpoints) {
                if (screenWidth < breakpoint.width) {
                    break;
                }
                fontSizeMultiplier = breakpoint.multiplier;
            }

            // Calculate the new font size
            const newFontSize = baseFontSize * fontSizeMultiplier;

            // Apply the new font size to the body element
            document.body.style.fontSize = `${newFontSize}px`;
        }

        // Call the adjustFontSize function when the page loads and when the window is resized
        window.addEventListener('load', adjustFontSize);
        window.addEventListener('resize', adjustFontSize);

        document.addEventListener('DOMContentLoaded', function () {
          // Main Navigation
          const burgerMenu = document.querySelector('.burger-menu');
          const navMenu = document.querySelector('.sticky-nav');
      
          burgerMenu.addEventListener('click', function () {
              navMenu.classList.toggle('show-nav');
          });
      
          // Footer Navigation
          const footerBurgerMenu = document.querySelector('.footer-burger-menu');
          const footerNavMenu = document.querySelector('.footer-nav');
      
          footerBurgerMenu.addEventListener('click', function () {
              footerNavMenu.classList.toggle('show-nav');
          });
      });
      