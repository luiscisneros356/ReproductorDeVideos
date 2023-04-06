import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.icon, required this.text, required this.onPressed});
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: text, icon: Icon(icon), label: Text(text, style: VioFarmaStyle.title()), onPressed: onPressed);
  }
}
