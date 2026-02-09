import React, { useState, useEffect } from 'react';

function Quiz({ onBack }) {
  const [animals, setAnimals] = useState([]);
  const [currentQuestion, setCurrentQuestion] = useState(null);
  const [options, setOptions] = useState([]);
  const [score, setScore] = useState(0);
  const [answered, setAnswered] = useState(false);
  const [selectedAnswer, setSelectedAnswer] = useState(null);

  useEffect(() => {
    fetch('/data/animals.json')
      .then((res) => res.json())
      .then((data) => {
        setAnimals(data);
        generateQuestion(data);
      })
      .catch((err) => console.error('Error loading animals:', err));
  }, []);

  const generateQuestion = (animalsList) => {
    const shuffled = [...animalsList].sort(() => Math.random() - 0.5);
    const correct = shuffled[0];
    const wrong1 = shuffled[1];
    const wrong2 = shuffled[2];

    const opts = [correct, wrong1, wrong2].sort(() => Math.random() - 0.5);

    setCurrentQuestion(correct);
    setOptions(opts);
    setAnswered(false);
    setSelectedAnswer(null);

    // Auto-play the sound
    setTimeout(() => {
      const audioFile = new Audio(`/audio/${correct.Audio}.wav`);
      audioFile.play().catch((err) => console.error('Error playing sound:', err));
    }, 500);
  };

  const handleAnswer = (animal) => {
    if (answered) return;

    setSelectedAnswer(animal.Id);
    setAnswered(true);

    if (animal.Id === currentQuestion.Id) {
      setScore((prev) => prev + 1);
      // Play applause sound
      const applause = new Audio('/audio/applause3.wav');
      applause.play().catch((err) => console.error('Error playing applause:', err));
    } else {
      // Play wrong answer sound
      const wrong = new Audio('/audio/wrong-answer.wav');
      wrong.play().catch((err) => console.error('Error playing wrong sound:', err));
    }

    setTimeout(() => {
      generateQuestion(animals);
    }, 2000);
  };

  const replaySound = () => {
    if (currentQuestion) {
      const audioFile = new Audio(`/audio/${currentQuestion.Audio}.wav`);
      audioFile.play().catch((err) => console.error('Error playing sound:', err));
    }
  };

  if (!currentQuestion) {
    return <div className="container"><h2 className="title">Loading...</h2></div>;
  }

  return (
    <div className="container">
      <button className="back-button" onClick={onBack}>← Back</button>
      <h1 className="title">Animal Quiz 🎯</h1>
      <h2 className="title" style={{ fontSize: '32px' }}>Score: {score}</h2>

      <div style={{ textAlign: 'center', marginBottom: '20px' }}>
        <button className="mode-button" onClick={replaySound}>
          🔊 Replay Sound
        </button>
      </div>

      <div className="quiz-options">
        {options.map((animal) => (
          <div
            key={animal.Id}
            className={`quiz-option ${
              answered && animal.Id === currentQuestion.Id
                ? 'correct'
                : answered && animal.Id === selectedAnswer
                ? 'wrong'
                : ''
            }`}
            onClick={() => handleAnswer(animal)}
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
    </div>
  );
}

export default Quiz;
