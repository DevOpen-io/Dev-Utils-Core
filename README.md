A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.


# Completed Tools

## Code Examples
The `import 'package:dev_utils/dev_utils.dart';` header is used to import all the available utility functions from the `dev_utils` library.
The `void main() {}` function is the entry point for the Dart application. The code inside this function will be executed when the application starts.

## Lorem Ipsum Generator

### Paragraph Generator
This function generates a random paragraph of text.
- `paragraphCount`: The number of paragraphs to generate.
- `minSentencesPerParagraph`: The minimum number of sentences per paragraph.
- `maxSentencesPerParagraph`: The maximum number of sentences per paragraph.
- `minWordsPerSentence`: The minimum number of words per sentence.
- `maxWordsPerSentence`: The maximum number of words per sentence.
- `startWithStandart`: If true, the text will start with "Lorem ipsum dolor sit amet...".
- `languageType`: The language of the generated text.
```dart
import 'package:dev_utils/dev_utils.dart';

void main() {
  String lorem = loremParagraphGenerator(
    paragraphCount: 3,
    minSentencesPerParagraph: 3,
    maxSentencesPerParagraph: 7,
    minWordsPerSentence: 5,
    maxWordsPerSentence: 12,
    startWithStandart: true,
    languageType: LoremLanguageType.latin,
  );
  print(lorem);
}
```

### Word Generator
This function generates a random list of words.
- `wordCount`: The number of words to generate.
- `startWithStandart`: If true, the text will start with "Lorem ipsum dolor sit amet...".
- `languageType`: The language of the generated text.
```dart
import 'package:dev_utils/dev_utils.dart';

void main() {
  String lorem = loremWordGenerator(
    wordCount: 5,
    startWithStandart: false,
    languageType: LoremLanguageType.latin,
  );
  print(lorem);
}
```

## Password Generator
This function generates a list of random passwords.
- `includeLowerCase`: If true, the password will include lowercase letters.
- `includeUpperCase`: If true, the password will include uppercase letters.
- `includeNumerics`: If true, the password will include numbers.
- `includeSymbols`: If true, the password will include symbols.
- `length`: The length of the password.
- `generateCount`: The number of passwords to generate.
```dart
import 'package:dev_utils/dev_utils.dart';

void main() {
  List<String> passwords = passwordGenerator(
    includeLowerCase: true,
    includeUpperCase: true,
    includeNumerics: true,
    includeSymbols: true,
    length: 12,
    generateCount: 5,
  );
  print(passwords);
}
```

## UUID Generator
This function generates a list of random UUIDs.
- `version`: The version of the UUID to generate.
- `uppercase`: If true, the UUID will be in uppercase.
- `hyphens`: If true, the UUID will include hyphens.
- `generateCount`: The number of UUIDs to generate.
```dart
import 'package:dev_utils/dev_utils.dart';

void main() {
  List<String> uuids = uuidGenerator(
    version: VersionVariant.v4,
    uppercase: false,
    hyphens: true,
    generateCount: 5,
  );
  print(uuids);
}
```

## QR Code Generator
This function generates a QR code.
- `qrData`: The data to be encoded in the QR code.
- `saveAsFile`: If true, the QR code will be saved as a file.
- `filename`: The name of the file to save the QR code to.
```dart
import 'package:dev_utils/dev_utils.dart';

void main() {
  qrCodeGenerator(
    qrData: "https://github.com/dev-utils-core",
    saveAsFile: true,
    filename: "qr_code.png",
  );
}
```