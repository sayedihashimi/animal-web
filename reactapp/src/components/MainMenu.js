import React from 'react';
import './MainMenu.css';

function MainMenu({ onNavigate }) {
  const menuItems = [
    { id: 'animals', title: 'Animals', emoji: '🦁' },
    { id: 'dinosaurs', title: 'Dinosaurs', emoji: '🦖' },
    { id: 'shapes', title: 'Shapes', emoji: '🔷' },
    { id: 'letters', title: 'Letters', emoji: '🔤' },
    { id: 'numbers', title: 'Numbers', emoji: '🔢' },
    { id: 'quiz', title: 'Quiz', emoji: '❓' },
    { id: 'video', title: 'Videos', emoji: '🎥' },
  ];

  return (
    <div className="main-menu">
      <h1 className="menu-title">Animal Sounds</h1>
      <p className="menu-subtitle">Learn about animals, shapes, letters, and numbers!</p>
      <div className="menu-grid">
        {menuItems.map((item) => (
          <div
            key={item.id}
            className="menu-item"
            onClick={() => onNavigate(item.id)}
          >
            <div className="menu-emoji">{item.emoji}</div>
            <h3>{item.title}</h3>
          </div>
        ))}
      </div>
    </div>
  );
}

export default MainMenu;
