DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>CineCritique - Upcoming Movies</title>
  <style>
    :root {
      --primary-color: #003366;
      --secondary-color: #003366;
      --accent-color: #ff5722;
      --background-color: #f5f5f5;
      --text-color: #333333;
    }

    {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      background-color: var(--background-color);
      color: var(--text-color);
      font-family: 'Segoe UI', sans-serif;
    }

    #bgVideo {
      position: fixed;
      top: 0;
      left: 0;
      min-width: 100vw;
      min-height: 100vh;
      z-index: -1;
      object-fit: cover;
      opacity: 0.25;
    }

    header {
      background-color: rgba(0, 123, 255, 0.85);
      padding: 20px 0;
      text-align: center;
    }

    header h1 {
      font-size: 3rem;
      color: #ffffff;
      letter-spacing: 4px;
    }

    nav {
      background-color: rgba(0, 51, 102, 0.9);
      padding: 10px 0;
    }

    nav a {
      color: #ffffff;
      margin: 0 15px;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s;
    }

    nav a:hover {
      color: var(--accent-color);
    }

    nav span {
      color: #ffffff;
      margin-left: 20px;
      font-weight: bold;
    }

    .section-title {
      background-color: transparent;
      color: var(--text-color);
      text-align: center;
      padding: 15px;
      font-size: 2.2rem;
      font-weight: bold;
      margin-top: 30px;
      letter-spacing: 1px;
      text-transform: uppercase;
      border-bottom: 2px solid var(--accent-color);
      width: fit-content;
      margin-left: auto;
      margin-right: auto;
    }

    .search-filters {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 15px;
      padding: 25px 0;
      background: #ffffff;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .search-filters input,
    .search-filters select {
      padding: 12px;
      width: 220px;
      background-color: #f1f1f1;
      color: var(--text-color);
      border: 1px solid var(--primary-color);
      border-radius: 6px;
      font-size: 1em;
    }

    .highlighted-movie {
      background-color: #ffffff;
      color: var(--text-color);
      max-width: 750px;
      margin: 30px auto;
      padding: 30px;
      text-align: center;
      border-radius: 10px;
      border: 1px solid var(--primary-color);
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .highlighted-movie h3 {
      font-size: 1.8rem;
      margin-bottom: 10px;
      color: var(--primary-color);
    }

    .movie-slider-container {
      position: relative;
      max-width: 100%;
      overflow: hidden;
      margin: 0 auto;
    }

    .movie-cards {
      display: flex;
      overflow-x: auto;
      gap: 30px;
      padding: 40px 20px;
      scroll-behavior: smooth;
    }

    .movie-cards::-webkit-scrollbar {
      height: 10px;
    }

    .movie-cards::-webkit-scrollbar-thumb {
      background-color: var(--primary-color);
      border-radius: 10px;
    }

    a.card-link {
      text-decoration: none;
      color: inherit;
    }

    .card {
      background-color: #ffffff;
      border: 1px solid var(--primary-color);
      border-radius: 12px;
      padding: 20px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      min-width: 250px;
      max-width: 250px;
      flex: 0 0 auto;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      margin-left: 5px;
      margin-right: 5px;
    }

    .card:hover {
      transform: scale(1.03);
      box-shadow: 0 0 15px var(--primary-color);
    }

    .card img {
      width: 100%;
      height: auto;
      border-radius: 6px;
      margin-bottom: 15px;
    }

    .card p {
      margin: 10px 0;
    }

    .card p strong {
      color: var(--primary-color);
      font-size: 1.1em;
    }

    .slider-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background-color: var(--primary-color);
      color: #ffffff;
      border: none;
      font-size: 2rem;
      padding: 10px;
      cursor: pointer;
      z-index: 10;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .slider-btn:hover {
      background-color: var(--accent-color);
      transform: scale(1.1);
    }

    .left-btn {
      left: 10px;
    }

    .right-btn {
      right: 10px;
    }

    footer {
      background-color: var(--primary-color);
      color: #ffffff;
      padding: 15px;
      text-align: center;
      margin-top: 40px;
    }

    .movie {
      padding: 20px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border-radius: 12px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .movie:hover {
      transform: scale(1.05);
      box-shadow: 0 0 15px var(--primary-color);
    }
  </style>
</head>
<body>

  <!-- Background Video -->
  <video autoplay muted loop id="bgVideo">
    <!-- Your background video source can go here -->
  </video>

  <!-- Header and navigation -->
  <header>
    <h1>CINECRITIQUE</h1>
    <nav>
      <a href="#">Movies</a>
      <a href="#">Upcoming</a>
      <span>User: Sangam Sunar</span>
    </nav>
  </header>

  <!-- Search bar -->
  <div class="search-filters">
    <input type="text" placeholder="Search by title...">
    <select>
      <option>Filter by Genre</option>
      <option>Action</option>
      <option>Drama</option>
      <option>Comedy</option>
    </select>
  </div>

  <!-- Highlighted movie -->
  <div class="highlighted-movie">
    <video autoplay muted controls>
      <source src="/videos/upcomingvideo.mp4" type="video/mp4">
      Your browser does not support the video tag.
    </video>
    <h3>Sons of the Neon Night</h3>
    <p>A detective faces off against a successor of a drug syndicate who seeks to bring anarchy to Hong Kong by pushing for a drug-free society through chaos.</p>
  </div>

  <!-- Updated Section Title -->
  <div class="section-title">UPCOMING MOVIES</div>

  <!-- Movie Slider -->
  <div class="movie-slider-container">
    <button class="slider-btn left-btn">&#10094;</button>
    <div class="movie-cards" id="movieSlider">
      <!-- Movie Cards -->
      <a class="card-link" href="#">
        <div class="card movie">
          <img src="image/hero.webp" alt="Heropanti 2">
          <p><strong>The Flash</strong></p>
          <p>Release Date: 2026-07-27</p>
          <p>Cast:  Tom Holland, Zendaya</p>
          <p>Director:  Shawn Levy</p>
          <p>Country: USA</p>
          <p>Genre: Action</p>
          </p>description: A retired spy is forced back into the shadows to stop a global terror threat.</p>
        </div>
      </a>
      <a class="card-link" href="#">
        <div class="card movie">
          <img src="image/hero.webp" alt="Tiger 3">
          <p><strong>The Marvels</strong></p>
          <p>Release Date: 2025-12-25</p>
          <p>Cast: Katrina Kaif, Chris Hemsworth</p>
          <p>Director:  James Gunn</p>
          <p>Country: Australia</p>
          <p>Genre: Thriller</p>
          </p>description: A secret agent races against time to prevent a catastrophic attack on global security.</p>
        </div>
      </a>
      <a class="card-link" href="#">
        <div class="card movie">
          <img src="image/hero.webp" alt="Pathaan">
          <p><strong>Deadpool 3</strong></p>
          <p>Release Date: 2025-11-10</p>
          <p>Cast: Bradley Cooper, Deepika Padukone</p>
          <p>Director: Tony Scott</p>
          <p>Country: India</p>
          <p>Genre: War</p>
         </p>description: An elite fighter pilot embarks on a dangerous mission to uncover military corruption.</p>
        </div>
      </a>
      <a class="card-link" href="#">
        <div class="card movie">
          <img src="image/hero.webp" alt="Fighter">
          <p><strong>Fighter</strong></p>
          <p>Release Date: 2025-08-18</p>
          <p>Cast: Henry Cavill, Michael Fassbender</p>
          <p>Director: Matt Reeves</p>
          <p>Country: UK</p>
          <p>Genre: Action</p>
          </p>description: A futuristic soldier awakens in a dystopian world where technology rules minds.</p>
        </div>
      </a>
      <a class="card-link" href="#">
        <div class="card movie">
          <img src="image/hero.webp" alt="Jawan">
          <p><strong>Avatar 3</strong></p>
          <p>Release Date: 2025-09-09</p>
          <p>Cast: Eva Green, Pedro Pascal</p>
          <p>Director: Atlee</p>
          <p>Country: USA</p>
          <p>Genre: Thriller</p>
         </p>description: A troubled ex-soldier seeks redemption in a futuristic society, where technology is both a weapon and a curse.</p>

        </div>
      </a>
    </div>
    <button class="slider-btn right-btn">&#10095;</button>
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 CineCritique. All rights reserved.
  </footer>

  <!-- Slider JS -->
  <script>
    const movieSlider = document.getElementById('movieSlider');
    const scrollAmount = 300;

    document.querySelector('.left-btn').addEventListener('click', () => {
      movieSlider.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
    });

    document.querySelector('.right-btn').addEventListener('click', () => {
      movieSlider.scrollBy({ left: scrollAmount, behavior: 'smooth' });
    });
  </script>
</body>
</html>
