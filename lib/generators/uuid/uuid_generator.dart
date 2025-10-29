import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum VersionVariant { v1, v4, v6, v7, v8, v8g }

String _formatUuid(String id, {bool uppercase = false, bool hyphens = true}) {
  String formattedId = id;

  if (!hyphens) {
    formattedId = formattedId.replaceAll('-', '');
  }

  if (uppercase) {
    formattedId = formattedId.toUpperCase();
  }

  return formattedId;
}

/// [version] Select UUID Generate Algorithm Version.
///
/// [uppercase] If This Value True Return String All Char be UpperCase.
///
/// [hyphens] If This Value False Remove All Hyphens on String.
///
/// [generateCount] How Much Generate UUID Key
List<String> uuidGenerator({
  VersionVariant version = VersionVariant.v4,
  bool uppercase = false,
  bool hyphens = true,
  int generateCount = 1,
}) {
  if (generateCount < 1 || generateCount > 128) {
    throw RangeError("Generate Count cant be less then 1 or more then 128");
  }

  List<String> retValue = [];
  for (var i = 0; i < generateCount; i++) {
    // 1. Ham ID'yi tutmak için bir değişken tanımla
    String rawId;

    // 2. Switch içinde 'rawId' değişkenine atama yap (retValue.add değil!)
    switch (version) {
      case VersionVariant.v1:
        rawId = uuid.v1();
        break;
      case VersionVariant.v4:
        rawId = uuid.v4();
        break;
      case VersionVariant.v6:
        rawId = uuid.v6();
        break;
      case VersionVariant.v7:
        rawId = uuid.v7();
        break;
      case VersionVariant.v8:
        rawId = uuid.v8();
        break;
      case VersionVariant.v8g:
        rawId = uuid.v8g();
        break;
    }

    // 3. Döngüde SADECE BİR KEZ, formatlanmış halini listeye ekle
    retValue.add(_formatUuid(rawId, uppercase: uppercase, hyphens: hyphens));
  }

  return retValue;
}
