import 'package:flutter/material.dart';
import 'package:verifarma/presentation/routes/routes.dart';

import 'auth/auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const VerifarmaApp(),
      routes: RoutesApp.getRoutes(),
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
