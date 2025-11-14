# Leo Rigging Calculator

A specialized engineering calculator application built with Flutter for rigging, transportation, and weight calculations.

## Features

- **Rigging Calculator**: Calculate sling tensions, load distributions, and safety factors for various rigging configurations
- **Transportation Calculator**: Determine transportation requirements and constraints for heavy equipment
- **Weight Calculator**: Calculate weights of various materials and objects for engineering purposes

## Screenshots

![App Screenshots](assets/app_logo/leo_logo_large.png)

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 2.17 or higher
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator for mobile testing
- Chrome browser for web testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/leo_rigging_calculator.git
   ```

2. Navigate to the project directory:
   ```bash
   cd leo_rigging_calculator
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the Application

#### Mobile (Android/iOS)
```bash
flutter run
```

#### Web
```bash
flutter run -d chrome
```

#### Desktop (Windows/macOS/Linux)
```bash
flutter run -d windows
```

### Building for Production

#### Android
```bash
flutter build apk
```

#### iOS
```bash
flutter build ios
```

#### Web
```bash
flutter build web
```

#### Desktop
```bash
flutter build windows
```

## Project Structure

```
lib/
├── src/
│   ├── appcolors/          # Color definitions and themes
│   ├── pages/              # UI screens and pages
│   │   ├── rigging_calculator/
│   │   ├── transportation_calculator/
│   │   ├── weight_calculator/
│   │   ├── home_page.dart
│   │   └── splash_screen_page.dart
│   └── app.dart            # Main app configuration
├── main.dart               # Entry point
```

## Dependencies

- flutter: SDK
- cupertino_icons: For iOS-style icons
- carousel_slider: For image sliders
- url_launcher: To open URLs
- smooth_page_indicator: For page indicators

## Development

### Code Style

This project follows the Flutter linting rules defined in analysis_options.yaml.

### Adding New Features

1. Create a new branch for your feature
2. Implement your changes
3. Write tests if applicable
4. Run flutter analyze to check for issues
5. Create a pull request

## Troubleshooting

### Gradle Issues

If you encounter Gradle build issues:
1. Run flutter clean
2. Delete the android/.gradle folder
3. Run flutter pub get
4. Try building again

### Android Build Issues

Ensure you have the correct Android SDK versions installed:
- compileSdkVersion: 33
- minSdkVersion: 16
- targetSdkVersion: 33

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a pull request

## License

This project is proprietary and confidential. All rights reserved.

## Contact

For support or inquiries, please contact the development team.