import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.icon,
    required this.keyboard,
    required this.hint,
    required this.errorText,
    this.isError = false,
    required this.inputController,
  });
  final TextEditingController inputController;
  final Icon icon;
  final TextInputType keyboard;
  final String hint;
  final String errorText;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: TextField(
          controller: inputController,
          decoration: InputDecoration(
            filled: true,
            errorText: isError ? errorText : null,
            hintText: hint,
          ),
          keyboardType: keyboard),
    );
  }
}
