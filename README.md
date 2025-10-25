# Andres Tire Service - Web Application

A Flutter web application for Andres Tire Service - a tire shop booking website with Firebase integration.

## 🌐 Live Site

**Production**: [https://wethebestauto.com](https://wethebestauto.com)
**Admin Dashboard**: [https://wethebestauto.com/admin](https://wethebestauto.com/admin)

## Features

- **Interactive Booking Interface**: Swipeable image gallery with animations
- **Service Selection**: Tire service, auto repair, and vehicle inspections
- **Location Options**: Mobile service or shop visit
- **Real-time Admin Dashboard**: Manage bookings with Firebase Firestore
- **Glass-morphism UI**: Modern frosted glass aesthetic throughout
- **Clean URL Routing**: Path-based URLs without hash fragments

## Tech Stack

- **Framework**: Flutter 3.8.1+ (Web)
- **Backend**: Firebase (Firestore, Hosting)
- **Deployment**: GitHub Pages with custom domain
- **State Management**: Stateful widgets
- **UI**: Material Design with custom glass-morphism effects

## Development

### Setup
```bash
flutter pub get              # Install dependencies
flutter run -d chrome        # Run on Chrome
```

### Build
```bash
flutter build web --pwa-strategy=none --base-href /
```

### Deploy
```bash
# See CLAUDE.md for detailed deployment instructions
flutter build web --pwa-strategy=none --base-href /
# Deploy build/web/* to deployment branch
```

## Documentation

- **CLAUDE.md**: Detailed technical documentation and architecture
- **FIREBASE_SETUP.md**: Firebase configuration instructions
- **tools/R.md**: Refactoring guidelines

## Project Structure

```
lib/
├── main.dart                    # App entry point with routing
├── firebase_options.dart        # Firebase configuration
├── models/
│   └── booking.dart            # Booking data model
├── services/
│   └── booking_service.dart    # Firestore operations
└── screens/
    ├── tire_service_screen.dart      # Main landing page
    └── admin_dashboard_screen.dart   # Admin interface
```

## License

Copyright © 2024 Andres Tire Service
