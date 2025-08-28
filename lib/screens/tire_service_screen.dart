import 'package:flutter/material.dart';
import 'dart:ui';

class TireServiceScreen extends StatefulWidget {
  const TireServiceScreen({super.key});

  @override
  State<TireServiceScreen> createState() => _TireServiceScreenState();
}

class _TireServiceScreenState extends State<TireServiceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF404040),
      body: Stack(
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
            left: 0,
            child: Image.asset(
              'assets/logo.png',
              width: 80,
              height: 60,
            ),
          ),
          // Truck image in middle
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 275,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 350,
                height: 350,
                child: Image.asset(
                  'assets/Truck.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Swipe text
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 150,
            left: 0,
            right: 0,
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
          // Bottom button
          Positioned(
            bottom: 50,
            left: 80,
            right: 80,
            child: Container(
              height: 70,
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
                      onTap: () {},
                      child: const Center(
                        child: Text(
                          'Book Today! 👋',
                          style: TextStyle(
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
    );
  }
}