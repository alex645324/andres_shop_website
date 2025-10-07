import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/tire_service_screen.dart';
import 'screens/admin_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andres Tire Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TireServiceScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/admin') {
          return MaterialPageRoute(
            builder: (context) => const AdminDashboardScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const TireServiceScreen(),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}