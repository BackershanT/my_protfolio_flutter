import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

class ProjectDesign {
  final Color bgColor;
  final Color textColor;
  final Color logoColor;
  final Color descColor;
  final List<BlobShape> blobs;

  const ProjectDesign({
    required this.bgColor,
    required this.textColor,
    required this.logoColor,
    required this.descColor,
    required this.blobs,
  });
}

class BlobShape {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const BlobShape({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });
}

class ProjectData {
  static final projects = [
    Project(
      id: '1',
      title: 'YChat Admin',
      description: 'Admin App for YChat App',
      technologies: ['flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectYchat,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '2',
      title: 'YChat',
      description:
          ' YChat Application for messaging screen mirroring and sharing.',
      technologies: ['Flutter', 'Socket.io', 'flutter webrtc'],
      imageUrl: AppAssets.projectYchat,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '3',
      title: 'Door to Door',
      description:
          'Door to Door Application for Delivering groceries and other essentials from your doorstep.',
      technologies: ['Flutter', 'Getx', 'Flutter Maps', 'Rest Apis'],
      imageUrl: AppAssets.projectYchat,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '4',
      title: 'Yachii',
      description: 'Yachii - Company Website with React.',
      technologies: ['React', 'JavaScript', 'useState'],
      imageUrl: AppAssets.projectYachii,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
      readmeContent: '''
# Yachii - Modern React Portfolio Website

A modern, responsive portfolio website for Yachii built with React 19, featuring cutting-edge animations, a sleek design system, and seamless API integration.

## 🌟 Key Features

### Modern Design System
- Contemporary UI with glass morphism effects and gradient accents
- Responsive design that works flawlessly across all devices
- Professional color palette with carefully curated typography
- Consistent design language throughout all components

### Advanced Animations
- Smooth scroll animations powered by AOS (Animate On Scroll)
- 40+ custom keyframe animations for engaging micro-interactions
- Staggered loading sequences for dynamic content presentation
- Performance-optimized animations that respect user preferences

### Core Components
- **Dynamic Image Slider**: Auto-advancing carousel with Ken Burns effect
- **Mission Section**: Interactive cards showcasing company objectives
- **Product Showcase**: Elegant display of YChat with "Coming Soon" feature
- **Newsletter Subscription**: Fully functional subscription form with validation
- **Contact Form**: Complete contact solution with real-time feedback
- **Responsive Navigation**: Mobile-friendly header with animated hamburger menu

### Technical Excellence
- Built with React 19 and Vite for lightning-fast performance
- Component-based architecture with lazy loading for optimal speed
- RESTful API integration for contact and newsletter functionality
- Comprehensive error handling and loading states
- Accessibility-first approach with keyboard navigation support

## 🛠️ Technologies Used

| Category | Technologies |
|----------|--------------|
| Frontend | React 19, JavaScript (ES6+) |
| Styling | CSS3, Flexbox, Grid, Bootstrap Icons |
| Build Tool | Vite |
| Routing | React Router DOM v7 |
| Animations | AOS, Custom CSS Keyframes |
| API Client | Axios |
| Utilities | React Scrollspy |
| Linting | ESLint |

## 🚀 Getting Started

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn package manager

## 📁 Project Structure

```
src/
├── assets/           # Static assets and global styles
├── components/       # Reusable UI components
├── layouts/          # Page layouts
├── pages/            # Page components
├── routes/           # Application routing
├── services/         # API service layer
├── config/           # Configuration files
└── App.jsx          # Main application component
```

## 🔧 API Integration

The website integrates with a backend API for:
- Newsletter subscriptions (`/api/newsletter/subscribe`)
- Contact form submissions (`/api/contact/send`)

## 🎨 Design Highlights

### Animations
- 40+ custom CSS keyframe animations
- Staggered element animations for dynamic content
- Continuous animations (float, pulse, heartbeat)
- Loading animations (spin, dots, bars, ripple)
- Background animations (gradient, shimmer, wave)

### Responsive Design
- Mobile-first approach with fluid typography
- Flexible layouts using CSS Grid and Flexbox
- Touch-friendly interactive elements
- Optimized animations for mobile performance

### UI Components
- Glass morphism cards with backdrop blur effects
- Gradient buttons with hover states
- Animated navigation with scroll indicators
- Enhanced form elements with validation feedback

## 📱 Browser Support
- Chrome (latest 2 versions)
- Firefox (latest 2 versions)
- Safari (latest 2 versions)
- Edge (latest 2 versions)

Modern CSS features are progressively enhanced with appropriate fallbacks.

## 🎯 Performance Optimizations
- Lazy loading for non-critical components
- GPU-accelerated animations using transform and opacity
- CSS variables for reduced repetition
- Modular CSS structure for maintainability
- Tree-shaking for minimal bundle size

## 🔮 Future Enhancements
- Dark/light theme toggle
- Advanced WebGL visual effects
- 3D transform animations
- Customizable animation settings
- A/B testing for engagement metrics

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## 📄 License
This project is proprietary and confidential. All rights reserved.

## 👥 Author
Created with passion for modern web experiences.
''',
    ),

    Project(
      id: '5',
      title: 'My Games',
      description:
          'My Games - A collection of games built with Flutter and the Flame game engine.',
      technologies: ['flutter', 'Flame', 'Forge 2D'],
      imageUrl: AppAssets.projectMyGame,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
      readmeContent: '''
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
''',
    ),

    Project(
      id: '6',
      title: 'My Bus',
      description:
          'My Bus App - A bus tracking app with real-time location updates and route information.',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMyBus,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '7',
      title: 'Calculator',
      description: 'Calculator App built with Flutter.',
      technologies: ['Flutter', 'stateManagement'],
      imageUrl: AppAssets.projectCalculator,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '8',
      title: 'Calendar',
      description: 'Calendar App built with Flutter.',
      technologies: ['Flutter', 'stateManagement'],
      imageUrl: AppAssets.projectCalender,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '9',
      title: 'Mahathma Veliyancode',
      description: 'Mahathma Veliyancode - A website built with React',
      technologies: ['React', 'useState'],
      imageUrl: AppAssets.projectMahathma,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '10',
      title: 'Leo Rigging Calculator',
      description: 'Leo Rigging Calculator - A calculator built with flutter.',
      technologies: ['Flutter', 'Dart'],
      imageUrl: AppAssets.projectRigCalculator,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
      readmeContent: '''
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
''',
    ),

    Project(
      id: '11',
      title: 'Leo Inspector',
      description:
          'Leo Inspector - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
      readmeContent: '''
# LEO Inspector

LEO Inspector is a comprehensive mobile application built with Flutter for managing certificate inspections. The application provides different interfaces for Admins, Inspectors, Clients, and Guests to handle various aspects of certificate management, inspection processes, and request handling.

## Table of Contents
- [Features](#features)
- [Application Flow](#application-flow)
- [User Roles](#user-roles)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
- [Assets](#assets)
- [Fonts](#fonts)

## Features

### Admin Features
- Manage Inspectors (Add, Delete, Search, Detailed View)
- Manage Clients (Add, Delete, Search, Detailed View)
- Manage Certificates (List, Search, Download)
- Manage Requests (List, View, Search, Call)
- QR Code Scanner
- Notifications
- Settings (Company Profile, Admin Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Inspector Features
- Inspection processes with equipment type selection
- Form filling and checklist completion
- PDF generation for certificates
- Issued Certificates management
- Edit Certificate functionality
- QR Code Scanner
- Notifications
- Settings (Inspector Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Client Features
- Request Form submission
- View and Download Certificates
- QR Code Scanner
- Notifications
- Settings (Client Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Guest Features
- Home access
- QR Code Scanner
- Notifications
- Settings

## Application Flow

```
LEO Inspector
|
|-- Admin
|   |-- Home
|   |   |-- Manage Inspectors
|   |   |   |-- Inspectors List
|   |   |   |-- Search
|   |   |   |-- Add Inspector
|   |   |   |-- Delete Inspector
|   |   |   |-- Detailed view
|   |   |-- Manage Client
|   |   |   |-- Client List
|   |   |   |-- Search
|   |   |   |-- Add Client
|   |   |   |-- Delete Client
|   |   |   |-- Detailed view
|   |   |-- Manage Certificate
|   |   |   |-- Certificate List
|   |   |   |-- Search
|   |   |   |-- Download Certificate
|   |   |-- Manage Request
|   |       |-- Request List
|   |       |-- Request View
|   |       |-- Search
|   |       |-- Call 
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Company Profile
|       |-- Admin Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Inspectors
|   |-- Home
|   |   |-- Inspection
|   |   |   |-- Equipment Type
|   |   |       |-- Fill Form
|   |   |           |-- Fill checklist
|   |   |               |-- Filled Form
|   |   |                   |-- Generate Pdf
|   |   |                       |-- Send to Signature Authority
|   |   |-- Issued Certificates
|   |   |   |-- Search
|   |   |   |-- Client List
|   |   |       |-- Search
|   |   |       |-- Certificate List
|   |   |           |-- Download                
|   |   |-- Edit Certificate
|   |       |-- Search
|   |       |-- Client List
|   |           |-- Search
|   |           |-- Certificate List
|   |               |-- Fill Form
|   |               |-- Fill checklist
|   |                   |-- Filled Form
|   |                       |-- Generate Pdf
|   |                           |-- Send to Signature Authority
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Setting
|       |-- Inspector Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Client
|   |-- Home
|   |   |-- Request Form
|   |   |-- View and Download Certificate
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Client Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Guest
|   |-- Home
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
```

## User Roles

1. **Admin**: Has full access to manage inspectors, clients, certificates, and requests
2. **Inspector**: Can perform inspections, generate certificates, and manage issued certificates
3. **Client**: Can submit requests and view/download certificates
4. **Guest**: Limited access for browsing and scanning QR codes

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Flutter Bloc
- **Networking**: Dio
- **PDF Generation**: Syncfusion Flutter PDF
- **UI Components**: Flutter Neumorphic, Google Fonts
- **Data Storage**: Shared Preferences
- **QR Code**: QR Code Scanner, QR Flutter

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

Key dependencies used in this project:
- flutter_neumorphic: For neumorphic UI design
- dio: For HTTP requests
- flutter_bloc: For state management
- qr_code_scanner: For QR code scanning functionality
- syncfusion_flutter_pdf: For PDF generation and viewing
- shared_preferences: For local data storage
- google_fonts: For custom fonts
- image_picker: For image selection
- path_provider: For accessing device paths

## Assets

The application uses various assets including:
- Icons for different features
- Images for branding and UI elements
- PDF templates and assets

## Fonts

Custom fonts used in the application:
- Barlow-Regular
- Barlow-Medium
- Barlow-Bold
- Barlow-SemiBold

## Contributing

This project is currently maintained by ClanLEO. For major changes, please contact the development team.

## Version

Current version: 1.0.0+1
''',
    ),

    Project(
      id: '12',
      title: 'Leo Inspector Admin',
      description:
          'Leo Inspector Admin  - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
      readmeContent: '''
# LEO Inspector Admin

LEO Inspector Admin is a comprehensive mobile application built with Flutter for managing certificate inspections. The application provides different interfaces for Admins, Inspectors, Clients, and Guests to handle various aspects of certificate management, inspection processes, and request handling.

## Table of Contents
- [Features](#features)
- [Application Flow](#application-flow)
- [User Roles](#user-roles)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
- [Assets](#assets)
- [Fonts](#fonts)

## Features

### Admin Features
- Manage Inspectors (Add, Delete, Search, Detailed View)
- Manage Clients (Add, Delete, Search, Detailed View)
- Manage Certificates (List, Search, Download)
- Manage Requests (List, View, Search, Call)
- QR Code Scanner
- Notifications
- Settings (Company Profile, Admin Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Inspector Features
- Inspection processes with equipment type selection
- Form filling and checklist completion
- PDF generation for certificates
- Issued Certificates management
- Edit Certificate functionality
- QR Code Scanner
- Notifications
- Settings (Inspector Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Client Features
- Request Form submission
- View and Download Certificates
- QR Code Scanner
- Notifications
- Settings (Client Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Guest Features
- Home access
- QR Code Scanner
- Notifications
- Settings

## Application Flow

```
LEO Inspector Admin
|
|-- Admin
|   |-- Home
|   |   |-- Manage Inspectors
|   |   |   |-- Inspectors List
|   |   |   |-- Search
|   |   |   |-- Add Inspector
|   |   |   |-- Delete Inspector
|   |   |   |-- Detailed view
|   |   |-- Manage Client
|   |   |   |-- Client List
|   |   |   |-- Search
|   |   |   |-- Add Client
|   |   |   |-- Delete Client
|   |   |   |-- Detailed view
|   |   |-- Manage Certificate
|   |   |   |-- Certificate List
|   |   |   |-- Search
|   |   |   |-- Download Certificate
|   |   |-- Manage Request
|   |       |-- Request List
|   |       |-- Request View
|   |       |-- Search
|   |       |-- Call 
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Company Profile
|       |-- Admin Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Inspectors
|   |-- Home
|   |   |-- Inspection
|   |   |   |-- Equipment Type
|   |   |       |-- Fill Form
|   |   |           |-- Fill checklist
|   |   |               |-- Filled Form
|   |   |                   |-- Generate Pdf
|   |   |                       |-- Send to Signature Authority
|   |   |-- Issued Certificates
|   |   |   |-- Search
|   |   |   |-- Client List
|   |   |       |-- Search
|   |   |       |-- Certificate List
|   |   |           |-- Download                
|   |   |-- Edit Certificate
|   |       |-- Search
|   |       |-- Client List
|   |           |-- Search
|   |           |-- Certificate List
|   |               |-- Fill Form
|   |               |-- Fill checklist
|   |                   |-- Filled Form
|   |                       |-- Generate Pdf
|   |                           |-- Send to Signature Authority
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Setting
|       |-- Inspector Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Client
|   |-- Home
|   |   |-- Request Form
|   |   |-- View and Download Certificate
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Client Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Guest
|   |-- Home
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
```

## User Roles

1. **Admin**: Has full access to manage inspectors, clients, certificates, and requests
2. **Inspector**: Can perform inspections, generate certificates, and manage issued certificates
3. **Client**: Can submit requests and view/download certificates
4. **Guest**: Limited access for browsing and scanning QR codes

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Flutter Bloc
- **Networking**: Dio
- **PDF Generation**: Syncfusion Flutter PDF
- **UI Components**: Flutter Neumorphic, Google Fonts
- **Data Storage**: Shared Preferences
- **QR Code**: QR Code Scanner, QR Flutter

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

Key dependencies used in this project:
- flutter_neumorphic: For neumorphic UI design
- dio: For HTTP requests
- flutter_bloc: For state management
- qr_code_scanner: For QR code scanning functionality
- syncfusion_flutter_pdf: For PDF generation and viewing
- shared_preferences: For local data storage
- google_fonts: For custom fonts
- image_picker: For image selection
- path_provider: For accessing device paths

## Assets

The application uses various assets including:
- Icons for different features
- Images for branding and UI elements
- PDF templates and assets

## Fonts

Custom fonts used in the application:
- Barlow-Regular
- Barlow-Medium
- Barlow-Bold
- Barlow-SemiBold

## Contributing

This project is currently maintained by ClanLEO. For major changes, please contact the development team.

## Version

Current version: 1.0.0+1
''',
    ),

    Project(
      id: '13',
      title: 'Reachout',
      description:
          'Reachout - A social platform for connecting with people.with card creating functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectReachout,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '14',
      title: 'Movie App',
      description: 'Movie App - A movie app with search functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMovieApp,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '15',
      title: 'Netflix Clone',
      description: 'Netflix Clone - A Netflix clone built with React',
      technologies: ['React', 'firebase', 'useState'],
      imageUrl: AppAssets.projectNetflix,
      screenshots: [],
      codeUrl: '',
      demoUrl: '',
    ),
  ];

  static List<Project> getAllProjects() => projects;

  static List<ProjectDesign> getDesigns(bool isDark, bool isMobile) {
    return [
      // Design 1 - Brown/Coral theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF6B6B).withValues(alpha: 0.7)
            : const Color(0xFFE88B8B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF4A4A4A) : const Color(0xFF5A5A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -150.0 : -100.0,
            top: isMobile ? -100.0 : -80.0,
            width: isMobile ? 350.0 : 450.0,
            height: isMobile ? 350.0 : 450.0,
            color: isDark
                ? const Color(0xFF4A3A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B6B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(250),
              topRight: Radius.circular(180),
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(300),
            ),
          ),
          BlobShape(
            left: isMobile ? -120.0 : -80.0,
            bottom: isMobile ? -120.0 : -100.0,
            width: isMobile ? 320.0 : 400.0,
            height: isMobile ? 320.0 : 400.0,
            color: isDark
                ? const Color(0xFF5A4A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B7B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(200),
              topRight: Radius.circular(280),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ],
      ),
      // Design 2 - Blue/Purple theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6B8BCF).withValues(alpha: 0.7)
            : const Color(0xFF8BA8E8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A4A5A) : const Color(0xFF4A5A6A),
        blobs: [
          BlobShape(
            right: isMobile ? -140.0 : -90.0,
            top: isMobile ? -110.0 : -90.0,
            width: isMobile ? 340.0 : 440.0,
            height: isMobile ? 340.0 : 440.0,
            color: isDark
                ? const Color(0xFF3A4A5A).withValues(alpha: 0.4)
                : const Color(0xFF6B7B8B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(260),
              topRight: Radius.circular(190),
              bottomLeft: Radius.circular(210),
              bottomRight: Radius.circular(290),
            ),
          ),
          BlobShape(
            left: isMobile ? -110.0 : -70.0,
            bottom: isMobile ? -110.0 : -90.0,
            width: isMobile ? 310.0 : 390.0,
            height: isMobile ? 310.0 : 390.0,
            color: isDark
                ? const Color(0xFF4A5A6A).withValues(alpha: 0.3)
                : const Color(0xFF7B8B9B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(210),
              topRight: Radius.circular(270),
              bottomLeft: Radius.circular(230),
              bottomRight: Radius.circular(190),
            ),
          ),
        ],
      ),
      // Design 3 - Green/Teal theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6BCF8B).withValues(alpha: 0.7)
            : const Color(0xFF8BE8A8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A5A4A) : const Color(0xFF4A6A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -130.0 : -85.0,
            top: isMobile ? -105.0 : -85.0,
            width: isMobile ? 330.0 : 430.0,
            height: isMobile ? 330.0 : 430.0,
            color: isDark
                ? const Color(0xFF3A5A4A).withValues(alpha: 0.4)
                : const Color(0xFF6B8B7B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(240),
              topRight: Radius.circular(200),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(280),
            ),
          ),
          BlobShape(
            right: isMobile ? -115.0 : -75.0,
            bottom: isMobile ? -115.0 : -95.0,
            width: isMobile ? 315.0 : 395.0,
            height: isMobile ? 315.0 : 395.0,
            color: isDark
                ? const Color(0xFF4A6A5A).withValues(alpha: 0.3)
                : const Color(0xFF7B9B8B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(195),
              topRight: Radius.circular(265),
              bottomLeft: Radius.circular(225),
              bottomRight: Radius.circular(200),
            ),
          ),
        ],
      ),
      // Design 4 - Orange/Amber theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF8B6B).withValues(alpha: 0.7)
            : const Color(0xFFE8A88B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF5A4A3A) : const Color(0xFF6A5A4A),
        blobs: [
          BlobShape(
            right: isMobile ? -135.0 : -88.0,
            top: isMobile ? -108.0 : -88.0,
            width: isMobile ? 335.0 : 435.0,
            height: isMobile ? 335.0 : 435.0,
            color: isDark
                ? const Color(0xFF5A4A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B7B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(255),
              topRight: Radius.circular(185),
              bottomLeft: Radius.circular(215),
              bottomRight: Radius.circular(295),
            ),
          ),
          BlobShape(
            left: isMobile ? -118.0 : -78.0,
            bottom: isMobile ? -112.0 : -92.0,
            width: isMobile ? 318.0 : 398.0,
            height: isMobile ? 318.0 : 398.0,
            color: isDark
                ? const Color(0xFF6A5A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B8B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(205),
              topRight: Radius.circular(275),
              bottomLeft: Radius.circular(235),
              bottomRight: Radius.circular(185),
            ),
          ),
        ],
      ),
    ];
  }

  static Map<String, IconData> getTechIcons() {
    return {
      'Flutter': Icons.flutter_dash,
      'Dart': Icons.code,
      'React': Icons.web,
      'Firebase': Icons.cloud,
      'JavaScript': Icons.javascript,
      'TypeScript': Icons.code_rounded,
      'Node.js': Icons.dns_rounded,
      'MongoDB': Icons.storage_rounded,
      'Material UI': Icons.palette_outlined,
      'Redux': Icons.settings_suggest_rounded,
      'Stripe': Icons.payment_rounded,
      'Provider': Icons.layers_rounded,
      'Riverpod': Icons.device_hub_rounded,
      'Chart.js': Icons.bar_chart_rounded,
      'OpenWeather API': Icons.wb_sunny_outlined,
      'Google Maps': Icons.map_outlined,
      'Health API': Icons.favorite_outline,
    };
  }
}
