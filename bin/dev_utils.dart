import 'package:dev_utils/password_generator.dart';

void main(List<String> arguments) {
  try {
    print(passwordGenerator(length: 5, generateCount: 5));
  } catch (e) {
    print(e);
  }
}
