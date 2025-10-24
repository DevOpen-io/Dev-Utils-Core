import 'dart:math';

/// [includeLowerCase] password include lowercase characther
///
/// [includeUpperCase] password include uppercase characther
///
/// [includeNumerics] password include numeric characther
///
/// [includeSymbols] password include Symbols characther
///
/// [length] length for per password
///
/// [generateCount] how much password u want
List<String> passwordGenerator({
  bool includeLowerCase = true,
  bool includeUpperCase = true,
  bool includeNumerics = true,
  bool includeSymbols = true,
  int length = 5,
  int generateCount = 1,
}) {
  if (!includeLowerCase &&
      !includeUpperCase &&
      !includeNumerics &&
      !includeSymbols) {
    throw ArgumentError("All Options Are Disabled Password Cant Generate!!!");
  }

  if (length < 5 || length > 128) {
    throw RangeError(
      "Password cant be less then 5 or more then 128 characters",
    );
  }

  if (generateCount < 1 || generateCount > 128) {
    throw RangeError("Generate Count cant be less then 1 or more then 128");
  }

  String finalCase = "";
  List<String> retValue = [];
  var rng = Random.secure();
  const String lowerCaseLetter = "abcdefghijklmnopqrstuvwxyz";
  const String upperCaseLetter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const String numerics = "0123456789";
  const String symbols = "[]{},./'`~!@#%^&*()_-+";

  if (includeLowerCase) finalCase += lowerCaseLetter;

  if (includeUpperCase) finalCase += upperCaseLetter;

  if (includeNumerics) finalCase += numerics;

  if (includeSymbols) finalCase += symbols;

  for (var i = 0; i < generateCount; i++) {
    List<String> passwordChars = [];

    if (includeLowerCase) {
      passwordChars.add(lowerCaseLetter[rng.nextInt(lowerCaseLetter.length)]);
    }
    if (includeUpperCase) {
      passwordChars.add(upperCaseLetter[rng.nextInt(upperCaseLetter.length)]);
    }
    if (includeNumerics) {
      passwordChars.add(numerics[rng.nextInt(numerics.length)]);
    }
    if (includeSymbols) {
      passwordChars.add(symbols[rng.nextInt(symbols.length)]);
    }

    int remainingLength = length - passwordChars.length;

    for (var j = 0; j < remainingLength; j++) {
      passwordChars.add(finalCase[rng.nextInt(finalCase.length)]);
    }

    passwordChars.shuffle(rng);

    retValue.add(passwordChars.join(''));
  }
  return retValue;
}
