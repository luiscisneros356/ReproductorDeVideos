import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.icon, required this.text, required this.onPressed, required this.visible});
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: FloatingActionButton.extended(
          heroTag: text, icon: Icon(icon), label: Text(text, style: VioFarmaStyle.title()), onPressed: onPressed),
    );
  }
}
