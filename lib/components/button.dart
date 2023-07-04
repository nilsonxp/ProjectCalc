// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);
  final String text;
  final bool big;
  final Color color;
  final void Function(String) cb; // Call Back

  const Button({
    required this.text,
    this.big = false,
    this.color = DEFAULT,
    required this.cb,
  });

  const Button.operation({
    required this.text,
    this.big = false,
    this.color = OPERATION,
    required this.cb,
  });

  const Button.dark({
    required this.text,
    this.big = false,
    this.color = DARK,
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(color),
        ),
        onPressed: () => cb(text),
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          maxFontSize: 32,
          minFontSize: 20,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
