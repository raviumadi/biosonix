---
layout: page
title: "Resources"
permalink: /Resources/
---

<!-- {% include under-construction.html%} -->

<!-- <html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Audio Player</title>
</head>
<body>
    <h1>My Audio Files</h1>

    <h2>Audio 1</h2>
    <audio controls>
        <source src="/assets/audio/BatCallSeq_PostCallsBeforeEchoes.wav" type="audio/wav">
        Your browser does not support the audio element.
    </audio>
<p>This is the caption for Audio 1. You can add a description or any relevant information here.</p>

    <h2>Audio 2</h2>
    <audio controls>
        <source src="/assets/audio/koel_kgd_22062023.wav" type="audio/wav">
        Your browser does not support the audio element.
    </audio>

    <!-- Add more audio files and descriptions as needed -->
<!-- </body>
</html> --> 

<style>
  .audio-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 2rem;
    padding: 1rem;
  }
  
  .description, .audio-player {
    flex: 1;
    padding: 1rem;
  }

  .description {
    border-right: 1px solid #ddd;
  }
  
  audio {
    width: 100%;
  }

  .bottom-line {
    margin-top: 5px;
    margin-bottom: 10px;
  }
</style>

<div class="audio-container">
  <!-- Technical Description Column -->
  <div class="description">
    <!-- <h5>Technical Description</h5> -->
    <p>
      Lorem ipsum dolor sit amet,
    </p>
    <!-- You can continue to add more details or other elements here -->
  </div>

  <!-- Audio Player Column -->
  <div class="audio-player">
    <!-- <h2>Listen to the Audio</h2> -->
    <audio controls>
      <source src="/assets/audio/koel_kgd_22062023.wav" type="audio/mpeg">
      Your browser does not support the audio element.
    </audio>
    <!-- <p>Audio Title or Description</p> -->
  </div>
</div>

<hr class="bottom-line">