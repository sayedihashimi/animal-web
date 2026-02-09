import React, { useState, useEffect } from 'react';

function Animals({ onBack }) {
  const [animals, setAnimals] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [mode, setMode] = useState('sound'); // 'sound' or 'speak'

  useEffect(() => {
    fetch('/data/animals.json')
      .then((res) => res.json())
      .then((data) => setAnimals(data))
      .catch((err) => console.error('Error loading animals:', err));
  }, []);

  const playSound = (audio) => {
    const audioFile = new Audio(`/audio/${audio}.wav`);
    audioFile.play().catch((err) => console.error('Error playing sound:', err));
  };

  const speakName = (name) => {
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(name);
      utterance.lang = 'en-US';
      window.speechSynthesis.speak(utterance);
    }
  };

  const handleClick = (animal) => {
    if (mode === 'sound') {
      playSound(animal.Audio);
    } else {
      speakName(animal.Name);
    }
  };

  const nextAnimal = () => {
    setCurrentIndex((prev) => (prev + 1) % animals.length);
  };

  const prevAnimal = () => {
    setCurrentIndex((prev) => (prev - 1 + animals.length) % animals.length);
  };

  if (animals.length === 0) {
    return <div className="container"><h2 className="title">Loading...</h2></div>;
  }

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Animals</h1>
      
      <div className="mode-selector">
        <button
          className={`mode-button ${mode === 'sound' ? 'active' : ''}`}
          onClick={() => setMode('sound')}
        >
          🔊 Play Sound
        </button>
        <button
          className={`mode-button ${mode === 'speak' ? 'active' : ''}`}
          onClick={() => setMode('speak')}
        >
          🗣️ Speak Name
        </button>
      </div>

      <div className="gallery">
        {animals.map((animal, idx) => (
          <div
            key={animal.Id}
            className="gallery-item"
            onClick={() => handleClick(animal)}
            style={{ display: idx >= currentIndex - 1 && idx <= currentIndex + 5 ? 'block' : 'none' }}
          >
            <img
              src={`/images/${animal.ImageFull}.jpg`}
              alt={animal.Name}
              onError={(e) => {
                e.target.src = `/images/${animal.Image}.jpg`;
              }}
            />
            <h3>{animal.Name}</h3>
          </div>
        ))}
      </div>

      <div className="controls">
        <button className="control-button" onClick={prevAnimal}>
          ←
        </button>
        <button className="control-button" onClick={() => handleClick(animals[currentIndex])}>
          {mode === 'sound' ? '🔊' : '🗣️'}
        </button>
        <button className="control-button" onClick={nextAnimal}>
          →
        </button>
      </div>
    </div>
  );
}

export default Animals;
