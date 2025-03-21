import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dashboarduser.dart';
// Import the user type selection page

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Enable device preview
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waste Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const EcoBinDashboard(), // Open Get Started Page first
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
