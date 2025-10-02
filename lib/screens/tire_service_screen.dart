import 'package:flutter/material.dart';
import 'dart:ui';

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
    return Scaffold(
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
              child: Image.asset(
                'assets/Background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo in top left
          Positioned(
            top: 0,
            left: 16,
            child: Image.asset(
              'assets/logo.png',
              width: 120,
              height: 90,
            ),
          ),
          // Truck image in middle
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 245,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed
                ? (_isSwipedLeft ? const Offset(-0.6, -2.0) : const Offset(0, -2.0))
                : _isSwipedLeft ? const Offset(-0.6, 0.15) : Offset.zero,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isBookingPressed ? 0.0 : 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/Truck.png',
                        width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Positioned(
                      bottom: 25,
                      child: TruckTag(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Shop image to the right, slightly lower, cut off at right edge
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 245,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed
                ? (_isSwipedLeft ? const Offset(0, -2.0) : const Offset(0.6, -2.0))
                : _isSwipedLeft ? Offset.zero : const Offset(0.6, 0.15),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isBookingPressed ? 0.0 : 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/Shop.png',
                        width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Positioned(
                      bottom: 25,
                      child: ShopTag(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Swipe text
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 115,
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
            top: 65,
            bottom: 85,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              offset: _isBookingPressed ? Offset.zero : const Offset(0, 1.5),
              child: const Center(
                child: BookingForm(),
              ),
            ),
          ),
          // Bottom button
          Positioned(
            bottom: 20,
            left: 90,
            right: 90,
            child: Container(
              height: 60,
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
                            fontSize: 20,
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
    return Container(
      width: 185,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade600.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
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
              fontSize: 12,
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
              fontSize: 14,
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
    );
  }
}

class ShopTag extends StatelessWidget {
  const ShopTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade600.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
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
              fontSize: 12,
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
              fontSize: 14,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
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
              // Title
              const Text(
                'Book Today! 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              // Contact info row
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Call us at',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '(661)-536-9337',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shop location',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '527 N. Madison St. Alterton\nPA. 15102',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
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
                          fontSize: 13,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Your name',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
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
                          fontSize: 13,
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Number',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              // Service chips - Row 1
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildChip('new tires'),
                  _buildChip('use tires'),
                  _buildChip('air pressure'),
                ],
              ),
              const SizedBox(height: 6),
              // Service chips - Row 2
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildChip('flat fix / plug'),
                  _buildChip('wheel balance'),
                ],
              ),
              const SizedBox(height: 6),
              // Service chips - Row 3
              Wrap(
                spacing: 6,
                runSpacing: 6,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
                                fontSize: 12,
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
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Send button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                ),
                child: const Center(
                  child: Text(
                    'Send! 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}