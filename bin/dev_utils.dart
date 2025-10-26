import 'package:dev_utils/generators/lorem_ipsum_generator.dart';
import 'package:dev_utils/lorem_data/language_types.dart';

void main(List<String> arguments) {
  try {
    final result = loremParagraphGenerator(
      paragraphCount: 2,
      startWithStandart: true,
      languageType: LoremLanguageType.turkish,
    );
    print(result);
  } catch (e) {
    print(e);
  }
}
