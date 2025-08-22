import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/features/designer/widgets/horizontal_toolbar.dart';
import 'package:warp_drive_weaver/features/designer/widgets/pattern_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/shaft_count_editor.dart';
import 'package:warp_drive_weaver/features/designer/widgets/threading_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/tie_up_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/treadle_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/toolbar.dart';
import 'package:warp_drive_weaver/features/designer/widgets/stepper_control.dart';

class DesignerScreen extends StatelessWidget {
  const DesignerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double gridSpacing = 8.0;

    // Outer SingleChildScrollView for vertical scrolling of the whole page
    return Column(
      children: [
        Toolbar(),
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
                  const StepperControl(),
                  // const ShaftCountEditor(),
                  const SizedBox(height: gridSpacing),
                  // Horizontal scrolling for the 2x2 grid section
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        CompactNumberInput(
                          initialValue: 5,
                          minValue: 0,
                          maxValue: 20,
                          onChanged: (newValue) {
                            print("Selected value: $newValue");
                          },
                          buttonSize: 36, // Example size
                          spacing: 10,  // Example spacing
                        ),
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
