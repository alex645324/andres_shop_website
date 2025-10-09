import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../services/booking_service.dart';

class TireServiceScreen extends StatefulWidget {
  const TireServiceScreen({super.key});

  @override
  State<TireServiceScreen> createState() => _TireServiceScreenState();
}

class _TireServiceScreenState extends State<TireServiceScreen> {
  bool _isSwipedLeft = false;
  double _dragDistance = 0;
  bool _isBookingPressed = false;

  void _handleDragStart(DragStartDetails details) {
    _dragDistance = 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _dragDistance += details.delta.dx;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragDistance < -100) {
      setState(() => _isSwipedLeft = true);
    } else if (_dragDistance > 100) {
      setState(() => _isSwipedLeft = false);
    }
    _dragDistance = 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive offsets based on screen width
    final horizontalOffset = screenWidth > 600 ? 0.58 : 0.63;
    final imageSize = screenWidth > 600 ? 400.0 : screenWidth * 0.85;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF404040),
      body: GestureDetector(
        onTap: () {
          setState(() => _isSwipedLeft = !_isSwipedLeft);
        },
        onHorizontalDragStart: _handleDragStart,
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: Stack(
          children: [
          // Background image with 46% opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.46,
              child: Image.network(
                'Background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo in top left
          Positioned(
            top: 0,
            left: 16,
            child: Image.network(
              'logo.png',
              width: 120,
              height: 90,
            ),
          ),
          // Truck image in middle
          Positioned(
            top: screenHeight / 2 - (imageSize / 2) - 50,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed
                ? (_isSwipedLeft ? Offset(-horizontalOffset, -2.0) : const Offset(0, -2.0))
                : _isSwipedLeft ? Offset(-horizontalOffset, 0.15) : Offset.zero,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isBookingPressed ? 0.0 : 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        'Truck.png',
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Positioned(
                      bottom: 15,
                      child: TruckTag(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Shop image to the right, slightly lower, cut off at right edge
          Positioned(
            top: screenHeight / 2 - (imageSize / 2) - 50,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed
                ? (_isSwipedLeft ? const Offset(0, -2.0) : Offset(horizontalOffset, -2.0))
                : _isSwipedLeft ? Offset.zero : Offset(horizontalOffset, 0.15),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isBookingPressed ? 0.0 : 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        'Shop.png',
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Positioned(
                      bottom: 15,
                      child: ShopTag(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Swipe text
          Positioned(
            top: screenHeight / 2 + (imageSize / 2) - 30,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed ? const Offset(0, -2.0) : Offset.zero,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isBookingPressed ? 0.0 : 1.0,
                child: const Center(
                  child: Text(
                    'swipe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Booking form - slides up from bottom
          Positioned(
            top: 60,
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed ? Offset.zero : const Offset(0, 1.5),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: const BookingForm(),
                ),
              ),
            ),
          ),
          // Bottom button
          Positioned(
            bottom: 18,
            left: 90,
            right: 90,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _isBookingPressed ? 50 : 55,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.42),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(35),
                      onTap: () {
                        setState(() => _isBookingPressed = !_isBookingPressed);
                      },
                      child: Center(
                        child: Text(
                          _isBookingPressed ? 'Go Back' : 'Book Today! 👋',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class TruckTag extends StatelessWidget {
  const TruckTag({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 190,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade600.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Star rating
              const Text(
                '⭐️ 4.8',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              // Main heading
              const Text(
                'We come to you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              // Subtext
              const Text(
                'Full mobile tier service that comes to your home!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopTag extends StatelessWidget {
  const ShopTag({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 190,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade600.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Star rating
              const Text(
                '⭐️ 4.9',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              // Main heading
              const Text(
                'Visit our shop',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              // Subtext
              const Text(
                'Full tire service, Car repair,\nand inspections',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final Set<String> _selectedServices = {};
  String? _selectedLocation;
  final BookingService _bookingService = BookingService();
  bool _isSubmitting = false;
  bool _phoneCopied = false;
  bool _addressCopied = false;

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  bool get _isComeToMeDisabled {
    return _selectedServices.contains('inspection') ||
           _selectedServices.contains('auto repair');
  }

  Future<void> _submitBooking() async {
    // Validate form
    if (_nameController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your name');
      return;
    }
    if (_numberController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your phone number');
      return;
    }
    if (_selectedServices.isEmpty) {
      _showErrorDialog('Please select at least one service');
      return;
    }
    if (_selectedLocation == null || _selectedLocation!.isEmpty) {
      _showErrorDialog('Please select a location option: "Come to me" or "Visit our shop"');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // For now, we'll use a guest user ID. In a real app, you'd use Firebase Auth
      final userId = 'guest_${DateTime.now().millisecondsSinceEpoch}';

      await _bookingService.createBooking(
        userId: userId,
        name: _nameController.text.trim(),
        phoneNumber: _numberController.text.trim(),
        services: _selectedServices.toList(),
        locationType: _selectedLocation!,
      );

      if (mounted) {
        _showSuccessDialog();
        _clearForm();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to submit booking: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _clearForm() {
    _nameController.clear();
    _numberController.clear();
    setState(() {
      _selectedServices.clear();
      _selectedLocation = null;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text, String type) {
    Clipboard.setData(ClipboardData(text: text));

    setState(() {
      if (type == 'phone') {
        _phoneCopied = true;
      } else {
        _addressCopied = true;
      }
    });

    // Reset the icon back to copy after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          if (type == 'phone') {
            _phoneCopied = false;
          } else {
            _addressCopied = false;
          }
        });
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Success! 🎉',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your booking has been submitted.\nWe\'ll contact you shortly!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'OK 👍',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade600.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
      ),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact info row
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Call us at:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '(484)-536-9337',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _copyToClipboard('(661)-536-9337', 'phone'),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
                                  ),
                                  child: Icon(
                                    _phoneCopied ? Icons.check : Icons.copy,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Shop location:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '527 N. Madison St. Allentown\nPA. 18102',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _copyToClipboard('527 N. Madison St. Allentown, PA. 18102', 'address'),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
                                ),
                                child: Icon(
                                  _addressCopied ? Icons.check : Icons.copy,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                ),
              ),
              const SizedBox(height: 14),
              // Leave us a brief message
              const Text(
                'Leave us a brief message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // Name and Number fields
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _nameController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Your name',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _numberController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Number',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // My car needs...
              const Text(
                'My car needs...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              // Service chips - Row 1
              Wrap(
                spacing: 6,
                runSpacing: 5,
                children: [
                  _buildChip('new tires'),
                  _buildChip('use tires'),
                  _buildChip('air pressure'),
                ],
              ),
              const SizedBox(height: 5),
              // Service chips - Row 2
              Wrap(
                spacing: 6,
                runSpacing: 5,
                children: [
                  _buildChip('flat fix / plug'),
                  _buildChip('wheel balance'),
                ],
              ),
              const SizedBox(height: 5),
              // Service chips - Row 3
              Wrap(
                spacing: 6,
                runSpacing: 5,
                children: [
                  _buildChip('inspection'),
                  _buildChip('auto repair'),
                ],
              ),
              const SizedBox(height: 14),
              // We can come to you or you come to us?
              const Text(
                'We can come to you or you come to us?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // Location options
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _isComeToMeDisabled ? null : () {
                        setState(() {
                          _selectedLocation = 'Come to me';
                        });
                      },
                      child: Opacity(
                        opacity: _isComeToMeDisabled ? 0.3 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              _selectedLocation == 'Come to me' ? 0.6 : 0.3
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Come to me',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                decoration: _isComeToMeDisabled ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLocation = 'Visit our shop';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            _selectedLocation == 'Visit our shop' ? 0.6 : 0.3
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Visit our shop',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Send button
              GestureDetector(
                onTap: _isSubmitting ? null : _submitBooking,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_isSubmitting ? 0.2 : 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  child: Center(
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send! 📲',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
            ],
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedServices.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedServices.remove(label);
          } else {
            _selectedServices.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.6)
              : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}