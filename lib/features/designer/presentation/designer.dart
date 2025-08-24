import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/widgets/pattern_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/threading_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/tie_up_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/treadle_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/toolbar.dart';
import 'package:warp_drive_weaver/features/designer/widgets/stepper_control.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';

class DesignerScreen extends StatelessWidget {
  const DesignerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double gridSpacing = 20.0;

    final wifNotifier = context.watch<WifNotifier>();

    final int currentTreadleCount =
        wifNotifier.currentWif.weavingSection.treadles;
    final int currentShaftCount =
        wifNotifier
            .currentWif
            .weavingSection
            .shafts; // Example for another stepper

    // Outer SingleChildScrollView for vertical scrolling of the whole page
    return Column(
      children: [
        Toolbar(
          children: [
            StepperControl(
              label: "Treadle Count",
              currentValue: currentTreadleCount,
              onIncrement: () {
                // Call methods on your specific section notifier
                wifNotifier.weavingSectionNotifier
                    .incrementTreadleCount();
              },
              onDecrement: () {
                wifNotifier.weavingSectionNotifier
                    .decrementTreadleCount();
              },
              onValueChanged: (newValue) {
                wifNotifier.weavingSectionNotifier.setTreadleCount(
                  newValue,
                );
              },
            ),
            StepperControl(
              label: "Shaft Count",
              currentValue: currentShaftCount,
              onIncrement: () {
                // Call methods on your specific section notifier
                wifNotifier.weavingSectionNotifier
                    .incrementShaftCount();
              },
              onDecrement: () {
                wifNotifier.weavingSectionNotifier
                    .decrementShaftCount();
              },
              onValueChanged: (newValue) {
                wifNotifier.weavingSectionNotifier.setShaftCount(
                  newValue,
                );
              },
            )
          ]
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ), // Padding for the whole scrollable area
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .center, // Center ShaftCountEditor and the grid block
                children: [

                  // const ShaftCountEditor(),
                  const SizedBox(height: gridSpacing),
                  // Horizontal scrolling for the 2x2 grid section
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // CompactNumberInput(
                        //   initialValue: 5,
                        //   minValue: 0,
                        //   maxValue: 20,
                        //   onChanged: (newValue) {
                        //     print("Selected value: $newValue");
                        //   },
                        //   buttonSize: 36, // Example size
                        //   spacing: 10,  // Example spacing
                        // ),
                        // First row of the 2x2 grid
                        Row(
                          mainAxisSize:
                              MainAxisSize
                                  .min, // Keep rows tight to their content
                          children: [
                            const ThreadingGrid(),
                            const SizedBox(width: gridSpacing),
                            const TieUpGrid(),
                          ],
                        ),
                        const SizedBox(height: gridSpacing),
                        // Second row of the 2x2 grid
                        Row(
                          mainAxisSize:
                              MainAxisSize
                                  .min, // Keep rows tight to their content
                          children: [
                            const PatternGrid(),
                            const SizedBox(width: gridSpacing),
                            const TreadleGrid(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
