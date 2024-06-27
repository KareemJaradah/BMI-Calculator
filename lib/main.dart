import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double? bmi;
  String bmiMessage = '';
  String imagePath = 'lib/assets/main_photo.png'; 


  void calculateBMI() {
    double height = double.parse(heightController.text) / 100; 
    double weight = double.parse(weightController.text);
    setState(() {
      bmi = weight / (height * height);
      updateBMIMessageAndImage();
    });
  }

  void updateBMIMessageAndImage() {
    if (bmi! < 20) {
      bmiMessage = 'Your weight is less than normal';
      imagePath = 'lib/assets/underweight.png';
    } else if (bmi! >= 20 && bmi! < 25) {
      bmiMessage = 'Your weight is normal';
      imagePath = 'lib/assets/fit.png';
    } else if (bmi! >= 25 && bmi! < 30) {
      bmiMessage = 'Your weight is overweight';
      imagePath = 'lib/assets/fat_photo.png';
    } else if (bmi! >= 30) {
      bmiMessage = 'Your weight is excessive obesity';
      imagePath = 'lib/assets/excessive.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'BMI Calculator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.asset(
              imagePath,
              width: 350,
              height: 300,
            ),
            SizedBox(height: 10),
            Text("Height in (Cm)"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your height',
                ),
              ),
            ),
            Text("Weight in (Kg)"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your weight',
                ),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              onPressed: calculateBMI,
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            if (bmi != null)
              Column(
                children: [
                  Text(
                    'Your BMI is ${bmi!.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    bmiMessage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
