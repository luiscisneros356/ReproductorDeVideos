import 'package:flutter/material.dart';

class IconRating extends StatelessWidget {
  const IconRating({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 36),
    );
  }
}

class StarsRating extends StatelessWidget {
  const StarsRating({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.star, color: Colors.orange);
  }
}
