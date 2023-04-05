import 'package:flutter/material.dart';

class CustomTexField extends StatelessWidget {
  const CustomTexField(
      {super.key,
      required this.hint,
      required this.validator,
      this.isInLoggin = false,
      this.showIcon = false,
      this.obscureText = false,
      this.onTap});
  final String hint;
  final bool isInLoggin;
  final bool showIcon;
  final bool obscureText;
  final VoidCallback? onTap;

  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: isInLoggin ? hint : "$hint del video",
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: showIcon ? const Icon(Icons.remove_red_eye) : const Icon(Icons.abc, size: 1),
          )),
      validator: validator,
    );
  }
}
