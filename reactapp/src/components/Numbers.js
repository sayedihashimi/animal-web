import React from 'react';

function Numbers({ onBack }) {
  const numbers = Array.from({ length: 20 }, (_, i) => i + 1);

  const speakNumber = (num) => {
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(num.toString());
      utterance.lang = 'en-US';
      utterance.rate = 0.8;
      window.speechSynthesis.speak(utterance);
    }
  };

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Numbers 🔢</h1>

      <div className="grid">
        {numbers.map((num) => (
          <div
            key={num}
            className="grid-item"
            onClick={() => speakNumber(num)}
          >
            {num}
          </div>
        ))}
      </div>
    </div>
  );
}

export default Numbers;
