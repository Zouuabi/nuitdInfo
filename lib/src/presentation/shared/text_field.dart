import '../../core/colors_manager.dart';
import 'package:flutter/material.dart';



class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.labelText,
    required this.errorMessage,
    required this.keyboardType,
    required this.icon,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    required this.isError 
  });
  
  final IconData? icon;
  final bool isError;
  final bool isPassword;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String errorMessage;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isVisible = false;

  final Icon invisibleIcon = Icon(
    Icons.remove_red_eye_outlined,
    color: ColorsManager.enabled,
  );
  final Icon visibleIcon = Icon(
    Icons.panorama_fish_eye,
    color: ColorsManager.primary,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      obscuringCharacter: '*',
      controller: widget.controller,
      obscureText: widget.isPassword ? !isVisible : isVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        errorText: widget.isError ? widget.errorMessage : null,
        labelText: widget.labelText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible ^= true;
                  });
                },
                icon: isVisible ? visibleIcon : invisibleIcon)
            : null,
      ),
    );
  }
}
