import 'package:flutter/foundation.dart';
import 'package:warp_drive_weaver/wif_object.dart';


class WeftSectionNotifier extends ChangeNotifier {
  WeftSection _weftSection;

  WeftSectionNotifier(this._weftSection);

  WeftSection get section => _weftSection;

  void incrementThreadCount() {
    if (_weftSection.threads >= 48) return;
    _weftSection = _weftSection.copyWith(threads: _weftSection.threads + 1);
    notifyListeners();
  }

  void decrementThreadCount() {
    if (_weftSection.threads <= 0) return;
    _weftSection = _weftSection.copyWith(threads: _weftSection.threads - 1);
    notifyListeners();
  }

  void setShaftCount(int newWeftThreadCount) {
    if (newWeftThreadCount < 0 || newWeftThreadCount > 48) return;
    _weftSection = _weftSection.copyWith(threads: newWeftThreadCount);
    notifyListeners();
  }

  void setColor(int newColor) {
    _weftSection = _weftSection.copyWith(color: newColor);
    notifyListeners();
  }

  void setSymbol(int newSymbol) {
    _weftSection = _weftSection.copyWith(symbol: newSymbol);
    notifyListeners();
  }

  void setUnits(WeftUnit newUnit) {
    _weftSection = _weftSection.copyWith(units: newUnit);
    notifyListeners();
  }

  void setSpacing(double newSpacing) {
    _weftSection = _weftSection.copyWith(spacing: newSpacing);
    notifyListeners();
  }

  void setThickness(double newThickness) {
    _weftSection = _weftSection.copyWith(thickness: newThickness);
    notifyListeners();
  }

  void setSpacingZoom(int newSpacingZoom) {
    _weftSection = _weftSection.copyWith(spacingZoom: newSpacingZoom);
    notifyListeners();
  }

  void setThicknessZoom(int newThicknessZoom) {
    _weftSection = _weftSection.copyWith(thicknessZoom: newThicknessZoom);
    notifyListeners();
  }

  void updateSection(WeftSection newSection) {
    if (_weftSection != newSection) {
      _weftSection = newSection;
      notifyListeners();
    }
  }
}
