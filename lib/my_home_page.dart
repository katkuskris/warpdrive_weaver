import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/models/wif_notifier.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WIF Shaft Count')),
      body: Padding( // Added padding around the content for better spacing
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Directionality(
            textDirection: TextDirection.ltr, // Or .rtl as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally in the column
            children: <Widget>[
              const Text(
                'Current number of shafts:',
                style: TextStyle(fontSize: 18), // Slightly larger text
              ),
              Consumer<WifNotifier>(
                builder: (context, wifNotifier, child) {
                  final int shaftCount = wifNotifier.currentWif.weavingSection?.shafts ?? 0;
                  return Text(
                    '$shaftCount',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  );
                },
              ),
              const SizedBox(height: 20), // Spacing

              // --- Increment/Decrement Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<WifNotifier>().weavingSectionNotifier.decrementShaftCount();
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 20), // Spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      context.read<WifNotifier>().weavingSectionNotifier.incrementShaftCount();
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Spacing

              // --- Direct Input for Shaft Count ---
              const Text(
                'Set Shaft Count Directly:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              SizedBox( // Constrain the width of the TextFormField
                width: 150,
                child: TextFormField(
                  initialValue: context.watch<WifNotifier>().currentWif.weavingSection?.shafts.toString() ?? '0', // Show current value
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'e.g., 8',
                  ),
                  onFieldSubmitted: (value) {
                    final newShaftCount = int.tryParse(value);
                    if (newShaftCount != null && newShaftCount > 0) { // Basic validation
                      context.read<WifNotifier>().weavingSectionNotifier.setShaftCount(newShaftCount);
                    } else {
                      // Optional: Show a snackbar or error message for invalid input
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid shaft count. Please enter a positive number.')),
                      );
                    }
                  },
                  // It's good practice to add more robust validation if needed
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final number = int.tryParse(value);
                    if (number == null) {
                      return 'Invalid number';
                    }
                    if (number < 1) { // Your minimum shaft count
                      return 'Must be at least 1';
                    }
                    if (number > 48) { // Your maximum shaft count (example)
                      return 'Cannot exceed 48';
                    }
                    return null; // Input is valid
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as user types or on submit
                ),
              ),
            ],
          ),
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use context.read<WifNotifier>() to access your WifNotifier
          // instance for calling methods within a callback like onPressed.
          // This gets the current state/notifier but doesn't register for rebuilds.
          final wifNotifier = context.read<WifNotifier>();

          // Call your method to increment the shaft count (or any other action)
          wifNotifier.weavingSectionNotifier.incrementShaftCount(); // Assuming you have this method
        },
        tooltip: 'Increment Shafts', // Updated tooltip
        child: const Icon(Icons.add),
      ),
    );
  }
}
