import 'package:flutter/material.dart';
import 'package:warp_drive_weaver/config/app_constants.dart';

class GridCell extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final Color cellColor;
  final Color borderColor;
  final bool isInteractive;
  final double borderWidth = 0.5;

  const GridCell({
    super.key,
    this.child,
    this.onTap,
    this.cellColor = Colors.white,
    this.borderColor = Colors.black,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      color: cellColor,
      border: Border.all(color: borderColor, width: borderWidth),
    );

    return GestureDetector(
      onTap: isInteractive ? onTap : null,
      child: Container(
        width: globalCellWidth,
        height: globalCellHeight,
        decoration: decoration,
        child: child != null ? Center(child: child) : null,
      ),
    );
  }
}
