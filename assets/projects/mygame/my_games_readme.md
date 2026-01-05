# Sky Jumper

A Flutter-based Doodle Jump clone built using the Flame game engine and Forge2D physics engine.

## Description

Sky Jumper is a physics-based platform game where players control a character that automatically jumps upward through procedurally generated platforms. The objective is to climb as high as possible while collecting coins for bonus points. The game features three platform types (normal, moving, and broken), stage progression every 1000 points, and local high score persistence.

## Features

- Physics-based movement and collision detection with Forge2D
- Three platform types:
  - Normal platforms (stable)
  - Moving platforms (horizontal movement)
  - Broken platforms (disappear after landing)
- Coin collection system for score bonuses
- Stage progression every 1000 points with changing backgrounds
- Local high score persistence using SharedPreferences
- Cross-platform support: Android, iOS, Web, Linux, macOS, Windows

## Screenshots

(Add screenshots of your game here)

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter extensions
- Android/iOS emulator or physical device for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/sky-jumper.git
   ```

2. Navigate to the project directory:
   ```bash
   cd sky-jumper
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── constants/          # App-wide constants (colors, game settings)
│   └── utils/              # Utility functions (e.g., score formatting)
├── data/local/             # Local data storage logic (score_storage.dart)
├── domain/models/          # Data models (e.g., PlatformType)
├── game/
│   ├── components/         # Flame game entities: Player, Platforms, Coins, Background
│   ├── managers/           # ScoreManager, StageManager
│   └── sky_jumper_game.dart # Main Flame game class
├── presentation/
│   ├── screens/            # Flutter UI screens: Home, Game, Game Over, Mini-games
│   └── widgets/            # Reusable UI elements: ScoreDisplay, StageIndicator
└── main.dart               # Application entry point
```

## Dependencies

- [Flutter](https://flutter.dev/) - UI toolkit for building natively compiled applications
- [Flame](https://pub.dev/packages/flame) - Game engine for Flutter
- [flame_forge2d](https://pub.dev/packages/flame_forge2d) - Physics engine integration for Flame
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Persistent storage for high scores
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) - State management

## Running Tests

To run the test suite:
```bash
flutter test
```

## Building for Production

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## Contributing

1. Fork the repository
2. Create a feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add some AmazingFeature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the classic Doodle Jump game
- Built with the amazing Flame game engine