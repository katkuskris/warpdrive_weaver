import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_notifier.dart';
import 'package:warp_drive_weaver/features/designer/widgets/sized_grid.dart';


class ThreadingGrid extends StatelessWidget {
  const ThreadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final wifNotifier = context.watch<WifNotifier>();
    final weavingSection = wifNotifier.currentWif.weavingSection;
    final warpSection = wifNotifier.currentWif.warpSection;


    if (warpSection == null || weavingSection == null) {
      return const Center(child: Text('Weaving data not available.'));
    }

    if (weavingSection.shafts <= 0 || warpSection.threads <= 0) {
      return const Center(
        child: Text('Please set a valid number of shafts and threads.'),
      );
    }

    return SizedGrid(
      context: context,
      rowCount: weavingSection.shafts,
      columnCount: warpSection.threads,
    );
  }
}