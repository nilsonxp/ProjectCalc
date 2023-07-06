import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newcalculator/components/display.dart';
import 'package:newcalculator/components/keyboard.dart';
import 'package:newcalculator/models/memory.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); // Trava a orientação
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: [
          Display(text: memory.value),
          Keyboard(cb: _onPressed),
          // SizedBox(height: 20)
        ],
      ),
    );
  }
}
