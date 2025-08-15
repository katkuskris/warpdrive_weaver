class WifObject {
  final WeavingSection? weavingSection;
  final WarpSection? warpSection;
  final WeftSection? weftSection;

  WifObject({this.weavingSection, this.warpSection, this.weftSection});

  WifObject copyWith({WeavingSection? weavingSection, WarpSection? warpSection, WeftSection? weftSection}) {
    return WifObject(weavingSection: weavingSection ?? this.weavingSection, warpSection: warpSection ?? this.warpSection, weftSection: weftSection ?? this.weftSection);
  }
}

enum WarpUnit {
  decipoints,
  inches,
  centimeters,
}

enum WeftUnit {
  decipoints,
  inches,
  centimeters,
}

abstract class WifObjectSection<T> {
  T copyWith();
}

class WeavingSection implements WifObjectSection<WeavingSection> {
  final int shafts;
  final int treadles;
  final bool? risingShed;
  final bool? profile;

  WeavingSection({
    required this.shafts,
    required this.treadles,
    this.risingShed,
    this.profile,
  });

  @override
  WeavingSection copyWith({
    int? shafts,
    int? treadles,
    bool? risingShed,
    bool? profile,
  }) {
    return WeavingSection(
      shafts: shafts ?? this.shafts,
      treadles: treadles ?? this.treadles,
      risingShed: risingShed ?? this.risingShed,
      profile: profile ?? this.profile,
    );
  }
}

class WarpSection implements WifObjectSection<WarpSection> {
  final int threads; // Assuming this is required
  final int? color;
  final int? symbol;
  final int? symbolNumber;
  final WarpUnit? units;
  final double? spacing;
  final double? thickness;
  final int? spacingZoom;
  final int? thicknessZoom;

  // Constructor for WarpSection
  WarpSection({
    required this.threads,
    this.color,
    this.symbol,
    this.symbolNumber,
    this.units,
    this.spacing,
    this.thickness,
    this.spacingZoom,
    this.thicknessZoom,
  });

  @override
  WarpSection copyWith({
    // Parameters should be comma-separated and have types
    int? threads,
    int? color,
    int? symbol,
    int? symbolNumber,
    WarpUnit? units,
    double? spacing,
    double? thickness,
    int? spacingZoom,
    int? thicknessZoom,
  }) {
    // Return a new WarpSection instance
    return WarpSection(
      threads: threads ?? this.threads,
      color: color ?? this.color,
      symbol: symbol ?? this.symbol,
      symbolNumber: symbolNumber ?? this.symbolNumber,
      units: units ?? this.units,
      spacing: spacing ?? this.spacing,
      thickness: thickness ?? this.thickness,
      spacingZoom: spacingZoom ?? this.spacingZoom,
      thicknessZoom: thicknessZoom ?? this.thicknessZoom,
    );
  }
}

class WeftSection implements WifObjectSection<WeftSection> {
  final int threads;
  final int? color;
  final int? symbol;
  final int? symbolNumber;
  final WeftUnit? units;
  final double? spacing;
  final double? thickness;
  final int? spacingZoom;
  final int? thicknessZoom;

  // Constructor for WeftSection
  WeftSection({
    required this.threads,
    this.color,
    this.symbol,
    this.symbolNumber,
    this.units,
    this.spacing,
    this.thickness,
    this.spacingZoom,
    this.thicknessZoom,
  });

  @override
  WeftSection copyWith({
    int? threads,
    int? color,
    int? symbol,
    int? symbolNumber,
    WeftUnit? units,
    double? spacing,
    double? thickness,
    int? spacingZoom,
    int? thicknessZoom,
  }) {
    // Return a new WarpSection instance
    return WeftSection(
      threads: threads ?? this.threads,
      color: color ?? this.color,
      symbol: symbol ?? this.symbol,
      symbolNumber: symbolNumber ?? this.symbolNumber,
      units: units ?? this.units,
      spacing: spacing ?? this.spacing,
      thickness: thickness ?? this.thickness,
      spacingZoom: spacingZoom ?? this.spacingZoom,
      thicknessZoom: thicknessZoom ?? this.thicknessZoom,
    );
  }
}
