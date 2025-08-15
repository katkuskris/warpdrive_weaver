// lib/widgets/generic_sized_grid.dart
import 'package:flutter/material.dart';

import '../../../../config/app_constants.dart';

Widget buildSizedGrid({
  required BuildContext context,
  required int rowCount,
  required int columnCount,
  required Widget Function(BuildContext context, int row, int col) cellBuilder,
  Color gridBorderColor = Colors.black, // Color of the spacing/border lines
}) {
  if (rowCount <= 0 || columnCount <= 0) {
    return SizedBox.shrink(); // Or some placeholder for an empty grid
  }

  // Calculate total dimensions based on global cell sizes and spacing
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
      padding: const EdgeInsets.all(globalOuterGridBorderWidth), // Creates the outer border frame
      color: gridBorderColor, // This color shows through the spacing to form grid lines
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes rows, utilizing spacing
        children: List.generate(rowCount, (r) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes cells, utilizing spacing
            children: List.generate(columnCount, (c) {
              // The cellBuilder provides the actual GridCellWidget or its content
              return cellBuilder(context, r, c);
            }),
          );
        }),
      ),
    ),
  );
}