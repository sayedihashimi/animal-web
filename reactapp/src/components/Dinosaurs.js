import React, { useState, useEffect } from 'react';

function Dinosaurs({ onBack }) {
  const [dinos, setDinos] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    fetch('/data/dino.json')
      .then((res) => res.json())
      .then((data) => setDinos(data))
      .catch((err) => console.error('Error loading dinosaurs:', err));
  }, []);

  const playSound = (audio) => {
    const audioFile = new Audio(`/audio/${audio}.wav`);
    audioFile.play().catch((err) => console.error('Error playing sound:', err));
  };

  const nextDino = () => {
    setCurrentIndex((prev) => (prev + 1) % dinos.length);
  };

  const prevDino = () => {
    setCurrentIndex((prev) => (prev - 1 + dinos.length) % dinos.length);
  };

  if (dinos.length === 0) {
    return <div className="container"><h2 className="title">Loading...</h2></div>;
  }

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Dinosaurs 🦖</h1>

      <div className="gallery">
        {dinos.map((dino) => (
          <div
            key={dino.id}
            className="gallery-item"
            onClick={() => playSound(dino.audio)}
          >
            <img
              src={`/images/${dino.image}.jpg`}
              alt={dino.name}
            />
            <h3>{dino.name}</h3>
          </div>
        ))}
      </div>

      <div className="controls">
        <button className="control-button" onClick={prevDino}>
          ←
        </button>
        <button className="control-button" onClick={() => playSound(dinos[currentIndex].audio)}>
          🔊
        </button>
        <button className="control-button" onClick={nextDino}>
          →
        </button>
      </div>
    </div>
  );
}

export default Dinosaurs;
