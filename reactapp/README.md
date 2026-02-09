# Animal Sounds React App

A fun and educational React web application for children to learn about animals, shapes, letters, and numbers with interactive audio and visual features.

## Features

### 🦁 Animals Gallery
- Browse through 47+ different animals
- Two interaction modes:
  - **Play Sound**: Hear authentic animal sounds
  - **Speak Name**: Text-to-speech pronunciation of animal names
- Horizontal scrolling gallery with beautiful images
- Navigation controls (previous/next)

### 🦖 Dinosaurs
- Explore 12 different dinosaur species
- Interactive dinosaur sound effects
- Horizontal gallery view with navigation controls

### 🔷 Shapes
- Learn 9 basic shapes (triangle, square, rectangle, circle, oval, rhombus, heart, octagon, star)
- Click to hear the shape name spoken aloud
- Visual shape recognition with clear images

### 🔤 Letters
- Complete A-Z alphabet grid
- Click any letter to hear it spoken
- Interactive learning for letter recognition

### 🔢 Numbers
- Numbers 1-20 grid layout
- Click to hear each number spoken
- Foundation for counting skills

### ❓ Animal Quiz
- Test your animal knowledge!
- Listen to an animal sound and choose the correct animal from 3 options
- Score tracking
- Replay sound button
- Instant feedback (correct/wrong animations)
- Auto-progression to next question

### 🎥 Video Mode
- Slideshow-style animal viewer
- Playback controls:
  - Play/Pause
  - Previous/Next
  - Replay
  - Shuffle mode
- Auto-play sounds for each animal

## Technology Stack

- **React** 18.x - Frontend framework
- **Web Speech API** - Text-to-speech functionality
- **HTML5 Audio API** - Animal sound playback
- **CSS3** - Modern styling with animations and gradients
- **Create React App** - Build tooling

## Getting Started

### Prerequisites
- Node.js 14.x or higher
- npm or yarn

### Installation

1. Navigate to the reactapp directory:
```bash
cd reactapp
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm start
```

4. Open your browser to [http://localhost:3000](http://localhost:3000)

### Building for Production

```bash
npm run build
```

This creates an optimized production build in the `build` folder.

## Project Structure

```
reactapp/
├── public/
│   ├── audio/          # Animal and dinosaur sound files (.wav, .mp3)
│   ├── images/         # Animal and dinosaur images
│   ├── shapes/         # Shape PNG images
│   └── data/           # JSON data files
│       ├── animals.json
│       ├── dino.json
│       └── shapes.json
├── src/
│   ├── components/     # React components
│   │   ├── MainMenu.js
│   │   ├── Animals.js
│   │   ├── Dinosaurs.js
│   │   ├── Shapes.js
│   │   ├── Letters.js
│   │   ├── Numbers.js
│   │   ├── Quiz.js
│   │   └── Video.js
│   ├── App.js         # Main application component
│   ├── App.css        # Global styles
│   └── index.js       # Application entry point
└── package.json
```

## Features Explanation

### Audio System
- All animal sounds are stored in `/public/audio/`
- Sounds are played using the HTML5 Audio API
- Fallback handling for missing or failed audio files

### Text-to-Speech
- Uses the Web Speech API (supported in modern browsers)
- Configurable language and speech rate
- Works offline (no external API required)

### Responsive Design
- Adapts to different screen sizes
- Touch-friendly for tablets and mobile devices
- Smooth animations and transitions

### Data Management
- Animal, dinosaur, and shape data loaded from JSON files
- Easy to extend with new animals or features
- Centralized data structure

## Browser Compatibility

- Chrome/Edge 33+
- Firefox 49+
- Safari 7+
- Opera 21+

**Note**: Text-to-speech requires a browser with Web Speech API support.

## Converted from iOS App

This React app is a complete web conversion of the iOS Swift AnimalSounds app, maintaining all core functionality while adapting to web technologies:

- **iOS AVAudioPlayer** → HTML5 Audio API
- **iOS AVSpeechSynthesizer** → Web Speech API
- **iOS Collection Views** → React components with CSS Grid/Flexbox
- **iOS Touch Gestures** → Mouse/Touch events
- **iOS Segmented Control** → React state + styled buttons

## Future Enhancements

- [ ] Multi-language support (Spanish, Portuguese, Hindi, Danish, Chinese)
- [ ] Additional quiz modes (shapes, letters, numbers)
- [ ] Save user progress/scores
- [ ] Dark mode theme
- [ ] More animals and dinosaurs
- [ ] Video content integration

## License

This project includes animal images and sounds sourced from various public domain and Creative Commons sources.

## Acknowledgments

- Original iOS app design and concept
- Animal images and sounds from various public domain sources
- React community for excellent documentation
