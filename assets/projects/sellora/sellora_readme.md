# Sellora POS

<p align="center">
  <img src="assets/images/logos/logo.jpeg" alt="Sellora Logo" width="120" />
</p>

<p align="center">
  <b>Modern, Multi-tenant, Offline-first Point of Sale (POS) System</b>
  <br />
  Built with Flutter & Supabase
</p>

---

## 🚀 Overview

Sellora POS is a robust, cloud-integrated Point of Sale solution designed for modern businesses. It combines the power of **Flutter** for a seamless cross-platform experience with **Supabase** for a scalable, reliable backend. Featuring an **offline-first architecture**, Sellora ensures your business keeps running even without an active internet connection.

## ✨ Key Features

- 🏢 **Multi-Tenancy**: Support for multiple businesses (tenants) and stores within each tenant.
- 📦 **Inventory Management**: Track stock levels, variants, and movements in real-time.
- 💰 **Comprehensive POS**: Fast and intuitive checkout process with barcode scanning.
- 📊 **Insightful Analytics**: Dynamic charts and reports to visualize sales and expenses.
- 🔄 **Offline-First Sync**: Local data persistence with high-performance synchronization to the cloud.
- 🌐 **Multi-lingual Support**: Native localization for 10+ languages.
- 💸 **Payment Integration**: Seamless integration with Razorpay and other payment methods.
- 📄 **Reporting**: Export orders, invoices, and summaries to PDF and Excel.

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Backend-as-a-Service**: [Supabase](https://supabase.com/)
- **Local Database**: [Drift](https://drift.simonbinder.eu/) (SQLite)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Charts**: [FL Chart](https://pub.dev/packages/fl_chart)
- **Reports**: [PDF](https://pub.dev/packages/pdf), [Excel](https://pub.dev/packages/excel)

## 🏗 Architecture

The project follows a **Feature-based Clean Architecture**, ensuring scalability and maintainability:

- **`lib/core`**: Essential utilities, theme data, and global providers.
- **`lib/features`**: Independent modules (Auth, POS, Inventory, etc.) containing their own presentation, domain, and data layers.
- **`lib/shared`**: Reusable UI components and widgets across features.

## 🏁 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Stable)
- [Supabase CLI](https://supabase.com/docs/guides/cli) (Optional, for backend development)

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/BackershanT/sellora_pos.git
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Environment Configuration**:
   Copy `.env.example` to `.env` and fill in your Supabase credentials:
   ```bash
   SUPABASE_URL=your_project_url
   SUPABASE_ANON_KEY=your_anon_key
   ```

4. **Generate Code**:
   Run the build runner to generate Drift and other necessary files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Running the App

```bash
flutter run
```

## 🌍 Localization

Sellora POS supports a wide range of languages:
- 🇬🇧 English (EN)
- 🇮🇳 Malayalam (ML)
- 🇮🇳 Hindi (HI)
- 🇮🇳 Bengali (BN)
- ...and more!

Localization files are located in `lib/l10n/`.

## 🧪 Testing

The project includes unit, widget, and integration tests to ensure stability.

```bash
# Run all tests
flutter test
```

## 📚 Documentation
- [Supabase Schema Overview](docs/supabase_schema.md)

---

<p align="center">
  Developed with ❤️ by the Sellora Team
</p>
