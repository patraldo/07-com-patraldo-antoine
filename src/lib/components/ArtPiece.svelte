<script>
  export let artwork;
  export let CF_IMAGES_BASE;
  let showFullSize = false;
  let isLoading = false;
  // Build Cloudflare Images URL for thumbnails only
  function getThumbnailUrl(thumbnailId, variant = 'thumbnail') {
    return `${CF_IMAGES_BASE}/${thumbnailId}/${variant}`;
  }
  // Handle click to show full-size version
  function handleClick() {
    if (artwork.type === 'still') {
      showFullSize = true;
    }
    // For videos and gifs, they already show the full version inline
  }
  // Close full-size view
  function closeFullSize() {
    showFullSize = false;
  }
</script>
<div class="art-piece">
  <div class="media-container" on:click={handleClick} role="button" tabindex="0">
    {#if artwork.type === 'still'}
      <!-- Show thumbnail from Cloudflare Images, full-size from R2 -->
      <img 
        src={getThumbnailUrl(artwork.thumbnailId, 'gallery')}
        alt={artwork.title}
        loading="lazy"
      />
      {#if showFullSize}
        <!-- Full-size overlay -->
        <div class="fullsize-overlay" on:click={closeFullSize} role="button" tabindex="0">
          <div class="fullsize-content" on:click|stopPropagation>
            {#if isLoading}
              <div class="loading">Loading full resolution...</div>
            {/if}
            <img 
              src={artwork.r2Url}
              alt={artwork.title}
              on:load={() => isLoading = false}
              on:error={() => isLoading = false}
            />
            <button class="close-btn" on:click={closeFullSize}>&times;</button>
          </div>
        </div>
      {/if}
    {:else if artwork.type === 'animation'}
      <!-- Show thumbnail as poster, full video from R2 -->
      <video 
        src={artwork.r2Url}
        poster={getThumbnailUrl(artwork.thumbnailId, 'poster')}
        controls
        preload="metadata"
      >
        Your browser doesn't support video.
      </video>
    {:else if artwork.type === 'gif'}
      <!-- Show static thumbnail, full GIF from R2 on hover -->
      <div class="gif-container">
        <img 
          class="gif-thumbnail"
          src={getThumbnailUrl(artwork.thumbnailId, 'static')}
          alt={artwork.title}
          loading="lazy"
        />
        <img 
          class="gif-animated"
          src={artwork.r2Url}
          alt={artwork.title}
          loading="lazy"
        />
      </div>
    {/if}
  </div>
  <div class="info">
    <h4>{artwork.title}</h4>
    <p>{artwork.description}</p>
    <span class="type-badge {artwork.type}">
      {#if artwork.type === 'still'}
        📷 Still
      {:else if artwork.type === 'animation'}
        🎬 Video
      {:else if artwork.type === 'gif'}
        🎭 Animated
      {/if}
    </span>
    {#if artwork.type === 'still'}
      <span class="click-hint">Click to view full size</span>
    {/if}
  </div>
</div>
<style>
  .art-piece {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    transition: transform 0.3s, box-shadow 0.3s;
    position: relative;
  }
  .art-piece:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
  }
  .media-container {
    aspect-ratio: 4/3;
    overflow: hidden;
    background: #f8f9fa;
    position: relative;
  }
  .media-container[role="button"] {
    cursor: pointer;
  }
  img, video {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: scale 0.3s;
  }
  .art-piece:hover img,
  .art-piece:hover video {
    scale: 1.05;
  }
  /* GIF container with hover effect */
  .gif-container {
    position: relative;
    width: 100%;
    height: 100%;
  }
  .gif-thumbnail {
    position: absolute;
    top: 0;
    left: 0;
    opacity: 1;
    transition: opacity 0.3s;
  }
  .gif-animated {
    position: absolute;
    top: 0;
    left: 0;
    opacity: 0;
    transition: opacity 0.3s;
  }
  .gif-container:hover .gif-thumbnail {
    opacity: 0;
  }
  .gif-container:hover .gif-animated {
    opacity: 1;
  }
  /* Full-size overlay */
  .fullsize-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: rgba(0, 0, 0, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    cursor: pointer;
  }
  .fullsize-content {
    position: relative;
    max-width: 90vw;
    max-height: 90vh;
    cursor: default;
  }
  .fullsize-content img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
  }
  .close-btn {
    position: absolute;
    top: -40px;
    right: 0;
    background: none;
    border: none;
    color: white;
    font-size: 3rem;
    cursor: pointer;
    line-height: 1;
  }
  .loading {
    color: white;
    text-align: center;
    padding: 2rem;
  }
  .info {
    padding: 1.5rem;
    position: relative;
  }
  h4 {
    margin: 0 0 0.5rem 0;
    font-size: 1.3rem;
    font-weight: 400;
    color: #2a2a2a;
  }
  p {
    margin: 0 0 1rem 0;
    color: #666;
    font-size: 0.95rem;
    font-style: italic;
  }
  .type-badge {
    position: absolute;
    top: 1rem;
    right: 1rem;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    letter-spacing: 0.5px;
  }
  .type-badge.still {
    background: #e3f2fd;
    color: #1565c0;
  }
  .type-badge.animation {
    background: #f3e5f5;
    color: #7b1fa2;
  }
  .type-badge.gif {
    background: #e8f5e8;
    color: #2e7d32;
  }
  .click-hint {
    font-size: 0.8rem;
    color: #999;
    font-style: italic;
  }
  @media (max-width: 768px) {
    .fullsize-content {
      max-width: 95vw;
      max-height: 95vh;
    }
    .close-btn {
      top: -30px;
      font-size: 2rem;
    }
  }
</style>
