# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter web/mobile application for Andres Tire Service - a tire shop booking website. The app is built with Flutter SDK 3.8.1+ and uses Material Design components.

## Development Commands

### Setup and Dependencies
```bash
flutter pub get              # Install dependencies
flutter pub upgrade          # Upgrade dependencies
```

### Development
```bash
flutter run -d chrome        # Run on Chrome (web)
flutter run -d macos         # Run on macOS
flutter run                  # Run on connected device/emulator
```

### Testing and Analysis
```bash
flutter test                 # Run all tests
flutter analyze              # Run static analysis/linting
```

### Build
```bash
flutter build web            # Build for web
flutter build apk            # Build Android APK
flutter build ios            # Build for iOS (requires macOS)
flutter build macos          # Build for macOS
```

## Architecture

### Application Structure
- **Entry Point**: `lib/main.dart` - Sets up MaterialApp with "Andres Tire Service" theme
- **Screens**: `lib/screens/` - Contains screen widgets
  - `tire_service_screen.dart` - Main landing screen with booking interface

### Main Screen (`TireServiceScreen`)
The landing page uses a Stack-based layout with:
- Background image with 46% opacity overlay on dark gray (#404040) base
- Logo positioned top-left with 16px left padding (120x90px)
- Animated truck/shop images that swap positions on swipe or tap
- "swipe" text prompt below images
- Bottom glass-morphism styled "Book Today!" button with backdrop blur

**Interactive Swipe/Tap Animation:**
- Default state: Truck centered (higher), Shop off to right and lower
- Swiped/tapped state: Shop centered (higher), Truck off to left and lower
- Triangular motion path: centered image at top, off-center images descend diagonally
- Swipe detection: 100px threshold in either direction
- Works with both touch (mobile) and trackpad (Mac) gestures
- Uses `AnimatedSlide` with diagonal offsets (horizontal ±0.6, vertical 0.15) for smooth 600ms transitions with easeInOut curve

### Assets
Assets are stored in `Assets/` directory (case-sensitive) and include:
- `Background.png` - Background texture
- `logo.png` - Company logo (120x90px)
- `Truck.png` - Hero truck image (350x350px, animated)
- `Shop.png` - Shop image (350x350px, animated)
- `Facebook.png` - Social media icon (not currently used)
- `lock_button.png` - Lock icon (not currently used)

Note: Asset references in code use lowercase `assets/` path (e.g., `assets/Background.png`)

## Code Style

The project uses flutter_lints package with default Flutter recommended lints. Lint rules are configured in `analysis_options.yaml`.

## Key Technical Details

- Uses Flutter's `dart:ui` for backdrop filters and glass-morphism effects
- Stateful widgets with gesture detection (`GestureDetector`)
- Swipe gesture handling via `onHorizontalDragStart`, `onHorizontalDragUpdate`, `onHorizontalDragEnd`
- Drag distance accumulation using `details.delta.dx` for cross-platform compatibility
- `AnimatedSlide` widgets for diagonal motion transitions (triangular path effect)
- Material Design with custom color scheme (blue primary swatch)
- Responsive positioning using MediaQuery for screen size calculations

## Refactoring Guidelines

When working with this codebase, follow the guidelines in `tools/R.md`:
- Only refactor when there is repetitive or overly complex code
- Prioritize simplicity and minimalism
- Do not modify public APIs
- Keep code clean and maintainable
