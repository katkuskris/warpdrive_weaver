import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/features/designer/widgets/grid_cell.dart';

import 'package:warp_drive_weaver/config/app_constants.dart';

Widget sizedGrid({
  required BuildContext context,
  required int rowCount,
  required int columnCount,
}) {
  if (rowCount <= 0 || columnCount <= 0) {
    return const SizedBox.shrink(); // Or some placeholder for an empty grid
  }

  double totalGridWidth = (columnCount * globalCellWidth) +
      ((columnCount - 1).clamp(0, double.infinity) * globalCellSpacing) +
      (2 * globalOuterGridBorderWidth);

  double totalGridHeight = (rowCount * globalCellHeight) +
      ((rowCount - 1).clamp(0, double.infinity) * globalCellSpacing) +
      (2 * globalOuterGridBorderWidth);

  return SizedBox(
    width: totalGridWidth,
    height: totalGridHeight,
    child: Container(
      color: Colors.black,
      padding: const EdgeInsets.all(globalOuterGridBorderWidth), // Creates the outer border frame
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes rows, utilizing spacing
        children: List.generate(rowCount, (r) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes cells, utilizing spacing
            children: List.generate(columnCount, (c) {
              // The cellBuilder provides the actual GridCellWidget or its content
              return const GridCell();
            }),
          );
        }),
      ),
    ),
  );
}