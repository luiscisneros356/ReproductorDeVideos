import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

Future<void> showCustomDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(
              "Deseas ver mas videos recomendados para a vos",
              style: VioFarmaStyle.title(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Scaffold.of(context).openDrawer();
                },
                child: const Text("SI"),
              ),
            ],
          ));
}
