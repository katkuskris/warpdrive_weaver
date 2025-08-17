import 'package:flutter/foundation.dart';
import 'package:warp_drive_weaver/features/designer/models/wif_object.dart';


class WeavingSectionNotifier extends ChangeNotifier {
  WeavingSection? _weavingSection;

  WeavingSectionNotifier(this._weavingSection);

  WeavingSection? get section => _weavingSection;

  void incrementShaftCount() {
    if (_weavingSection == null) return;
    if (_weavingSection!.shafts >= 48) return;
    _weavingSection = _weavingSection!.copyWith(shafts: _weavingSection!.shafts + 1);
    notifyListeners();
  }

  void decrementShaftCount() {
    if (_weavingSection == null) return;
    if (_weavingSection!.shafts <= 0) return;
    _weavingSection = _weavingSection!.copyWith(shafts: _weavingSection!.shafts - 1);
    notifyListeners();
  }

  void setShaftCount(int newShaftCount) {
    if (_weavingSection == null) return;
    if (newShaftCount < 0 || newShaftCount > 48) return;
    _weavingSection = _weavingSection!.copyWith(shafts: newShaftCount);
    notifyListeners();
  }

  // --- Treadles ---
  void incrementTreadleCount() {
    if (_weavingSection == null) return;
    if (_weavingSection!.treadles >= 16) return;
    _weavingSection = _weavingSection!.copyWith(treadles: _weavingSection!.treadles + 1);
    notifyListeners();
  }

  void decrementTreadleCount() {
    if (_weavingSection == null) return;
    if (_weavingSection!.treadles <= 0) return;
    _weavingSection = _weavingSection!.copyWith(treadles: _weavingSection!.treadles - 1);
    notifyListeners();
  }

  void setTreadleCount(int newTreadleCount) {
    if (_weavingSection == null) return;
    if (newTreadleCount < 0 || newTreadleCount > 16) return;
    _weavingSection = _weavingSection!.copyWith(treadles: newTreadleCount);
    notifyListeners();
  }

  // --- Rising Shed & Profile ---
  void setRisingShed(bool newRisingShedValue) {
    if (_weavingSection == null) return;
    _weavingSection = _weavingSection!.copyWith(risingShed: newRisingShedValue);
    notifyListeners();
  }

  void setProfile(bool newProfileValue) {
    if (_weavingSection == null) return;
    _weavingSection = _weavingSection!.copyWith(profile: newProfileValue);
    notifyListeners();
  }

  void updateSection(WeavingSection newSection) {
    if (_weavingSection != newSection) {
      _weavingSection = newSection;
      notifyListeners();
    }
  }
}
