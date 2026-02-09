import React, { useState } from 'react';
import './App.css';
import MainMenu from './components/MainMenu';
import Animals from './components/Animals';
import Dinosaurs from './components/Dinosaurs';
import Shapes from './components/Shapes';
import Letters from './components/Letters';
import Numbers from './components/Numbers';
import Quiz from './components/Quiz';
import Video from './components/Video';

function App() {
  const [currentView, setCurrentView] = useState('menu');

  const renderView = () => {
    switch (currentView) {
      case 'menu':
        return <MainMenu onNavigate={setCurrentView} />;
      case 'animals':
        return <Animals onBack={() => setCurrentView('menu')} />;
      case 'dinosaurs':
        return <Dinosaurs onBack={() => setCurrentView('menu')} />;
      case 'shapes':
        return <Shapes onBack={() => setCurrentView('menu')} />;
      case 'letters':
        return <Letters onBack={() => setCurrentView('menu')} />;
      case 'numbers':
        return <Numbers onBack={() => setCurrentView('menu')} />;
      case 'quiz':
        return <Quiz onBack={() => setCurrentView('menu')} />;
      case 'video':
        return <Video onBack={() => setCurrentView('menu')} />;
      default:
        return <MainMenu onNavigate={setCurrentView} />;
    }
  };

  return (
    <div className="App">
      {renderView()}
    </div>
  );
}

export default App;
