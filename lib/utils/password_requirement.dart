import 'package:flutter/material.dart';

class PasswordRequirementWidget extends StatelessWidget {
  final bool hasRequirement;
  final String text;

  const PasswordRequirementWidget({
    required this.hasRequirement,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: hasRequirement ? Colors.green : Colors.transparent,
            border: hasRequirement ? Border.all(color: Colors.transparent) : Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(child: Icon(Icons.check, color: Colors.white, size: 15)),
        ),
        SizedBox(width: 10),
        Text(text, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
