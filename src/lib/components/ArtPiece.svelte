<!-- my-art-site/src/lib/components/ArtPiece.svelte -->
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
  function handleClick(event) {
    if (artwork.type === 'still') {
      event.preventDefault();
      showFullSize = true;
    }
  }

  // Close full-size view
  function closeFullSize(event) {
    event.preventDefault();
    showFullSize = false;
  }

  // Handle keyboard events for media container
  function handleMediaKeydown(event) {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      handleClick(event);
    }
  }

  // Handle keyboard events for overlay
  function handleOverlayKeydown(event) {
    if (event.key === 'Escape') {
      closeFullSize(event);
    } else if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      closeFullSize(event);
    }
  }
</script>

<div class="art-piece">
  <!-- 1. Media container: clickable div with full keyboard support -->
  <div
    class="media-container"
    on:click={handleClick}
    on:keydown={handleMediaKeydown}
    role="button"
    tabindex="0"
    aria-label="View full size of {artwork.title}"
  >
    {#if artwork.type === 'still'}
      <!-- Show thumbnail from Cloudflare Images, full-size from R2 -->
      <img 
        src={getThumbnailUrl(artwork.thumbnailId, 'gallery')}
        alt={artwork.title}
        loading="lazy"
      />
      {#if showFullSize}
        <!-- Full-size overlay -->
        <div
          class="fullsize-overlay"
          on:click={closeFullSize}
          on:keydown={handleOverlayKeydown}
          role="button"
          tabindex="0"
          aria-label="Close full size view"
        >
          <!-- svelte-ignore a11y_no_static_element_interactions -->
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
            <button class="close-btn" on:click={closeFullSize} aria-label="Close">&times;</button>
          </div>
        </div>
      {/if}
    {:else if artwork.type === 'animation'}
      <!-- svelte-ignore a11y_media_has_caption -->
      <video 
        src={artwork.r2Url}
        poster={getThumbnailUrl(artwork.thumbnailId, 'poster')}
        controls
        preload="metadata"
        aria-label="Video artwork: {artwork.title}"
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
  /* Your existing styles remain unchanged */
</style>
