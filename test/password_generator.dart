// Dart'ın standart test paketini içe aktar
import 'package:test/test.dart';

// Test edilecek fonksiyonunuzu içe aktar
// Bu dosyanın 'lib/password_generator.dart' içinde olduğunu varsayıyorum
import 'package:dev_utils/generators/password/password_generator.dart';

void main() {
  // Testleri gruplayarak daha okunabilir hale getirelim
  group('Password Generator - Başarılı Durumlar', () {
    test('Varsayılan ayarlarla (5 uzunluk, 1 adet) şifre oluşturmalı', () {
      final passwords = passwordGenerator();

      // Dönen listenin türünü kontrol et
      expect(passwords, isA<List<String>>());
      // Listenin 1 elemanı olmalı
      expect(passwords.length, 1);
      // Şifrenin uzunluğu 5 olmalı
      expect(passwords[0].length, 5);
    });

    test('Belirtilen adet (3) ve uzunlukta (10) şifre oluşturmalı', () {
      final passwords = passwordGenerator(length: 10, generateCount: 3);

      // Listenin 3 elemanı olmalı
      expect(passwords.length, 3);

      // Her bir şifrenin uzunluğunu kontrol et
      expect(passwords[0].length, 10);
      expect(passwords[1].length, 10);
      expect(passwords[2].length, 10);
    });

    test('Minimum geçerli sınırlar (uzunluk 5, adet 1) ile çalışmalı', () {
      final passwords = passwordGenerator(length: 5, generateCount: 1);
      expect(passwords.length, 1);
      expect(passwords[0].length, 5);
    });

    test('Maksimum geçerli sınırlar (uzunluk 128, adet 128) ile çalışmalı', () {
      final passwords = passwordGenerator(length: 128, generateCount: 128);
      expect(passwords.length, 128);
      expect(passwords[0].length, 128);
      expect(passwords.last.length, 128);
    });
  });

  group('Password Generator - Karakter Seti Kontrolleri', () {
    // Sadece izin verilen karakterlerin kullanıldığını doğrulamak için
    // bir yardımcı fonksiyon veya regex kullanışlıdır.

    test('Sadece küçük harfler içermeli', () {
      final password = passwordGenerator(
        includeUpperCase: false,
        includeNumerics: false,
        includeSymbols: false,
        length:
            50, // Uzunluk artırarak tüm karakterlerin test edilme şansını artır
      )[0];

      // Sadece küçük harfleri içeren bir regex
      final RegExp onlyLowerCase = RegExp(r'^[a-z]+$');
      expect(onlyLowerCase.hasMatch(password), isTrue);
    });

    test('Sadece büyük harfler içermeli', () {
      final password = passwordGenerator(
        includeLowerCase: false,
        includeNumerics: false,
        includeSymbols: false,
        length: 50,
      )[0];

      // Sadece büyük harfleri içeren bir regex
      final RegExp onlyUpperCase = RegExp(r'^[A-Z]+$');
      expect(onlyUpperCase.hasMatch(password), isTrue);
    });

    test('Sadece sayılar içermeli', () {
      final password = passwordGenerator(
        includeLowerCase: false,
        includeUpperCase: false,
        includeSymbols: false,
        length: 50,
      )[0];

      // Sadece sayıları içeren bir regex
      final RegExp onlyNumerics = RegExp(r'^[0-9]+$');
      expect(onlyNumerics.hasMatch(password), isTrue);
    });

    test('Sadece semboller içermeli', () {
      final password = passwordGenerator(
        includeLowerCase: false,
        includeUpperCase: false,
        includeNumerics: false,
        length: 50,
      )[0];

      // Fonksiyondaki semboller: []{},./'`~!@#%^&*()_-+
      // Regex'te özel karakterleri escape (\) etmemiz gerekir
      final RegExp onlySymbols = RegExp(
        r"^[\[\]\{\}\,\.\/''`\~\!\@\#\%\^\&\*\(\)\_\-\+]+$",
      );
      expect(onlySymbols.hasMatch(password), isTrue);
    });

    test('Sadece küçük harf ve sayılar içermeli', () {
      final password = passwordGenerator(
        includeUpperCase: false,
        includeSymbols: false,
        length: 50,
      )[0];

      // Sadece küçük harf ve sayı içeren bir regex
      final RegExp lowerAndNums = RegExp(r'^[a-z0-9]+$');
      expect(lowerAndNums.hasMatch(password), isTrue);

      // Her ikisinden de içerdiğini (daha gelişmiş) test edebiliriz
      expect(password.contains(RegExp(r'[a-z]')), isTrue);
      expect(password.contains(RegExp(r'[0-9]')), isTrue);
    });
  });

  group('Password Generator - Hata Durumları (Geçersiz Argümanlar)', () {
    test('Tüm karakter setleri false ise ArgumentError fırlatmalı', () {
      // Hata fırlatan fonksiyonları test etmek için 'expect'i bu şekilde kullanırız:
      // expect( () => fonksiyonCagrisi(), throwsA(isA<HataTipi>()) );

      expect(
        () => passwordGenerator(
          includeLowerCase: false,
          includeUpperCase: false,
          includeNumerics: false,
          includeSymbols: false,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Uzunluk 5\'ten küçükse RangeError fırlatmalı', () {
      expect(() => passwordGenerator(length: 4), throwsA(isA<RangeError>()));
      expect(() => passwordGenerator(length: 0), throwsA(isA<RangeError>()));
    });

    test('Uzunluk 128\'den büyükse RangeError fırlatmalı', () {
      expect(() => passwordGenerator(length: 129), throwsA(isA<RangeError>()));
    });

    test('Oluşturma sayısı 1\'den küçükse RangeError fırlatmalı', () {
      expect(
        () => passwordGenerator(generateCount: 0),
        throwsA(isA<RangeError>()),
      );
      expect(
        () => passwordGenerator(generateCount: -1),
        throwsA(isA<RangeError>()),
      );
    });

    test('Oluşturma sayısı 128\'den büyükse RangeError fırlatmalı', () {
      expect(
        () => passwordGenerator(generateCount: 129),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
