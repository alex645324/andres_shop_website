# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter web/mobile application for Andres Tire Service - a tire shop booking website. The app is built with Flutter SDK 3.8.1+ and uses Material Design components.

**Firebase Integration**: The project is configured with Firebase for Android, iOS, macOS, Web, and Windows platforms. Firebase configuration is managed via FlutterFire CLI and includes platform-specific service files.

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
- **Entry Point**: `lib/main.dart` - Sets up MaterialApp with "Andres Tire Service" theme, initializes Firebase, and configures routing
  - Uses `onGenerateRoute` for web-compatible routing
  - Routes: `/` (home), `/admin` (admin dashboard)
- **Firebase Configuration**: `lib/firebase_options.dart` - Auto-generated Firebase platform configurations
- **Models**: `lib/models/` - Data models
  - `booking.dart` - Booking data model with Firestore serialization, includes payment tracking
- **Services**: `lib/services/` - Business logic and Firebase operations
  - `booking_service.dart` - Handles all booking CRUD operations with Firestore
- **Screens**: `lib/screens/` - Contains screen widgets
  - `tire_service_screen.dart` - Main landing screen with booking interface
  - `admin_dashboard_screen.dart` - Admin dashboard for managing bookings

### Firebase Files
- `firebase.json` - FlutterFire CLI configuration mapping platforms to their service files
- `android/app/google-services.json` - Android Firebase configuration
- `ios/Runner/GoogleService-Info.plist` - iOS Firebase configuration
- `macos/Runner/GoogleService-Info.plist` - macOS Firebase configuration
- Firebase project ID: `tirews-d7184`

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
- `TruckTag`: Overlay on Truck.png (220×auto)
  - Glass-morphism effect with backdrop blur (20px)
  - Semi-transparent grey background with white border (2px, 18px radius)
  - Star rating: "⭐️ 4.8" (15px, w600)
  - Heading: "We come to you" (17px, w700)
  - Subtext: "Full mobile tier service that comes to your home!!" (14px, w500)
  - Positioned 15px from bottom of truck image

- `ShopTag`: Overlay on Shop.png (220×auto)
  - Identical structure to TruckTag with glass-morphism
  - Star rating: "⭐️ 4.9" (15px, w600)
  - Heading: "Visit our shop" (17px, w700)
  - Subtext: "Full tire service, Car repair,\nand inspections" (14px, w500)
  - Positioned 15px from bottom of shop image

### Assets
Assets are stored in `Assets/` directory (case-sensitive) and include:
- `Background.png` - Background texture
- `logo.png` - Company logo (120x90px)
- `Truck.png` - Hero truck image (400x400px, animated)
- `Shop.png` - Shop image (400x400px, animated)
- `Facebook.png` - Social media icon (not currently used)
- `lock_button.png` - Lock icon (not currently used)

Note: Asset references in code use lowercase `assets/` path (e.g., `assets/Background.png`)

## Code Style

The project uses flutter_lints package with default Flutter recommended lints. Lint rules are configured in `analysis_options.yaml`.

## Key Technical Details

### UI/Animation
- Uses Flutter's `dart:ui` for backdrop filters and glass-morphism effects throughout the app
- All major UI components use glass-morphism: info tags, booking form, dialogs, and bottom button
- `BackdropFilter` with 20px blur applied consistently for frosted glass aesthetic
- Stateful widgets with gesture detection (`GestureDetector`)
- Swipe gesture handling via `onHorizontalDragStart`, `onHorizontalDragUpdate`, `onHorizontalDragEnd`
- Drag distance accumulation using `details.delta.dx` for cross-platform compatibility
- `AnimatedSlide` widgets for diagonal motion transitions (triangular path effect)
- `AnimatedOpacity` for fade-in/fade-out effects
- Complex animation state management with multiple boolean flags (`_isSwipedLeft`, `_isBookingPressed`)
- Conditional offset calculations preserve horizontal positions during vertical animations
- Material Design with custom color scheme (blue primary swatch)
- Responsive positioning using MediaQuery for screen size calculations
- Reusable StatelessWidget components (TruckTag, ShopTag) with glass-morphism overlays
- Custom styled dialogs matching app theme (success/error popups with backdrop blur)

### Firebase/Backend
- **Database**: Cloud Firestore (`cloud_firestore: ^6.0.2`)
- **Collection Structure**: `/bookings/{bookingId}` - flat structure for all bookings
- **Data Model**: Each booking contains:
  - `userId`: Guest ID or authenticated user ID
  - `name`: Customer name
  - `phoneNumber`: Contact number
  - `services`: Array of selected services
  - `locationType`: "Come to me" or "Visit our shop"
  - `createdAt`: Server timestamp
  - `status`: "pending", "confirmed", "completed", or "cancelled"
  - `paymentAmount`: Payment amount (optional, for completed bookings)
  - `completionDate`: Completion date (optional, for completed bookings)
- **BookingService**: Provides methods for:
  - `createBooking()`: Submit new booking
  - `getUserBookings()`: Fetch bookings by user
  - `getAllBookings()`: Admin query for all bookings
  - `getBookingsByStatus()`: Filter bookings by status
  - `updateBookingStatus()`: Admin booking management
  - `completeBooking()`: Complete a booking with payment amount and completion date
  - `streamAllBookings()`: Real-time admin dashboard updates
  - `streamUserBookings()`: Real-time user booking updates
- **Guest Users**: Currently uses `guest_{timestamp}` pattern for userId (can be upgraded to Firebase Auth)

### Booking Form
- Glass-morphism styling matching the overall design aesthetic
- **Validation**: Enforces all required fields before Firebase submission (`lib/screens/tire_service_screen.dart:380-397`)
  - Name: Required, non-empty string
  - Phone number: Required, non-empty string
  - Services: At least one service must be selected
  - Location: **Required** - user must explicitly select either "Come to me" or "Visit our shop"
    - Validation applies even when only one option is available
    - Checks for both `null` and empty string values
- Shows loading indicator (CircularProgressIndicator) during submission
- Displays custom styled success/error dialogs with glass-morphism and backdrop blur
- Success dialog: "Success! 🎉" with confirmation message
- Error dialog: Shows specific validation error messages with clear instructions
- Clears form after successful submission
- **Conditional Location Options**: Disables "Come to me" option when inspection or auto repair services are selected
  - Logic in `_isComeToMeDisabled` getter (`lib/screens/tire_service_screen.dart:375-378`)
  - Visually indicated with 0.3 opacity and strikethrough text
- "Send! 📲" button with visual feedback
- **Copy-to-Clipboard Functionality**:
  - Copy buttons for phone number and shop address
  - Glass-morphism styled buttons positioned bottom-right of container
  - Icon changes from copy to check for 1.5 seconds on click
  - Uses Flutter's `Clipboard.setData()` API

### Admin Dashboard (`AdminDashboardScreen`)
- **Access**: Navigate to `http://localhost:8080/#/admin` in browser
- **Real-time Updates**: Uses `streamAllBookings()` for live data from Firestore
- **Two Main Sections**:
  1. **Upcoming Bookings**: Shows pending/confirmed bookings
     - Displays all booking details (name, phone, services, location, date)
     - Status badge (orange for pending, blue for confirmed)
     - "Mark as Completed" button opens dialog for payment entry
  2. **Completed Bookings**: Shows finalized bookings
     - Green "COMPLETED" status badge
     - Shows payment amount in green with $ icon
     - Displays both booking date and completion date
- **Payment Dialog**:
  - Text field for payment amount ($)
  - Date picker for completion date
  - Validates payment amount before submission
  - Calls `completeBooking()` service method
- **UI Design**:
  - Dark gray (#404040) background matching main app
  - Glass-morphism styled cards for bookings
  - Empty state messages when no bookings exist
  - Material icons for visual indicators
- **Dependencies**: Uses `intl` package (^0.19.0) for date formatting (DateFormat)

## Refactoring Guidelines

When working with this codebase, follow the guidelines in `tools/R.md`:
- Only refactor when there is repetitive or overly complex code
- Prioritize simplicity and minimalism
- Do not modify public APIs
- Keep code clean and maintainable
