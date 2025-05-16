<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>CineCritique - Upcoming Movies</title>
  <style>
    :root {
      --black: #0f0f0f;
      --dark-red: #8b0000;
      --red-hover: #a30000;
      --gray-bg: #1a1a1a;
      --white: #ffffff;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      background-color: var(--black);
      color: var(--white);
      font-family: 'Segoe UI', sans-serif;
    }

    header {
      background-color: var(--dark-red);
      padding: 20px 0;
      text-align: center;
    }

    header h1 {
      font-size: 2.8rem;
      color: var(--white);
      letter-spacing: 3px;
    }

    nav {
      background-color: var(--black);
      padding: 10px 0;
    }

    nav a {
      color: var(--white);
      margin: 0 15px;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s;
    }

    nav a:hover {
      color: var(--red-hover);
    }

    .section-title {
      background-color: var(--gray-bg);
      color: var(--dark-red);
      text-align: center;
      padding: 15px;
      font-size: 1.8rem;
      margin-top: 30px;
      letter-spacing: 1px;
    }

    .search-filters {
      display: flex;
      justify-content: center;
      gap: 15px;
      padding: 25px 0;
      background: var(--gray-bg);
      box-shadow: 0 2px 5px rgba(255, 0, 0, 0.05);
    }

    .search-filters input,
    .search-filters select {
      padding: 12px;
      width: 220px;
      background-color: var(--black);
      color: var(--white);
      border: 1px solid var(--dark-red);
      border-radius: 6px;
      font-size: 1em;
    }

    .highlighted-movie {
      background-color: var(--gray-bg);
      color: var(--white);
      max-width: 750px;
      margin: 30px auto;
      padding: 30px;
      text-align: center;
      border-radius: 10px;
      border: 1px solid var(--dark-red);
    }

    .highlighted-movie h3 {
      font-size: 1.6rem;
      margin-bottom: 10px;
      color: var(--dark-red);
    }

    .movie-cards {
      display: flex;
      overflow-x: auto;
      gap: 30px;
      padding: 40px;
      max-width: 100%;
      margin: auto;
      scroll-behavior: smooth;
    }

    .movie-cards::-webkit-scrollbar {
      height: 10px;
    }

    .movie-cards::-webkit-scrollbar-thumb {
      background-color: var(--dark-red);
      border-radius: 10px;
    }

    a.card-link {
      text-decoration: none;
      color: inherit;
    }

    .card {
      background-color: var(--gray-bg);
      border: 1px solid var(--dark-red);
      border-radius: 12px;
      padding: 20px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      min-width: 250px;
      max-width: 250px;
      flex: 0 0 auto;
    }

    .card:hover {
      transform: scale(1.03);
      box-shadow: 0 0 15px var(--dark-red);
    }

    .card p {
      margin: 10px 0;
    }

    .card p strong {
      color: var(--dark-red);
      font-size: 1.1em;
    }

    /* Added image styling */
    .card img {
      width: 100%;
      height: auto;
      border-radius: 6px;
      margin-bottom: 15px;
    }

    footer {
      background-color: var(--dark-red);
      color: var(--white);
      padding: 15px;
      text-align: center;
      margin-top: 40px;
    }
  </style>
</head>
<body>

  <header>
    <h1>CINECRITIQUE</h1>
    <nav>
      <a href="#">Movies</a>
      <a href="#">Upcoming</a>
      <span>User: Sangam Sunar</span>
    </nav>
  </header>

  <div class="section-title">UPCOMING MOVIES</div>

  <div class="search-filters">
    <input type="text" placeholder="Search by title...">
    <select>
      <option>Filter by Genre</option>
      <option>Action</option>
      <option>Drama</option>
      <option>Comedy</option>
    </select>
  </div>

  <div class="section-title">MOST ANTICIPATED MOVIES</div>

  <div class="highlighted-movie">
    <h3>Sons of the Neon Night</h3>
    <p>A detective faces off against a successor of a drug syndicate who seeks to bring anarchy to Hong Kong by pushing for a drug-free society through chaos.</p>
  </div>

  <div class="movie-cards">
    <a class="card-link" href="#">
      <div class="card">
        <!-- Image added to movie card -->
        <img src="image/hero.webp" alt="Heropanti 2 Poster">
        <p><strong>Heropanti 2</strong></p>
        <p>Release Date: 2026-07-27</p>
        <p>Cast: Salman Khan</p>
        <p>Director: Ahmed Khan</p>
        <p><strong>Description:</strong> A young man uses tech and martial arts to fight injustice...</p>
      </div>
    </a>

    <a class="card-link" href="#">
      <div class="card">
        <!-- Image added to movie card -->
        <img src="image/hero.webp" alt="Tiger Zinda 4 Poster">
        <p><strong>Tiger Zinda 4</strong></p>
        <p>Release Date: 2026-08-29</p>
        <p>Cast: Shahrukh Khan</p>
        <p>Director: Kabir Khan</p>
        <p><strong>Description:</strong> RAW agent returns to face his deadliest mission yet...</p>
      </div>
    </a>
    <a class="card-link" href="#">
      <div class="card">
        <!-- Image added to movie card -->
        <img src="image/hero.webp" alt="Tiger Zinda 4 Poster">
        <p><strong>Tiger Zinda 4</strong></p>
        <p>Release Date: 2026-08-29</p>
        <p>Cast: Shahrukh Khan</p>
        <p>Director: Kabir Khan</p>
        <p><strong>Description:</strong> RAW agent returns to face his deadliest mission yet...</p>
      </div>
    </a>
    <a class="card-link" href="#">
      <div class="card">
        <!-- Image added to movie card -->
        <img src="image/hero.webp" alt="Tiger Zinda 4 Poster">
        <p><strong>Tiger Zinda 4</strong></p>
        <p>Release Date: 2026-08-29</p>
        <p>Cast: Shahrukh Khan</p>
        <p>Director: Kabir Khan</p>
        <p><strong>Description:</strong> RAW agent returns to face his deadliest mission yet...</p>
      </div>
    </a>
  </div>

  <footer>
    &copy; 2025 CineCritique. All rights reserved.
  </footer>

</body>
</html>
