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
- Animated truck/shop images that swap positions on swipe or tap, each with info tags
- "swipe" text prompt below images
- Bottom glass-morphism styled "Book Today!" / "Go Back" toggle button with backdrop blur

**Interactive Swipe/Tap Animation:**
- Default state: Truck centered (higher), Shop off to right and lower
- Swiped/tapped state: Shop centered (higher), Truck off to left and lower
- Triangular motion path: centered image at top, off-center images descend diagonally
- Swipe detection: 100px threshold in either direction
- Works with both touch (mobile) and trackpad (Mac) gestures
- Uses `AnimatedSlide` with diagonal offsets (horizontal ±0.6, vertical 0.15) for smooth 600ms transitions with easeInOut curve

**Booking Button Animation:**
- "Book Today! 👋" button triggers fly-up animation when clicked
- Images and "swipe" text fly straight up from their current positions and fade out (600ms)
- Button text changes to "Go Back" when booking state is active
- Clicking "Go Back" reverses the animation, bringing everything back down
- Each image maintains its horizontal position (left/center/right) while flying up
- State managed by `_isBookingPressed` boolean

**Info Tag Widgets:**
- `TruckTag`: Overlay on Truck.png (185×100px)
  - White semi-transparent background (79% opacity)
  - Star rating tab: "⭐️ 4.8" (top-right, 60×19px)
  - Heading: "We come to you" (SF Pro, w800, 13px)
  - Subtext: "Full mobile tier service that comes to your home!!" (SF Pro Rounded, w700, 12px, gray)
  - Positioned 25px from bottom of truck image

- `ShopTag`: Overlay on Shop.png (185×100px)
  - Identical structure to TruckTag
  - Star rating: "⭐️ 4.9"
  - Heading: "Visit our shop"
  - Subtext: "Full tire service, Car repair,\nand inspections" (with line break)
  - Positioned 25px from bottom of shop image

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
- `AnimatedOpacity` for fade-in/fade-out effects
- Complex animation state management with multiple boolean flags (`_isSwipedLeft`, `_isBookingPressed`)
- Conditional offset calculations preserve horizontal positions during vertical animations
- Material Design with custom color scheme (blue primary swatch)
- Responsive positioning using MediaQuery for screen size calculations
- Reusable StatelessWidget components (TruckTag, ShopTag) with semi-transparent overlays

## Refactoring Guidelines

When working with this codebase, follow the guidelines in `tools/R.md`:
- Only refactor when there is repetitive or overly complex code
- Prioritize simplicity and minimalism
- Do not modify public APIs
- Keep code clean and maintainable
