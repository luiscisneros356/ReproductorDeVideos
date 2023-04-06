import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:verifarma/domain/providers/providers.dart';
import 'package:verifarma/presentation/routes/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    _animation = Tween<double>(begin: 0, end: pi * 2).animate(_controller);
    nav();

    super.initState();
  }

  Future<void> nav() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
//Eror:
// Unhandled Exception: Concurrent modification during iteration: Instance(length:5) of '_GrowableList'.
      if (userProvider.hasSessionActiveDB) {
        await userProvider.checkUser();
        if (mounted) Navigator.pushReplacementNamed(context, RoutesApp.home);
      } else {
        Navigator.pushReplacementNamed(context, RoutesApp.auth);
      }
    }
  }

  Future<void> goTo(String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) =>
            Transform.rotate(angle: _animation.value, child: Image.asset("assets/splash.png")));
  }
}
