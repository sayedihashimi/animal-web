import React from 'react';

function Letters({ onBack }) {
  const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  const speakLetter = (letter) => {
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(letter);
      utterance.lang = 'en-US';
      utterance.rate = 0.8;
      window.speechSynthesis.speak(utterance);
    }
  };

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Letters 🔤</h1>

      <div className="grid">
        {letters.map((letter) => (
          <div
            key={letter}
            className="grid-item"
            onClick={() => speakLetter(letter)}
          >
            {letter}
          </div>
        ))}
      </div>
    </div>
  );
}

export default Letters;
