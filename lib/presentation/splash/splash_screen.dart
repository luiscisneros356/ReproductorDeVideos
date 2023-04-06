import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:verifarma/domain/providers/providers.dart';
import 'package:verifarma/presentation/routes/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      nav();
    });

    super.initState();
  }

  Future<void> nav() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
// Unhandled Exception: Concurrent modification during iteration: Instance(length:5) of '_GrowableList'.
      if (userProvider.hasSessionActiveDB) {
        userProvider.checkUser();

        Navigator.pushReplacementNamed(context, RoutesApp.home);
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
    return Image.asset("assets/splash.png");
  }
}
