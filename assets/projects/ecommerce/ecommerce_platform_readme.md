# E-Commerce Platform

A full-featured e-commerce platform built with Flutter and Firebase, featuring a complete shopping experience with product catalog, shopping cart, user authentication, and payment processing.

## Features

- Product catalog with categories and search functionality
- Shopping cart with quantity adjustment
- User authentication and profile management
- Secure payment processing with Stripe
- Order history and tracking
- Responsive design for all device sizes
- Admin dashboard for product and order management

## Technologies Used

- Flutter for cross-platform mobile development
- Firebase for backend services (Authentication, Firestore, Storage)
- Stripe for payment processing
- Provider for state management
- Custom UI components for a modern shopping experience

## Screenshots

![Product Catalog](assets/projects/ecommerce/ecommerce01.jpeg)
![Product Details](assets/projects/ecommerce/ecommerce02.jpeg)
![Shopping Cart](assets/projects/ecommerce/ecommerce03.jpeg)
![Checkout Process](assets/projects/ecommerce/ecommerce04.jpeg)
![Order Confirmation](assets/projects/ecommerce/ecommerce05.jpeg)

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Firebase project setup
- Stripe account for payment processing

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Set up Firebase configuration files
4. Configure Stripe payment keys
5. Run `flutter run` to start the application

## Project Structure

```
lib/
├── src/
│   ├── models/           # Data models for products, users, orders
│   ├── services/          # Firebase and Stripe service integrations
│   ├── providers/         # State management with Provider
│   ├── ui/                # UI components and screens
│   │   ├── screens/       # Main application screens
│   │   ├── widgets/       # Reusable UI components
│   │   └── themes/        # App themes and styling
│   └── utils/             # Utility functions and helpers
├── main.dart              # Entry point
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a pull request

## License

This project is proprietary and confidential. All rights reserved.