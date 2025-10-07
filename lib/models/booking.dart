import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String userId;
  final String name;
  final String phoneNumber;
  final List<String> services;
  final String locationType; // 'Come to me' or 'Visit our shop'
  final DateTime createdAt;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final double? paymentAmount; // Amount paid for completed bookings
  final DateTime? completionDate; // Date when booking was completed

  Booking({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.services,
    required this.locationType,
    required this.createdAt,
    this.status = 'pending',
    this.paymentAmount,
    this.completionDate,
  });

  // Convert Booking to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'services': services,
      'locationType': locationType,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status,
      'paymentAmount': paymentAmount,
      'completionDate': completionDate != null ? Timestamp.fromDate(completionDate!) : null,
    };
  }

  // Create Booking from Firestore document
  factory Booking.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Booking(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      services: List<String>.from(data['services'] ?? []),
      locationType: data['locationType'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      status: data['status'] ?? 'pending',
      paymentAmount: data['paymentAmount']?.toDouble(),
      completionDate: data['completionDate'] != null ? (data['completionDate'] as Timestamp).toDate() : null,
    );
  }

  // Copy with method for updating fields
  Booking copyWith({
    String? id,
    String? userId,
    String? name,
    String? phoneNumber,
    List<String>? services,
    String? locationType,
    DateTime? createdAt,
    String? status,
    double? paymentAmount,
    DateTime? completionDate,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      services: services ?? this.services,
      locationType: locationType ?? this.locationType,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      completionDate: completionDate ?? this.completionDate,
    );
  }
}
