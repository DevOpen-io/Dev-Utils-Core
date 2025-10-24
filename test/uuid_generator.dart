import 'package:dev_utils/uuid_generator.dart';
import 'package:test/test.dart';

// Test edilecek fonksiyonları ve enum'u içe aktar
// Dosya yolunu kendi projenize göre güncelleyin

void main() {
  // Testlerde tekrar tekrar kullanmak için regex kalıpları
  final regUuidWithHyphens = RegExp(
    r'^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$',
  );
  final regUuidNoHyphens = RegExp(r'^[a-f0-9]{32}$');
  final regUuidUpperHyphens = RegExp(
    r'^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$',
  );
  final regUuidUpperNoHyphens = RegExp(r'^[A-F0-9]{32}$');

  group('uuidGenerator - Temel Kullanım ve Adet', () {
    test('Varsayılan ayarlarla (v4, 1 adet, küçük harf, tireli) çalışmalı', () {
      final result = uuidGenerator();

      expect(result, isA<List<String>>());
      // Düzeltilmiş kodla listenin 1 elemanı olmalı
      expect(result.length, 1);
      expect(regUuidWithHyphens.hasMatch(result[0]), isTrue);
      expect(result[0], result[0].toLowerCase());
    });

    test('generateCount: 3 istendiğinde 3 adet üretmeli (v4)', () {
      final result = uuidGenerator(generateCount: 3);
      expect(result.length, 3);
      // v4 oldukları için benzersiz olmalılar
      expect(result[0], isNot(equals(result[1])));
      expect(result[1], isNot(equals(result[2])));
    });
  });

  group('uuidGenerator - Formatlama Seçenekleri', () {
    test('uppercase: true istendiğinde büyük harf üretmeli', () {
      final id = uuidGenerator(uppercase: true)[0];
      expect(regUuidUpperHyphens.hasMatch(id), isTrue);
      expect(id, id.toUpperCase());
    });

    test('hyphens: false istendiğinde tiresiz üretmeli', () {
      final id = uuidGenerator(hyphens: false)[0];
      expect(id.contains('-'), isFalse);
      expect(id.length, 32);
      expect(regUuidNoHyphens.hasMatch(id), isTrue);
    });

    test(
      'uppercase: true VE hyphens: false istendiğinde tiresiz ve büyük harf üretmeli',
      () {
        final id = uuidGenerator(uppercase: true, hyphens: false)[0];
        expect(id.contains('-'), isFalse);
        expect(id.length, 32);
        expect(regUuidUpperNoHyphens.hasMatch(id), isTrue);
        expect(id, id.toUpperCase());
      },
    );
  });

  group('uuidGenerator - Versiyon Varyantları', () {
    test('v1 geçerli formatta üretilmeli', () {
      final id = uuidGenerator(version: VersionVariant.v1)[0];
      expect(regUuidWithHyphens.hasMatch(id), isTrue);
    });

    test('v6 geçerli formatta üretilmeli', () {
      final id = uuidGenerator(version: VersionVariant.v6)[0];
      expect(regUuidWithHyphens.hasMatch(id), isTrue);
    });

    test('v7 geçerli formatta üretilmeli', () {
      final id = uuidGenerator(version: VersionVariant.v7)[0];
      expect(regUuidWithHyphens.hasMatch(id), isTrue);
    });
    // Diğer v8, v8g testleri de buraya eklenebilir...
  });

  // --- HATA YÖNETİMİ GÜNCELLENDİ ---
  // Artık 'uuidGenerator' içindeki 'generateCount' kontrolünü test ediyoruz
  group('uuidGenerator - Hata Yönetimi', () {
    test('generateCount 1\'den küçükse RangeError fırlatmalı', () {
      expect(() => uuidGenerator(generateCount: 0), throwsA(isA<RangeError>()));
      expect(
        () => uuidGenerator(generateCount: -1),
        throwsA(isA<RangeError>()),
      );
    });

    test('generateCount 128\'den büyükse RangeError fırlatmalı', () {
      expect(
        () => uuidGenerator(generateCount: 129),
        throwsA(isA<RangeError>()),
      );
    });

    // v5 için olan ArgumentError testleri kaldırıldı, çünkü 'generateUuidV5'
    // 'required' anahtar kelimesini kullanıyor, bu da hatayı çalışma zamanı
    // (runtime) yerine derleme zamanı (compile-time) hatasına dönüştürüyor.
  });
}
