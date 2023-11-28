import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.obscureText,
    required this.keyboardType,
    this.errorMsg,
    this.validator,
    this.prefixIcon,
    this.sufixIcon,
    this.focusNode,
    this.onChanged,
    this.onTap,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final String? errorMsg;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide:  BorderSide(
            color: Theme.of(context).colorScheme.tertiary),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide:  BorderSide(
            color: Theme.of(context).colorScheme.secondary),
          ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),
        errorText: errorMsg,
      ),
    );
  }
}
