# YCalc - Scientific Calculator

A modern, feature-rich scientific calculator app built with Flutter, implementing clean architecture principles and the BLoC pattern for state management. The app provides both basic and scientific calculation modes with a beautiful Material Design 3 interface.

## 📱 Features

### Basic Calculator Mode
- **Arithmetic Operations**: Addition (+), Subtraction (-), Multiplication (×), Division (÷)
- **Percentage**: Calculate percentages
- **Clear (AC)**: All clear functionality
- **Backspace (⌫)**: Remove last entered character
- **Decimal Support**: Floating-point number input

### Scientific Calculator Mode
- **Trigonometric Functions**: sin, cos, tan
- **Logarithmic Functions**: log (base 10), ln (natural logarithm)
- **Power Operations**: Exponentiation (^)
- **Square Root**: √
- **Factorial**: !
- **Parentheses**: Support for complex nested expressions
- **Mathematical Constants**: π (pi), e (Euler's number)
- **Advanced Expression Parsing**: Supports complex mathematical expressions

### UI/UX Features
- **Material Design 3**: Modern, polished interface
- **Light/Dark Theme**: Automatic system theme detection with manual override
- **Responsive Design**: Adaptive layout using `flutter_screenutil` for different screen sizes
- **Smooth Animations**: Enhanced user experience with `flutter_animate`
- **Haptic Feedback**: Tactile response on button presses
- **Mode Toggle**: Easy switching between basic and scientific modes via AppBar icon
- **Custom Typography**: Google Fonts (Inter) for improved readability
- **Error Handling**: Graceful handling of invalid expressions and division by zero

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart          # Theme configuration (light/dark)
│
├── features/
│   └── calculator/
│       ├── domain/
│       │   └── entities/
│       │       └── calculator.dart  # Domain entity
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── calculator_bloc.dart      # Business logic & state management
│           │   ├── calculator_event.dart     # Event definitions
│           │   └── calculator_state.dart     # State definitions
│           │
│           ├── pages/
│           │   └── calculator_page.dart      # Main calculator page
│           │
│           └── widgets/
│               ├── calc_button.dart          # Reusable button widget
│               ├── display_screen.dart       # Expression & result display
│               ├── keyboard_grid.dart        # Keyboard layout (basic/scientific)
│               └── mode_switch.dart          # Mode toggle widget
│
└── main.dart                                # App entry point
```

### Architecture Layers

1. **Domain Layer** (`domain/`)
   - Contains business entities and core domain logic
   - Calculator entity with expression and result

2. **Presentation Layer** (`presentation/`)
   - BLoC for state management
   - UI widgets and pages
   - Event-driven architecture

## 🔄 State Management

The app uses the **BLoC (Business Logic Component) Pattern** via `flutter_bloc`:

### Events
- `InputNumber`: Adds a number to the expression
- `InputOperator`: Adds an operator (+, -, ×, ÷, =)
- `InputFunction`: Adds a mathematical function (sin, cos, log, etc.)
- `InputConstant`: Adds constants (π, e)
- `ClearInput`: Clears the entire expression
- `Backspace`: Removes the last character
- `CalculateResult`: Evaluates the current expression
- `ToggleMode`: Switches between basic and scientific modes

### States
- `CalculatorInitial`: Initial state with empty expression
- `CalculatorUpdated`: State with current expression and result

### State Flow
```
User Action → Event → BLoC Handler → State Update → UI Rebuild
```

## 🛠️ Technology Stack

### Core Dependencies
- **Flutter SDK**: ^3.9.0
- **flutter_bloc**: ^8.1.3 - State management
- **math_expressions**: ^2.4.0 - Mathematical expression parsing and evaluation

### UI Dependencies
- **google_fonts**: ^6.1.0 - Custom typography
- **flutter_animate**: ^4.3.0 - Smooth animations
- **flutter_screenutil**: ^5.9.0 - Responsive design utilities

### Development Dependencies
- **flutter_lints**: ^5.0.0 - Code linting
- **flutter_launcher_icons**: ^0.13.1 - App icon generation
- **flutter_native_splash**: ^2.3.5 - Splash screen configuration

## 📦 Installation

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code / Android Studio (for development)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd y_calc
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21 (Android 5.0)
- No additional configuration required

#### iOS
- iOS 12.0 or higher
- Run `pod install` in the `ios/` directory if needed

#### Web
- Fully supported, run with `flutter run -d chrome`

#### Desktop (Windows, macOS, Linux)
- Supported platforms with full functionality

## 🧪 Testing

The project includes comprehensive unit tests for the calculator logic:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### Test Coverage
- Calculator BLoC state management
- Expression input handling
- Calculation logic
- Mode switching

Test files are located in the `test/` directory:
- `calculator_test.dart` - BLoC unit tests
- `calculator_functionality_test.dart` - Functional tests
- `widget_test.dart` - Widget tests

## 🎨 Customization

### Theme Customization
Modify `lib/core/theme/app_theme.dart` to customize:
- Color scheme (currently Deep Purple)
- Light/Dark theme variants
- Typography styles

### App Icon
App icons are configured in `pubspec.yaml`:
- Icon: `assets/icon/app_icon.png`
- Adaptive icon support for Android
- Custom icon set for iOS

### Splash Screen
Splash screen configuration in `pubspec.yaml`:
- Color: Deep Purple (#673AB7)
- Icon: `assets/splash/splash_icon.png`
- Supports Android 12+ splash screen API

To regenerate icons and splash screen:
```bash
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

## 📐 Expression Evaluation

The calculator uses the `math_expressions` package for robust mathematical expression parsing:

### Supported Operations
- Basic arithmetic: `+, -, *, /`
- Power operations: `^` or `pow(x, y)`
- Functions: `sin, cos, tan, log, ln, sqrt, factorial`
- Constants: `π (pi), e`
- Parentheses: `( )` for grouping

### Expression Processing
1. **Input Collection**: User input is collected as a string
2. **Symbol Replacement**: Display symbols (×, ÷) are converted to math symbols (*, /)
3. **Implicit Multiplication**: Automatically handles cases like `2(3)` → `2*(3)`
4. **Parsing**: Expression is parsed into an abstract syntax tree
5. **Evaluation**: Mathematical evaluation using context model
6. **Error Handling**: Invalid expressions return "Error"

### Example Expressions
- `5 + 3 * 2` → 11
- `sin(π/2)` → 1.0
- `2^3 + log(100)` → 11.0
- `√(16) + √(9)` → 7.0

## 🚀 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Guidelines
1. Follow Flutter/Dart style guidelines
2. Write tests for new features
3. Update documentation as needed
4. Ensure all tests pass before submitting

## 📝 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- State management with [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- Mathematical expressions with [math_expressions](https://pub.dev/packages/math_expressions)
- Design inspiration from Material Design 3

---
**Version**: 1.0.0+1  
**Last Updated**: 2024