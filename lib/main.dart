import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/app.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WifNotifier(),
      child: const App(),
    ),
  );
}

