import React, { useState, useEffect } from 'react';

function Video({ onBack }) {
  const [animals, setAnimals] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);
  const [shuffle, setShuffle] = useState(false);

  useEffect(() => {
    fetch('/data/animals.json')
      .then((res) => res.json())
      .then((data) => setAnimals(data))
      .catch((err) => console.error('Error loading animals:', err));
  }, []);

  const playSound = () => {
    if (animals.length === 0) return;
    
    const audio = new Audio(`/audio/${animals[currentIndex].Audio}.wav`);
    audio.play().catch((err) => console.error('Error playing sound:', err));
    setIsPlaying(true);

    audio.addEventListener('ended', () => {
      setIsPlaying(false);
      if (shuffle) {
        nextRandom();
      } else {
        next();
      }
    });
  };

  const next = () => {
    setCurrentIndex((prev) => (prev + 1) % animals.length);
    setIsPlaying(false);
  };

  const prev = () => {
    setCurrentIndex((prev) => (prev - 1 + animals.length) % animals.length);
    setIsPlaying(false);
  };

  const nextRandom = () => {
    const randomIndex = Math.floor(Math.random() * animals.length);
    setCurrentIndex(randomIndex);
    setIsPlaying(false);
  };

  const replay = () => {
    playSound();
  };

  if (animals.length === 0) {
    return <div className="container"><h2 className="title">Loading...</h2></div>;
  }

  const currentAnimal = animals[currentIndex];

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Video Mode 🎥</h1>

      <div style={{ textAlign: 'center', marginBottom: '30px' }}>
        <div className="gallery-item" style={{ display: 'inline-block', maxWidth: '500px' }}>
          <img
            src={`/images/${currentAnimal.ImageFull}.jpg`}
            alt={currentAnimal.Name}
            onError={(e) => {
              e.target.src = `/images/${currentAnimal.Image}.jpg`;
            }}
          />
          <h3>{currentAnimal.Name}</h3>
        </div>
      </div>

      <div className="controls">
        <button className="control-button" onClick={prev} title="Previous">
          ⏮
        </button>
        <button className="control-button" onClick={playSound} title="Play" disabled={isPlaying}>
          {isPlaying ? '⏸' : '▶'}
        </button>
        <button className="control-button" onClick={next} title="Next">
          ⏭
        </button>
        <button className="control-button" onClick={replay} title="Replay">
          🔄
        </button>
        <button
          className={`control-button ${shuffle ? 'active' : ''}`}
          onClick={() => setShuffle(!shuffle)}
          title="Shuffle"
          style={shuffle ? { background: '#667eea', color: 'white' } : {}}
        >
          🔀
        </button>
      </div>
    </div>
  );
}

export default Video;
