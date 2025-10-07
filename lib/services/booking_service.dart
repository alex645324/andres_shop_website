import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'bookings';

  // Create a new booking
  Future<String> createBooking({
    required String userId,
    required String name,
    required String phoneNumber,
    required List<String> services,
    required String locationType,
  }) async {
    try {
      // Create booking document
      final docRef = await _firestore.collection(_collectionName).add({
        'userId': userId,
        'name': name,
        'phoneNumber': phoneNumber,
        'services': services,
        'locationType': locationType,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  // Get all bookings for a user
  Future<List<Booking>> getUserBookings(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Booking.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user bookings: $e');
    }
  }

  // Get all bookings (for admin)
  Future<List<Booking>> getAllBookings() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Booking.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all bookings: $e');
    }
  }

  // Get bookings by status (for admin filtering)
  Future<List<Booking>> getBookingsByStatus(String status) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('status', isEqualTo: status)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Booking.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get bookings by status: $e');
    }
  }

  // Update booking status
  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      await _firestore.collection(_collectionName).doc(bookingId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update booking status: $e');
    }
  }

  // Complete a booking with payment information
  Future<void> completeBooking({
    required String bookingId,
    required double paymentAmount,
    required DateTime completionDate,
  }) async {
    try {
      await _firestore.collection(_collectionName).doc(bookingId).update({
        'status': 'completed',
        'paymentAmount': paymentAmount,
        'completionDate': Timestamp.fromDate(completionDate),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to complete booking: $e');
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String bookingId) async {
    try {
      await _firestore.collection(_collectionName).doc(bookingId).delete();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  // Stream of all bookings (for real-time admin dashboard)
  Stream<List<Booking>> streamAllBookings() {
    return _firestore
        .collection(_collectionName)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList());
  }

  // Stream of user bookings (for real-time updates)
  Stream<List<Booking>> streamUserBookings(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList());
  }
}
