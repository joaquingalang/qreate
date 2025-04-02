enum QrPattern {
  classic,
  rounded,
  thin,
  smooth,
  circles,
}

final Map<QrPattern, String> patternToString = {
  QrPattern.classic: 'classic',
  QrPattern.rounded: 'rounded',
  QrPattern.thin: 'thin',
  QrPattern.smooth: 'smooth',
  QrPattern.circles: 'circles',
};

final Map<String, QrPattern> stringToPattern = {
  'classic': QrPattern.classic,
  'rounded': QrPattern.rounded,
  'thin': QrPattern.thin,
  'smooth': QrPattern.smooth,
  'circles': QrPattern.circles,
};