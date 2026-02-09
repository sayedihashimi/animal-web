import React, { useState, useEffect } from 'react';

function Shapes({ onBack }) {
  const [shapes, setShapes] = useState([]);

  useEffect(() => {
    fetch('/data/shapes.json')
      .then((res) => res.json())
      .then((data) => {
        // Filter to only first 9 unique shapes
        const uniqueShapes = data.filter((shape) => !shape.id.startsWith('s02-'));
        setShapes(uniqueShapes);
      })
      .catch((err) => console.error('Error loading shapes:', err));
  }, []);

  const speakName = (name) => {
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(name);
      utterance.lang = 'en-US';
      window.speechSynthesis.speak(utterance);
    }
  };

  if (shapes.length === 0) {
    return <div className="container"><h2 className="title">Loading...</h2></div>;
  }

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Shapes 🔷</h1>

      <div className="grid">
        {shapes.map((shape) => (
          <div
            key={shape.id}
            className="grid-item"
            onClick={() => speakName(shape.name)}
          >
            <img
              src={`/shapes/${shape.image}.png`}
              alt={shape.name}
            />
          </div>
        ))}
      </div>
    </div>
  );
}

export default Shapes;
