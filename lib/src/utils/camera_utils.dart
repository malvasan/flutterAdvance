DateTime convertStringToDateTime(String date) {
  date = date.replaceFirst(' ', 'T');
  date = date.replaceAll(':', '');
  return DateTime.parse(date).toLocal();
}

String normalizeOrientation(String orientation) {
  final orientationHorizontal = ['Horizontal(normal)', 'Rotated 180'];
  final orientationVertical = ['Rotated 90 CCW', 'Rotated 90 CW'];
  if (orientationHorizontal.contains(orientation)) {
    return 'Horizontal';
  } else if (orientationVertical.contains(orientation)) {
    return 'Vertical';
  } else {
    return '';
  }
}
