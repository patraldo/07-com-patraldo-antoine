<script>
  import ArtPiece from './ArtPiece.svelte';
  // Sample artwork data - all files stored in R2, thumbnails in Cloudflare Images
  const artworks = [
    {
      id: 1,
      title: "Metamorphosis Series #1",
      type: "still",
      r2Url: "https://your-r2-bucket.r2.cloudflarestorage.com/stills/metamorphosis-1.jpg",
      thumbnailId: "thumb-meta-1", // Cloudflare Images ID for optimized thumbnail
      description: "Charcoal and digital manipulation, 2024",
      year: 2024
    },
    {
      id: 2,
      title: "Temporal Fragments",
      type: "animation",
      r2Url: "https://your-r2-bucket.r2.cloudflarestorage.com/videos/temporal-fragments.mp4",
      thumbnailId: "thumb-temporal", // Video thumbnail from Cloudflare Images
      description: "Video installation, 3:42 min, 2024",
      year: 2024
    },
    {
      id: 3,
      title: "Memory Loop",
      type: "gif",
      r2Url: "https://your-r2-bucket.r2.cloudflarestorage.com/gifs/memory-loop.gif",
      thumbnailId: "thumb-memory", // Static thumbnail of the GIF
      description: "Animated sequence, 2024",
      year: 2024
    },
    {
      id: 4,
      title: "Digital Archaeology",
      type: "still",
      r2Url: "https://your-r2-bucket.r2.cloudflarestorage.com/stills/digital-archaeology.jpg",
      thumbnailId: "thumb-arch", 
      description: "Mixed media on canvas, 2024",
      year: 2024
    },
    {
      id: 5,
      title: "Fluid Motion Study",
      type: "animation",
      r2Url: "https://your-r2-bucket.r2.cloudflarestorage.com/videos/fluid-motion.mp4",
      thumbnailId: "thumb-fluid",
      description: "Video study, 1:20 min, 2023",
      year: 2023
    },
    {
      id: 6,
      title: "Glitch Portrait",
      type: "gif",
      r2Url: "https://your-r2-bucket.r2.cloudflarestorage.com/gifs/glitch-portrait.gif",
      thumbnailId: "thumb-glitch",
      description: "Digital manipulation, 2023",
      year: 2023
    }
  ];
  // Cloudflare Images base URL for thumbnails only
  const CF_IMAGES_BASE = "https://imagedelivery.net/your-account-hash";
  let selectedType = 'all';
  // Filter artworks based on selected type
  $: filteredArtworks = selectedType === 'all' 
    ? artworks 
    : artworks.filter(artwork => artwork.type === selectedType);
  // Get unique types for filter dropdown
  const artworkTypes = [
    { value: 'all', label: 'All Work' },
    { value: 'still', label: 'Still Images' },
    { value: 'animation', label: 'Videos' },
    { value: 'gif', label: 'Animated GIFs' }
  ];
</script>
<div class="gallery">
  <div class="container">
    <div class="header">
      <h3>Recent Work</h3>
      <!-- Filter Dropdown -->
      <div class="filter-container">
        <select bind:value={selectedType} class="filter-select">
          {#each artworkTypes as type}
            <option value={type.value}>{type.label}</option>
          {/each}
        </select>
      </div>
    </div>
    <div class="grid">
      {#each filteredArtworks as artwork (artwork.id)}
        <ArtPiece {artwork} {CF_IMAGES_BASE} />
      {/each}
    </div>
    {#if filteredArtworks.length === 0}
      <div class="no-results">
        <p>No {selectedType} artworks to display yet.</p>
      </div>
    {/if}
  </div>
</div>
<style>
  .gallery {
    padding: 2rem 0;
  }
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
  }
  .header {
    text-align: center;
    margin-bottom: 3rem;
  }
  h3 {
    font-size: 2.5rem;
    font-weight: 200;
    margin-bottom: 2rem;
    color: #2a2a2a;
  }
  .filter-container {
    display: flex;
    justify-content: center;
    margin-bottom: 1rem;
  }
  .filter-select {
    padding: 0.75rem 1.5rem;
    font-size: 1rem;
    border: 2px solid #e0e0e0;
    border-radius: 6px;
    background: white;
    color: #2a2a2a;
    cursor: pointer;
    outline: none;
    transition: border-color 0.3s, box-shadow 0.3s;
    font-family: inherit;
  }
  .filter-select:hover {
    border-color: #667eea;
  }
  .filter-select:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
  }
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 2rem;
    transition: all 0.3s ease;
  }
  .no-results {
    text-align: center;
    padding: 4rem 0;
    color: #666;
    font-style: italic;
  }
  @media (max-width: 768px) {
    .container {
      padding: 0 1rem;
    }
    .grid {
      grid-template-columns: 1fr;
      gap: 1.5rem;
    }
    h3 {
      font-size: 2rem;
    }
  }
</style>
