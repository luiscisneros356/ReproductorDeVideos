import 'package:flutter/material.dart';

import '../auth/auth_screen.dart';
import '../home/widgets/video_list.dart';
import '../splash/splash_screen.dart';

class RoutesApp {
  static const String home = "/home";
  static const String auth = "/auth";
  static const String splash = "/splash";

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      RoutesApp.home: (context) => const VideoList(),
      RoutesApp.auth: (context) => const AuthScreen(),
      RoutesApp.splash: (context) => const Splash()
    };
  }
}
