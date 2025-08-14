import 'package:flutter/foundation.dart';
import 'package:warp_drive_weaver/models/wif_object.dart';


class WifNotifier extends ChangeNotifier {
  WifObject _wifObject = WifObject(
    weavingSection: WeavingSection(
      shafts: 4,
      treadles: 6,
    ),
  );

  WifObject get currentWif => _wifObject;

  void incrementShaftCount() {
    if (_wifObject.weavingSection == null) return; // Or handle differently

    final WeavingSection currentSection = _wifObject.weavingSection!;

    final newWeavingSection = _wifObject.weavingSection!.copyWith(
      shafts: currentSection.shafts + 1,
    );
    _wifObject = _wifObject.copyWith(weavingSection: newWeavingSection);

    notifyListeners();
  }

  void updateTreadleCount(int newTreadleCount) {
    if (_wifObject.weavingSection == null) return;

    final newWeavingSection = _wifObject.weavingSection!.copyWith(
      treadles: newTreadleCount,
    );
    _wifObject = _wifObject.copyWith(weavingSection: newWeavingSection);
    notifyListeners();
  }

}
