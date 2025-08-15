import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/navigation/main_app_layout.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MainAppLayout(),
    );
  }
}

