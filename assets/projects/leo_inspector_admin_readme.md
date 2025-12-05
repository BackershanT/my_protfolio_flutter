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