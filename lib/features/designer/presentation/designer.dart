import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/features/designer/widgets/pattern_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/shaft_count_editor.dart';
import 'package:warp_drive_weaver/features/designer/widgets/threading_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/tie_up_grid.dart';
import 'package:warp_drive_weaver/features/designer/widgets/treadle_grid.dart';

class DesignerScreen extends StatelessWidget {
  const DesignerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const ShaftCountEditor(),
          const SizedBox(height: 8),
          const TieUpGrid(),
          const SizedBox(height: 8),
          const TreadleGrid(),
          const SizedBox(height: 8),
          const ThreadingGrid(),
          const SizedBox(height: 8),
          const PatternGrid(),
        ]
    );
  }
}




