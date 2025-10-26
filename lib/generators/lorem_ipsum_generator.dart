import 'dart:math';

import 'package:dev_utils/extensions/to_upper_first_letter.dart';
import 'package:dev_utils/lorem_data/language_types.dart';
import 'package:dev_utils/lorem_data/lorem_data.dart';

/// Generates a string of lorem ipsum paragraphs.
///
/// [paragraphCount] is the number of paragraphs to generate.
///
/// [minSentencesPerParagraph] is the minimum number of sentences per paragraph.
///
/// [maxSentencesPerParagraph] is the maximum number of sentences per paragraph.
///
/// [minWordsPerSentence] is the minimum number of words per sentence.
///
/// [maxWordsPerSentence] is the maximum number of words per sentence.
///
/// [startWithStandart] if true, the first paragraph will be the standard 'Lorem ipsum...' text.
///
/// [languageType] specifies the language of the generated text. Defaults to [LoremLanguageType.latin].
String loremParagraphGenerator({
  int paragraphCount = 3,
  int minSentencesPerParagraph = 3,
  int maxSentencesPerParagraph = 7,
  int minWordsPerSentence = 5,
  int maxWordsPerSentence = 12,
  bool startWithStandart = true,
  LoremLanguageType? languageType = LoremLanguageType.latin,
}) {
  final rng = Random();
  final paragraphs = <String>[];
  int generatedParagraphs = paragraphCount;

  String loremParagraph;
  List<String> loremWords;

  switch (languageType) {
    case LoremLanguageType.latin:
      loremParagraph = latinStandardParagraph;
      loremWords = latinLoremWords;
      break;
    case LoremLanguageType.turkish:
      loremParagraph = turkishStandardParagraph;
      loremWords = turkishLoremWords;
      break;
    case LoremLanguageType.german:
      loremParagraph = germanStandardParagraph;
      loremWords = germanLoremWords;
      break;
    case LoremLanguageType.spanish:
      loremParagraph = spanishStandardParagraph;
      loremWords = spanishLoremWords;
      break;
    case LoremLanguageType.russian:
      loremParagraph = russianStandardParagraph;
      loremWords = russianLoremWords;
      break;
    case null:
    // ignore: unreachable_switch_default
    default:
      loremParagraph = latinStandardParagraph;
      loremWords = latinLoremWords;
  }

  if (startWithStandart && paragraphCount > 0) {
    paragraphs.add(loremParagraph);
    generatedParagraphs--;
  }

  // Kalan paragrafları oluştur
  for (int i = 0; i < generatedParagraphs; i++) {
    final sentences = <String>[];
    final numSentences =
        minSentencesPerParagraph +
        rng.nextInt(maxSentencesPerParagraph - minSentencesPerParagraph + 1);

    for (int j = 0; j < numSentences; j++) {
      final words = <String>[];
      final numWords =
          minWordsPerSentence +
          rng.nextInt(maxWordsPerSentence - minWordsPerSentence + 1);

      for (int x = 0; x < numWords; x++) {
        words.add(loremWords[rng.nextInt(loremWords.length)]);
      }

      String sentence = words.join(' ');
      sentences.add('${sentence.toUpperFirstLetter()}.');
    }

    paragraphs.add(sentences.join(' '));
  }

  return paragraphs.join('\n\n');
}

/// Generates a string of lorem ipsum words.
///
/// [wordCount] is the number of words to generate.
///
/// [startWithStandart] if true, the text will start with the standard 'Lorem ipsum dolor sit amet...'.
/// Throws an [ArgumentError] if [wordCount] is less than the number of standard starting words for the selected language.
///
/// [languageType] specifies the language of the generated text. Defaults to [LoremLanguageType.latin].
String loremWordGenerator({
  int wordCount = 5,
  bool startWithStandart = false,
  LoremLanguageType? languageType = LoremLanguageType.latin,
}) {
  final worldList = <String>[];
  final rng = Random();

  int generatedWord = wordCount;

  List<String> loremWords;
  List<String> standartStartWords;

  // Dil verilerini ata
  switch (languageType) {
    case LoremLanguageType.latin:
      loremWords = latinLoremWords;
      standartStartWords = latinStandardWords;
      break;
    case LoremLanguageType.turkish:
      loremWords = turkishLoremWords;
      standartStartWords = turkishStandardWords;
      break;
    case LoremLanguageType.german:
      loremWords = germanLoremWords;
      standartStartWords = germanStandardWords;
      break;
    case LoremLanguageType.spanish:
      loremWords = spanishLoremWords;
      standartStartWords = spanishStandardWords;
      break;
    case LoremLanguageType.russian:
      loremWords = russianLoremWords;
      standartStartWords = russianStandardWords;
      break;
    case null:
    // ignore: unreachable_switch_default
    default:
      loremWords = latinLoremWords;
      standartStartWords = latinStandardWords;
  }

  final standardWordCount = standartStartWords.length;

  if (startWithStandart) {
    // 1. Hata Kontrolü (Aynı kalıyor)
    if (wordCount < standardWordCount) {
      throw ArgumentError(
        "Word Count ($wordCount) is lower than standard start words count ($standardWordCount) for $languageType",
      );
    }

    if (wordCount >= standardWordCount) {
      worldList.addAll(standartStartWords);
      generatedWord -= standardWordCount;
    }
  }

  for (int i = 0; i < generatedWord; i++) {
    worldList.add(loremWords[rng.nextInt(loremWords.length)]);
  }

  return "${worldList.join(' ')}.";
}
