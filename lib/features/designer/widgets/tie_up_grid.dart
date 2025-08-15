import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';

class TieUpGrid extends StatelessWidget {
  const TieUpGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final wifNotifier = context.watch<WifNotifier>();
    final weavingSection = wifNotifier.weavingSectionNotifier.section;

    if (weavingSection == null) {
      return const Center(child: Text('Weaving data not available.'));
    }

    final int shaftCount = weavingSection.shafts;
    final int treadleCount = weavingSection.treadles;

    if (shaftCount <= 0 || treadleCount <= 0) {
      return const Center(
          child: Text('Please set a valid number of shafts and treadles.'));
    }

    final int totalCells = shaftCount * treadleCount;

    double borderWidth = 2.0;

    return Container(
      color: Colors.grey, // This will be the border color
      padding: EdgeInsets.all(borderWidth), // Optional: for the outer border
      child: GridView.builder(
        // ... other GridView properties
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: treadleCount,
          mainAxisSpacing: borderWidth, // Spacing acts as border line
          crossAxisSpacing: borderWidth, // Spacing acts as border line
          childAspectRatio: 1.0,
        ),
        itemCount: shaftCount * treadleCount,
        itemBuilder: (BuildContext context, int index) {
          final int shaftIndex = index ~/ treadleCount;
          final int treadleIndex = index % treadleCount;

          // bool isTiedUp = getTieUpState(shaftIndex, treadleIndex);

          return GestureDetector(
            onTap: () {
              // ... your tap logic
            },
            child: Container(
              // Color of the cell itself
              color: Colors.white,
              // Or based on isTiedUp, e.g., isTiedUp ? Colors.black : Colors.white
              child: Center(
                child: Text(
                  'S${shaftIndex + 1}\nT${treadleIndex + 1}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    // color: isTiedUp ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
// Placeholder for fetching/updating tie-up state.
// You'd integrate this with your actual data model and notifier.
// bool getTieUpState(int shaftIndex, int treadleIndex) {
//   // Return the state from your model, e.g., a List<List<bool>>
//   return false; // Default
// }
//
// void toggleTieUpState(int shaftIndex, int treadleIndex) {
//   // Update the state in your model and notify listeners.
// }
}


