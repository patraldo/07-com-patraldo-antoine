<script>
  import Gallery from '$lib/components/Gallery.svelte';
  import EmailSignup from '$lib/components/EmailSignup.svelte';
</script>
<svelte:head>
  <title>Antoine Patraldo - Visual Artist</title>
  <meta name="description" content="Contemporary visual artist specializing in mixed media, digital art, and experimental forms." />
</svelte:head>
<!-- Hero Section -->
<section class="hero">
  <div class="hero-content">
    <h2>Visual Narratives</h2>
    <p>Exploring the intersection of digital and traditional media</p>
  </div>
</section>
<!-- Gallery Section -->
<section id="work" class="work-section">
  <Gallery />
</section>
<!-- About Section -->
<section id="about" class="about-section">
  <div class="container">
    <div class="about-content">
      <h3>About</h3>
      <p>
        I create visual narratives that blur the boundaries between digital and physical spaces. 
        My work explores themes of identity, memory, and transformation through drawings, 
        video installations, and experimental digital media.
      </p>
      <p>
        Currently based in Brooklyn, NY, I exhibit internationally and collaborate 
        with musicians, writers, and technologists on interdisciplinary projects.
      </p>
    </div>
  </div>
</section>
<!-- Email Signup Section -->
<section id="contact" class="signup-section">
  <div class="container">
    <h3>Stay Connected</h3>
    <p>Get updates about new work, exhibitions, and studio insights.</p>
    <EmailSignup />
  </div>
</section>
<style>
  .hero {
    height: 70vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-align: center;
  }
  .hero-content h2 {
    font-size: 3.5rem;
    font-weight: 100;
    margin: 0 0 1rem 0;
    letter-spacing: 3px;
  }
  .hero-content p {
    font-size: 1.2rem;
    font-weight: 300;
    opacity: 0.9;
  }
  .work-section {
    padding: 4rem 0;
  }
  .about-section {
    padding: 4rem 0;
    background: white;
  }
  .signup-section {
    padding: 4rem 0;
    background: #f8f9fa;
    text-align: center;
  }
  .container {
    max-width: 800px;
    margin: 0 auto;
    padding: 0 2rem;
  }
  .about-content {
    max-width: 600px;
    margin: 0 auto;
  }
  h3 {
    font-size: 2.5rem;
    font-weight: 200;
    margin-bottom: 2rem;
    text-align: center;
  }
  .about-content p {
    font-size: 1.1rem;
    margin-bottom: 1.5rem;
    color: #555;
  }
  .signup-section h3 {
    margin-bottom: 1rem;
  }
  .signup-section p {
    margin-bottom: 2rem;
    color: #666;
    font-size: 1.1rem;
  }
  @media (max-width: 768px) {
    .hero-content h2 {
      font-size: 2.5rem;
    }
    h3 {
      font-size: 2rem;
    }
    .container {
      padding: 0 1rem;
    }
  }
</style>
