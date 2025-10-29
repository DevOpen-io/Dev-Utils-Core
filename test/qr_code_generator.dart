// test/qr_generator_test.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:dev_utils/generators/qr/qr_code_generator.dart';
import 'package:test/test.dart';
import 'package:image/image.dart' as img; // PNG'yi doğrulamak için kullanılır

void main() {
  group('qrCodeGenerator Tests', () {
    // --- Başarı Testleri ---

    test('should return a non-null Uint8List for valid data', () {
      final result = qrCodeGenerator(qrData: "hello world");

      expect(result, isNotNull);
      expect(result, isA<Uint8List>());
    });

    test('should return valid PNG data that can be decoded', () {
      final result = qrCodeGenerator(qrData: "test");

      expect(result, isNotNull);

      // Döndürülen verinin 'image' paketi tarafından
      // geçerli bir PNG olarak okunabildiğini doğrula
      final image = img.decodePng(result!);

      expect(image, isNotNull);
      expect(image, isA<img.Image>());

      final separatorPixel = image!.getPixel(0, 7);

      // Bu pikselin 'img.fill' sayesinde beyaz olmasını bekliyoruz.
      expect(separatorPixel, equals(img.ColorRgb8(255, 255, 255)));
    });

    test('should save a file when saveAsFile is true', () {
      const testFilename = 'test_qr_output.png';
      final file = File(testFilename);

      // addTearDown, test bittikten sonra (başarılı da olsa başarısız da olsa)
      // bu bloğu çalıştırır, böylece test dosyaları temizlenir.
      addTearDown(() {
        if (file.existsSync()) {
          file.deleteSync();
        }
      });

      // Dosyanın testten önce var olmadığını kontrol et
      if (file.existsSync()) {
        file.deleteSync();
      }

      final result = qrCodeGenerator(
        qrData: "save file test",
        saveAsFile: true,
        filename: testFilename,
      );

      // 1. Fonksiyonun hala veriyi döndürdüğünü kontrol et
      expect(result, isNotNull);

      // 2. Dosyanın oluşturulduğunu kontrol et
      expect(file.existsSync(), isTrue);

      // 3. Dosyanın içeriğinin, döndürülen veriyle eşleştiğini kontrol et
      final fileData = file.readAsBytesSync();
      expect(result, equals(fileData));
    });

    // --- Hata ve Kenar Durum Testleri ---

    test('should return null if qrData is empty', () {
      final result = qrCodeGenerator(qrData: "");

      // Fonksiyon, boş veri için 'null' döndürmeli
      expect(result, isNull);
    });

    test('should return null if data is too large for QR code (Q level)', () {
      // QrErrorCorrectLevel.Q (varsayılan) için maksimum Alfanümerik karakter
      // sayısı 40. versiyonda bile 1852'dir. 3000 karakter göndermek
      // 'qr' paketinin 'DataTooLongException' fırlatmasına neden olmalıdır.
      final veryLongData = 'A' * 3000;

      final result = qrCodeGenerator(qrData: veryLongData);

      // Fonksiyonumuz bu hatayı yakalayıp 'null' döndürmeli
      expect(result, isNull);
    });

    test('should return null for an invalid errorCorrectLevel', () {
      // 'qr' paketi sadece 0, 1, 2, 3 (L, M, Q, H) seviyelerini kabul eder.
      // Geçersiz bir seviye (örn: 99) göndermek hataya neden olmalı.
      final result = qrCodeGenerator(
        qrData: "invalid level",
        errorCorrectLevel: 99, // Geçersiz seviye
      );

      // Fonksiyonumuz bu hatayı yakalayıp 'null' döndürmeli
      expect(result, isNull);
    });
  });
}
