class BanalityDetector {
  static const _banalIndicators = [
    'it depends',
    'on the other hand',
    'both sides have a point',
    'there is no easy answer',
    'it is a matter of perspective',
    'nuance is important',
  ];

  bool isBanal(String statement) {
    final lower = statement.toLowerCase();
    var matchCount = 0;
    for (final indicator in _banalIndicators) {
      if (lower.contains(indicator)) {
        matchCount++;
      }
    }
    return matchCount >= 2;
  }
}
