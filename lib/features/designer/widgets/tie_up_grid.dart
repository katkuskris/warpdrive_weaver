import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';
import 'package:warp_drive_weaver/features/designer/widgets/sized_grid.dart';


class TieUpGrid extends StatelessWidget {
  const TieUpGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final wifNotifier = context.watch<WifNotifier>();
    final weavingSection = wifNotifier.weavingSectionNotifier.section;

    final int shaftCount = weavingSection.shafts;
    final int treadleCount = weavingSection.treadles;

    if (shaftCount <= 0 || treadleCount <= 0) {
      return const Center(
        child: Text('Please set a valid number of shafts and treadles.'),
      );
    }

    return sizedGrid(
      context: context,
      rowCount: weavingSection.shafts,
      columnCount: weavingSection.treadles,
    );
  }
}