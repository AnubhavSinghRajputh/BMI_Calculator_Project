import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:body_mass_index_calculator/body_mass_index/BmiScreen.dart';  // ✅ Proper relative import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1D9BF0),
          secondary: Color(0xFF00D4AA),
          surface: Color(0xFF1D1E33),      // ✅ Added for cards
          onSurface: Color(0xFF51C4F0),    // ✅ Better contrast
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        useMaterial3: true,
        // ✅ Performance & accessibility improvements
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BmiScreen(),
      debugShowCheckedModeBanner: false,
      // ✅ Added for better error handling
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
