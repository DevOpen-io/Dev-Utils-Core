import 'package:dev_utils/password_generator.dart';

void main(List<String> arguments) {
  try {
    print(passwordGenerator(length: 128, generateCount: 2));
  } catch (e) {
    print(e);
  }
}
