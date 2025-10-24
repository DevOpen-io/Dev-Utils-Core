import 'package:dev_utils/generators/lorem_ipsum_generator.dart';

void main(List<String> arguments) {
  try {
    print(loremParagraphGenerator(numParagraphs: 250, startWithLorem: false));
    print('------------------------------------------------------------------');
    print(loremWordGenerator(wordCount: 4, startWithLorem: true));
  } catch (e) {
    print(e);
  }
}
