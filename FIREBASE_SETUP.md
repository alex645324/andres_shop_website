# Firebase Integration - Book Today Feature

## Overview
This document describes the Firebase integration for the "Book Today" booking system in the Andres Tire Service app.

## Setup Summary

### 1. Firebase Configuration
- **Project ID**: `tirews-d7184`
- **Platforms Configured**: Android, iOS, macOS, Web, Windows
- **Firebase Services**: Firebase Core, Cloud Firestore

### 2. Dependencies Added
```yaml
firebase_core: ^4.1.1
cloud_firestore: ^6.0.2
```

### 3. Firebase Initialization
Firebase is initialized in `lib/main.dart` before the app starts:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

## Data Structure

### Firestore Collection: `/bookings`

Each booking document contains:
- **userId** (string): Unique identifier for the user/customer
- **name** (string): Customer's name
- **phoneNumber** (string): Contact phone number
- **services** (array): List of selected services (e.g., ["new tires", "wheel balance"])
- **locationType** (string): Either "Come to me" or "Visit our shop"
- **createdAt** (timestamp): Server-generated timestamp
- **status** (string): Booking status - "pending", "confirmed", "completed", or "cancelled"

### Example Document
```json
{
  "userId": "guest_1696847200000",
  "name": "John Doe",
  "phoneNumber": "(661) 555-1234",
  "services": ["new tires", "wheel balance"],
  "locationType": "Come to me",
  "createdAt": "2025-10-07T12:00:00.000Z",
  "status": "pending"
}
```

## Implementation Details

### 1. Booking Model (`lib/models/booking.dart`)
- Dart class representing a booking
- Includes `toMap()` for Firestore serialization
- Includes `fromFirestore()` factory for deserialization
- Includes `copyWith()` for immutable updates

### 2. BookingService (`lib/services/booking_service.dart`)
Provides the following methods:

**Create Operations:**
- `createBooking()`: Submit a new booking to Firestore

**Read Operations:**
- `getUserBookings(userId)`: Get all bookings for a specific user
- `getAllBookings()`: Admin function to get all bookings
- `getBookingsByStatus(status)`: Filter bookings by status

**Update Operations:**
- `updateBookingStatus(bookingId, status)`: Change booking status

**Delete Operations:**
- `deleteBooking(bookingId)`: Remove a booking

**Real-time Streams:**
- `streamAllBookings()`: Real-time updates of all bookings (for admin dashboard)
- `streamUserBookings(userId)`: Real-time updates of user's bookings

### 3. Booking Form Integration (`lib/screens/tire_service_screen.dart`)
The BookingForm widget:
- Validates all required fields
- Shows loading indicator during submission
- Displays success/error dialogs
- Auto-clears form after successful submission
- Disables "Come to me" when inspection/auto repair selected

## User Flow

1. User clicks "Book Today!" button
2. Booking form slides up with animation
3. User fills in:
   - Name
   - Phone number
   - Services needed (multi-select)
   - Location preference (mobile or shop visit)
4. User clicks "Send!"
5. Form validates input
6. Data is submitted to Firestore
7. Success dialog is shown
8. Form is cleared for next booking

## Admin Dashboard Preparation

The BookingService is ready to support an admin dashboard with:
- Real-time booking updates via `streamAllBookings()`
- Status filtering via `getBookingsByStatus()`
- Status management via `updateBookingStatus()`
- Booking deletion via `deleteBooking()`

### Suggested Admin Features
1. **Booking List View**: Display all bookings with status badges
2. **Status Management**: Buttons to change status (pending → confirmed → completed)
3. **Filtering**: Tabs or dropdowns to filter by status
4. **Real-time Updates**: Use StreamBuilder with `streamAllBookings()`
5. **Search**: Search by name, phone, or services
6. **Analytics**: Count bookings by status, service type, location type

## Security Considerations

### Current Implementation
- No authentication (uses guest IDs)
- Open read/write access to bookings collection (requires Firestore rules)

### Recommended Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow anyone to create bookings
    match /bookings/{bookingId} {
      allow create: if true;

      // Only authenticated admins can read/update/delete
      allow read, update, delete: if request.auth != null &&
                                   request.auth.token.admin == true;
    }
  }
}
```

### Future Enhancements
1. Add Firebase Authentication for user accounts
2. Implement admin role-based access control
3. Add email/SMS notifications on booking creation
4. Add booking confirmation/cancellation emails
5. Implement booking time slots and scheduling

## Testing

### Manual Testing Steps
1. Run the app: `flutter run -d chrome`
2. Click "Book Today!" button
3. Fill in the form with test data
4. Click "Send!"
5. Verify success dialog appears
6. Check Firebase Console → Firestore Database → bookings collection
7. Confirm new document was created with correct data

### Firebase Console Access
- URL: https://console.firebase.google.com/project/tirews-d7184
- Navigate to: Firestore Database → bookings collection

## Troubleshooting

### Common Issues

**Issue**: "Permission denied" errors
- **Solution**: Update Firestore security rules to allow writes

**Issue**: Bookings not appearing in Firestore
- **Solution**: Check Firebase initialization in main.dart
- **Solution**: Verify internet connection
- **Solution**: Check browser console for errors

**Issue**: "Failed to create booking" error
- **Solution**: Verify all required fields are filled
- **Solution**: Check Firestore rules
- **Solution**: Verify Firebase project configuration

## Next Steps

1. **Add Firebase Authentication**: Replace guest IDs with real user accounts
2. **Implement Admin Dashboard**: Create admin screen to manage bookings
3. **Add Notifications**: Email/SMS confirmations for bookings
4. **Add Analytics**: Track booking trends and popular services
5. **Implement Scheduling**: Add time slot selection for appointments
6. **Add User Profiles**: Allow users to view their booking history
