extension StringCapitalize on String {
  String toUpperFirstLetter() {
    return this[0].toUpperCase() + substring(1);
  }
}
