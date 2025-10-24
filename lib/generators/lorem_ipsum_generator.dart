import 'dart:math';

import 'package:dev_utils/extensions/to_upper_first_letter.dart';

const List<String> _loremWords = [
  'lorem',
  'ipsum',
  'dolor',
  'sit',
  'amet',
  'consectetur',
  'adipiscing',
  'elit',
  'praesent',
  'interdum',
  'dictum',
  'mi',
  'non',
  'egestas',
  'pellentesque',
  'vel',
  'enim',
  'viverra',
  'turpis',
  'lacus',
  'sed',
  'consequat',
  'erat',
  'laoreet',
  'et',
  'leo',
  'curabitur',
  'in',
  'gravida',
  'libero',
  'ut',
  'cursus',
  'malesuada',
  'luctus',
  'dui',
  'fusce',
  'viverra',
  'mollis',
  'nulla',
  'semper',
  'blandit',
  'nunc',
  'mauris',
  'vestibulum',
  'ad',
  'ultricies',
  'porttitor',
  'iaculis',
  'nibh',
  'tincidunt',
  'tellus',
  'eu',
  'molestie',
  'orci',
  'phasellus',
  'ultrices',
  'lacinia',
  'arcu',
  'aliquam',
  'erat',
  'volutpat',
  'duis',
  'ac',
  'risus',
  'dignissim',
  'sapien',
  'quis',
  'lobortis',
  'justo',
  'nullam',
  'purus',
  'scelerisque',
  'eget',
  'varius',
  'facilisis',
  'suspendisse',
  'potenti',
  'aenean',
  'convallis',
  'magna',
  'quisque',
  'commodo',
  'accumsan',
  'nisl',
  'cras',
  'euismod',
  'augue',
  'sit',
  'amet',
  'sem',
  'nec',
  'sagittis',
  'diam',
  'fermentum',
  'etiam',
  'hendrerit',
  'tortor',
  'vitae',
  'posuere',
  'imperdiet',
  'massa',
  'urna',
  'faucibus',
  'orci',
  'nulla',
  'facilisi',
  'nam',
  'sodales',
  'velit',
  'non',
  'feugiat',
  'donec',
  'suscipit',
  'metus',
  'id',
  'ante',
  'morbi',
  'elementum',
  'quam',
  'finibus',
  'lectus',
  'maecenas',
  'tempor',
  'ex',
  'a',
  'ultrices',
  'bibendum',
  'odio',
  'ligula',
  'sollicitudin',
  'rutrum',
  'mollis',
  'ante',
  'integer',
  'eros',
  'neque',
  'vulputate',
  'placerat',
  'pulvinar',
  'at',
  'tristique',
  'felis',
  'proin',
  'non',
  'semper',
  'erat',
  'vivamus',
  'nisi',
  'aliquet',
  'maximus',
  'mattis',
  'pretium',
  'fringilla',
  'primis',
  'in',
  'faucibus',
  'orci',
  'luctus',
  'et',
  'ultrices',
  'posuere',
  'cubilia',
  'curae',
  'aenean',
  'efficitur',
  'porta',
  'quam',
];

const String _standardLoremParagraph =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Praesent interdum dictum mi non egestas. Pellentesque vel enim viverra, '
    'turpis lacus sed, consequat erat. Laoreet et leo. Curabitur in gravida libero, '
    'ut cursus malesuada. Luctus dui. Fusce viverra mollis nulla, semper blandit nunc. '
    'Mauris vestibulum, ad ultricies porttitor, iaculis nibh. Tincidunt tellus eu molestie orci. '
    'Phasellus ultrices lacinia arcu, aliquam erat volutpat.';

/// Lorem Ipsum paragraph or word generator.
///
/// [numParagraphs] Created Paragraph Count.
/// [minSentencesPerParagraph] Min Word Count Per Paragraph.
/// [maxSentencesPerParagraph] Max Word Count Per Paragraph.
/// [minWordsPerSentence] Min Word Count Per Sentence.
/// [maxWordsPerSentence] Max Word Count Per Sentence.
/// [startWithLorem] If True Start With Standart Lorem Paragraph
/// "Lorem ipsum dolor sit amet..." Standart Paragraph
String loremParagraphGenerator({
  int numParagraphs = 3,
  int minSentencesPerParagraph = 3,
  int maxSentencesPerParagraph = 7,
  int minWordsPerSentence = 5,
  int maxWordsPerSentence = 12,
  bool startWithLorem = true,
}) {
  final rng = Random();

  final paragraphs = <String>[];

  int generatedParagraphs = numParagraphs;

  if (startWithLorem && numParagraphs > 0) {
    paragraphs.add(_standardLoremParagraph);
    generatedParagraphs--;
  }

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
        words.add(_loremWords[rng.nextInt(_loremWords.length)]);
      }

      String sentence = words.join(' ');
      sentences.add('${sentence.toUpperFirstLetter()}.');
    }

    paragraphs.add(sentences.join(' '));
  }

  return paragraphs.join('\n\n');
}

String loremWordGenerator({int wordCount = 5, bool startWithLorem = false}) {
  final worldList = <String>[];
  final rng = Random();

  int generatedWord = wordCount;

  if (wordCount < 5 && startWithLorem) {
    throw ArgumentError(
      "Word Count Lower 5 Cant Start With Standart Lorem Words",
    );
  }

  if (wordCount > 5 && startWithLorem) {
    worldList.add("Lorem");
    worldList.add("ipsum");
    worldList.add("dolor");
    worldList.add("sit");
    worldList.add("amet.");
    generatedWord -= 5;
  }

  for (int i = 0; i < generatedWord; i++) {
    worldList.add(_loremWords[rng.nextInt(_loremWords.length)]);
  }

  return "${worldList.join(' ')}.";
}
