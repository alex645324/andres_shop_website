# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application called "andres_shop_website" - a travel discovery app with a clean UI featuring travel destinations. Despite the name suggesting a shop website, the current implementation is a travel/tourism app that displays travel destinations with category filtering.

## Architecture

The app follows a simple single-file architecture in `lib/main.dart` with the following key components:

- **MyApp**: Root application widget with MaterialApp setup and blue theme
- **HomeScreen**: Main screen with stateful category filtering and travel card grid
- **BottomNavigation**: Bottom navigation bar with 4 tabs (home, search, profile, favorites)
- **CategoryFilter**: Horizontal scrollable category filter (All, Beach, Mountain, City, Adventure)
- **TravelCard**: Reusable card component for displaying travel destinations with images and text overlays

The app uses a 2-column GridView to display travel cards and references image assets in the `Assets/` directory.

## Common Commands

### Development
- `flutter run` - Run the app in debug mode
- `flutter run --release` - Run the app in release mode
- `flutter hot-reload` - Hot reload changes (available when running)

### Build
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app (requires macOS)
- `flutter build web` - Build web version

### Testing
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run specific test file

### Analysis and Linting
- `flutter analyze` - Run static analysis (uses `analysis_options.yaml`)
- `dart format .` - Format all Dart files
- `dart fix --dry-run` - Preview available fixes
- `dart fix --apply` - Apply automatic fixes

### Dependencies
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter pub deps` - Show dependency tree

## Important Files

- `lib/main.dart` - Main application code (single file architecture)
- `pubspec.yaml` - Dependencies and app configuration
- `analysis_options.yaml` - Dart/Flutter linting rules
- `test/widget_test.dart` - Basic widget test (needs updating for current app)
- `Assets/` - Contains Group 5.png and Group 6.png used by travel cards

## Asset Configuration

The pubspec.yaml references `Assets/` directory but the asset paths in code use `assets/` (lowercase). This may cause runtime issues - ensure asset paths match the directory structure.

## Testing Notes

The current widget test in `test/widget_test.dart` is outdated and tests for a counter app that doesn't exist. Tests should be updated to match the actual travel app functionality.