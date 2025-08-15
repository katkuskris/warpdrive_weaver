

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/widgets/shaft_count_editor.dart';
import 'package:warp_drive_weaver/features/designer/widgets/grid_cell.dart';
import 'package:warp_drive_weaver/features/designer/widgets/sized_grid.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';

class Designer extends StatelessWidget {
  const Designer({super.key});

  Widget _buildTieUpGridWidget(BuildContext context) {
    final weavingSection = context.watch<WifNotifier>().currentWif.weavingSection;
    if (weavingSection == null || weavingSection.shafts <= 0 || weavingSection.treadles <= 0) {
      return const Center(child: Text('Define shafts and treadles for Tie-Up.'));
    }
    return buildSizedGrid(
      context: context,
      rowCount: weavingSection.shafts,
      columnCount: weavingSection.treadles,
      gridBorderColor: Colors.blueGrey,
      cellBuilder: (BuildContext cellContext, int row, int col) {
        bool isTied = (row + col) % 2 == 0;
        return GridCell(
          cellColor: isTied ? Colors.black54 : Colors.white,
          onTap: () {
            print('Tapped Tie-Up: Shaft ${row + 1}, Treadle ${col + 1}');
            // context.read<TieUpNotifier>().toggleCell(row, col);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShaftCountEditor(),
        const SizedBox(height: 8),
        _buildTieUpGridWidget(context), // Use the reactive version
        const SizedBox(height: 8),
      ]
    );
  }
}



