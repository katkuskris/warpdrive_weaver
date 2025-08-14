import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/models/wif_notifier.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WIF Shaft Count')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Current number of shafts:'),
            // Consumer looks for an ancestor Provider widget
            // and retrieves its model (Counter, in this case).
            // Then it uses that model to build widgets, and will trigger
            Consumer<WifNotifier>(
              builder: (context, wifNotifier, child) {
                // Get the WifObject from the notifier
                final wifObject = wifNotifier.currentWif;

                // Safely access the shaft count.
                // If weavingSection or shafts could be null, the default of 0 is used.
                final int shaftCount = wifObject.weavingSection?.shafts ?? 0;

                return Text(
                  '$shaftCount', // Use the correctly obtained shaftCount
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use context.read<WifNotifier>() to access your WifNotifier
          // instance for calling methods within a callback like onPressed.
          // This gets the current state/notifier but doesn't register for rebuilds.
          final wifNotifier = context.read<WifNotifier>();

          // Call your method to increment the shaft count (or any other action)
          wifNotifier.incrementShaftCount(); // Assuming you have this method
        },
        tooltip: 'Increment Shafts', // Updated tooltip
        child: const Icon(Icons.add),
      ),
    );
  }
}
