import 'package:flutter/foundation.dart';
import 'package:warp_drive_weaver/features/designer/models/wif_object.dart';


class WarpSectionNotifier extends ChangeNotifier {
  WarpSection _warpSection;

  WarpSectionNotifier(this._warpSection);

  WarpSection get section => _warpSection;

  void incrementThreadCount() {
    if (_warpSection.threads >= 48) return;
    _warpSection = _warpSection.copyWith(threads: _warpSection.threads + 1);
    notifyListeners();
  }

  void decrementThreadCount() {
    if (_warpSection.threads <= 0) return;
    _warpSection = _warpSection.copyWith(threads: _warpSection.threads - 1);
    notifyListeners();
  }

  void setThreadCount(int newWarpThreadCount) {
    if (newWarpThreadCount < 0 || newWarpThreadCount > 48) return;
    _warpSection = _warpSection.copyWith(threads: newWarpThreadCount);
    notifyListeners();
  }

  void setColor(int newColor) {
    _warpSection = _warpSection.copyWith(color: newColor);
    notifyListeners();
  }

  void setSymbol(int newSymbol) {
    _warpSection = _warpSection.copyWith(symbol: newSymbol);
    notifyListeners();
  }

  void setUnits(WarpUnit newUnit) {
    _warpSection = _warpSection.copyWith(units: newUnit);
    notifyListeners();
  }

  void setSpacing(double newSpacing) {
    _warpSection = _warpSection.copyWith(spacing: newSpacing);
    notifyListeners();
  }

  void setThickness(double newThickness) {
    _warpSection = _warpSection.copyWith(thickness: newThickness);
    notifyListeners();
  }

  void setSpacingZoom(int newSpacingZoom) {
    _warpSection = _warpSection.copyWith(spacingZoom: newSpacingZoom);
    notifyListeners();
  }

  void setThicknessZoom(int newThicknessZoom) {
    _warpSection = _warpSection.copyWith(thicknessZoom: newThicknessZoom);
    notifyListeners();
  }

  void updateSection(WarpSection newSection) {
    if (_warpSection != newSection) {
      _warpSection = newSection;
      notifyListeners();
    }
  }
}
