import 'package:dev_utils/generators/qr/qr_code_generator.dart';

void main(List<String> arguments) {
  try {
    print(qrCodeGenerator(qrData: "Hello, World!" , saveAsFile: true));
  } catch (e) {
    print(e);
  }
}
