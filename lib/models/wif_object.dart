class WifObject {
  final WeavingSection? weavingSection;

  WifObject({this.weavingSection});

  WifObject copyWith({WeavingSection? weavingSection}) {
    return WifObject(weavingSection: weavingSection ?? this.weavingSection);
  }
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
