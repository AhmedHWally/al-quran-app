import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final dynamic screen;
  final dynamic arguments;
  final String title;
  CustomButton({required this.screen, this.arguments, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(screen, arguments: arguments);
      },
      child: Text(
        title,
        style: const TextStyle(shadows: [
          Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
        ]),
      ),
    );
  }
}
