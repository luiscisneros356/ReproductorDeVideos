import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

Future<void> showCustomDialog(
  BuildContext context, {
  required String text,
  required VoidCallback onPressedNo,
  required VoidCallback onPressedSI,
}) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: Text(
              text,
              style: VioFarmaStyle.title(),
            ),
            actions: [
              TextButton(
                onPressed: onPressedNo,
                child: const Text("NO"),
              ),
              TextButton(
                onPressed: onPressedSI,
                child: const Text("SI"),
              ),
            ],
          ));
}
