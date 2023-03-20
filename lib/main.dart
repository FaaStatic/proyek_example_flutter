import 'package:flutter/material.dart';
import 'package:proyek_example/src/util/routemanager.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteManager().route,
    );
  }
}
