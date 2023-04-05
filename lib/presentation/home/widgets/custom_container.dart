import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.onTap,
      this.backgroundColor,
      this.color});

  final double height;
  final double width;
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(width: 1)),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
