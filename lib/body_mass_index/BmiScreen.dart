import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmiResult = 0.0;
  String _resultText = '';
  String _resultCategory = '';
  bool _isCalculating = false;

  void _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter height and weight')),
      );
      return;
    }

    setState(() {
      _isCalculating = true;
    });

    HapticFeedback.lightImpact();

    double height = double.parse(_heightController.text) / 100; // Convert cm to m
    double weight = double.parse(_weightController.text);

    double bmi = weight / (height * height);

    setState(() {
      _bmiResult = bmi;
      _resultText = bmi.toStringAsFixed(1);

      if (bmi < 18.5) {
        _resultCategory = 'Under Weight';
      } else if (bmi >= 18.5 && bmi < 25) {
        _resultCategory = 'Healthy Weighted';
      } else if (bmi >= 25 && bmi < 30) {
        _resultCategory = 'Over Weight';
      } else {
        _resultCategory = 'Obese';
      }
      _isCalculating = false;
    });
  }

  Color _getResultColor() {
    switch (_resultCategory) {
      case 'Healthy Weighted':
        return const Color(0xFF00D4AA);
      case 'Under Weighted':
        return const Color(0xFF51C4F0);
      case 'Over Weighted':
        return const Color(0xFFFFB74D);
      default:
        return const Color(0xFFFF5370);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              const Text(
                'Body Mass Index Cal ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              // Input Cards
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Height Input
                    Expanded(
                      child: _buildInputCard(
                        'Please Enter Your Height (cm)',
                        Icons.height,
                        _heightController,
                        '170',
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Weight Input
                    Expanded(
                      child: _buildInputCard(
                        'Please Enter Your Weight (kg)',
                        Icons.fitness_center,
                        _weightController,
                        '70',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Calculate Button
              SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: _isCalculating ? null : _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D9BF0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                  ),
                  child: _isCalculating
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'FIND YOUR BODY MASS INDEX',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Result Card
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: _bmiResult > 0 ? _getResultColor() : const Color(0xFF262A43),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: _bmiResult > 0
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _resultCategory,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _resultText,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your BMI Score',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  )
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 64,
                        color: Colors.white54,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Enter your height\nand weight above in the seperatly!!\n Made By Anubhav Singh Rajput',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(
      String title,
      IconData icon,
      TextEditingController controller,
      String hint,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4A526B), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(icon, size: 32, color: const Color(0xFF51C4F0)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 32,
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
