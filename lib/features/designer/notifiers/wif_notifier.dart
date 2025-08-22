import 'package:flutter/foundation.dart';
import 'package:warp_drive_weaver/features/designer/notifiers/wif_object_section_notifiers/weaving_section_notifier.dart';
import 'package:warp_drive_weaver/features/designer/models/wif_object.dart';


class WifNotifier extends ChangeNotifier {
  WifObject _wifObject;

  // Hold instances of sub-notifiers
  late WeavingSectionNotifier weavingSectionNotifier;
  // late ColorPaletteNotifier colorPaletteNotifier; // Example for another section
  // ... other notifiers

  WifNotifier() : _wifObject = _initialWifObject() {
    // Initialize sub-notifiers, passing the relevant part of _wifObject
    weavingSectionNotifier = WeavingSectionNotifier(_wifObject.weavingSection);
    // colorPaletteNotifier = ColorPaletteNotifier(_wifObject.colorPalette ?? _defaultColorPalette());

    // Listen to changes in sub-notifiers to update the main WifObject
    // and notify listeners of WifNotifier if needed.
    weavingSectionNotifier.addListener(_onWeavingSectionChanged);
    // colorPaletteNotifier.addListener(_onColorPaletteChanged);
  }

  static WifObject _initialWifObject() {
    return WifObject(
      weavingSection: WeavingSection(
        shafts: 4,
        treadles: 6,
        risingShed: true,
      ),
      warpSection: WarpSection(
        threads: 20
      ),
      weftSection: WeftSection(
        threads: 15
      ),
      // Initialize other sections as needed
    );
  }

  WifObject get currentWif => _wifObject;

  void _onWeavingSectionChanged() {
    // Update the main WifObject with the changed section
    _wifObject = _wifObject.copyWith(weavingSection: weavingSectionNotifier.section);
    // Notify listeners of the WifNotifier itself.
    // This is important if some widgets only listen to the main WifNotifier
    // or if a change in one section affects overall app state logic.
    notifyListeners();
  }

  // void _onColorPaletteChanged() {
  //   _wifObject = _wifObject.copyWith(colorPalette: colorPaletteNotifier.palette);
  //   notifyListeners();
  // }

  // --- Potentially methods to load/save entire WIF object ---
  void loadNewWif(WifObject newWifObject) {
    _wifObject = newWifObject;
    // Update all sub-notifiers
    weavingSectionNotifier.updateSection(_wifObject.weavingSection);
    // colorPaletteNotifier.updatePalette(_wifObject.colorPalette ?? _defaultColorPalette());
    notifyListeners(); // Notify for the overall change
  }

  @override
  void dispose() {
    weavingSectionNotifier.removeListener(_onWeavingSectionChanged);
    weavingSectionNotifier.dispose();
    // Dispose other notifiers
    super.dispose();
  }
}
