import 'dart:io';
import 'dart:typed_data';
import 'package:qr/qr.dart';
import 'package:image/image.dart' as img;

/// Generates a QR code and returns it as PNG data in a byte list.
///
/// [qrData] The text data to encode in the QR code.
/// [saveAsFile] If 'true', also saves the code to a file specified by [filename].
/// [filename] The filename to use if [saveAsFile] is true.
/// [errorCorrectLevel] The error correction level (L, M, Q, H).
///
/// Returns [Uint8List] PNG data on success,
/// or 'null' on failure (e.g., if [qrData] is empty).
Uint8List? qrCodeGenerator({
  String qrData = "",
  bool saveAsFile = false,
  String filename = 'qrcode.png',
  int errorCorrectLevel = QrErrorCorrectLevel.Q,
}) {
  
  // 1. Input Validation: Empty data cannot create a QR code.
  if (qrData.isEmpty) {
    print("Error: QR data (qrData) cannot be empty.");
    return null;
  }

  try {
    // 2. Create the QR code matrix
    final qrCode = QrCode.fromData(
      data: qrData,
      errorCorrectLevel: errorCorrectLevel,
    );

    final qrImage = QrImage(qrCode);

    // 3. Create an image canvas using the 'image' package
    final image = img.Image(
      width: qrImage.moduleCount,
      height: qrImage.moduleCount,
    );

    // 4. IMPORTANT FIX: Set the background to white
    // Without this, the PNG background will be transparent, and the QR code
    // will be invisible in many places (e.g., on a dark theme).
    img.fill(image, color: img.ColorRgb8(255, 255, 255));

    // 5. Draw the QR pixels (modules) onto the canvas
    for (int x = 0; x < qrImage.moduleCount; x++) {
      for (int y = 0; y < qrImage.moduleCount; y++) {
        if (qrImage.isDark(y, x)) {
          // Black module
          img.drawPixel(image, x, y, img.ColorRgb8(0, 0, 0));
        }
      }
    }

    // 6. Encode the image into PNG format (as List<int>)
    final pngData = img.encodePng(image);

    // 7. Optionally save to a file
    if (saveAsFile) {
      final file = File(filename);
      file.writeAsBytesSync(pngData);
      print("Success! '$filename' file created.");
    }

    // 8. Return the PNG data as Uint8List
    return Uint8List.fromList(pngData);

  } catch (e) {
    print("Error occurred while generating QR code: $e");
    // 9. Return null on error
    return null;
  }
}