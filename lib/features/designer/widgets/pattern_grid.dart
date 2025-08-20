import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';
import 'package:warp_drive_weaver/features/designer/widgets/sized_grid.dart';


class PatternGrid extends StatelessWidget {
  const PatternGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final wifNotifier = context.watch<WifNotifier>();
    final warpSection = wifNotifier.currentWif.warpSection;
    final weftSection = wifNotifier.currentWif.weftSection;


    if (warpSection == null || weftSection == null) {
      return const Center(child: Text('Weaving data not available.'));
    }

    if (warpSection.threads <= 0 || weftSection.threads <= 0) {
      return const Center(
        child: Text('Please set a valid number of threads.'),
      );
    }

    return sizedGrid(
      context: context,
      rowCount: weftSection.threads,
      columnCount: warpSection.threads,
    );
  }
}