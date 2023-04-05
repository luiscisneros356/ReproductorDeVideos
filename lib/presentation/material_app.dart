import 'package:flutter/material.dart';

import 'auth/auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: VerifarmaApp(),
    );
  }
}

class VerifarmaApp extends StatelessWidget {
  const VerifarmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
