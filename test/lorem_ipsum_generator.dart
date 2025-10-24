// Dart'ın test paketini içe aktar
import 'package:dev_utils/generators/lorem_ipsum_generator.dart';
import 'package:test/test.dart';

// Test edilecek fonksiyonları içeren dosyanızı içe aktarın
// (Dosya yolunu kendi projenize göre düzenleyin)

void main() {
  group('loremParagraphGenerator', () {
    test(
      'Varsayılan parametreler 3 paragraf döndürmeli ve ilki standart paragraf olmalı',
      () {
        final result = loremParagraphGenerator();
        final paragraphs = result.split('\n\n');

        // 1. Paragraf sayısını kontrol et
        expect(paragraphs.length, 3);

        // 2. İlk paragrafın standart 'Lorem ipsum...' metni olduğunu kontrol et
        // (Bunun için kodunuzdaki _standardLoremParagraph sabitini testte de tanımlamamız gerekir)
        const String standardParagraph =
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Praesent interdum dictum mi non egestas. Pellentesque vel enim viverra, '
            'turpis lacus sed, consequat erat. Laoreet et leo. Curabitur in gravida libero, '
            'ut cursus malesuada. Luctus dui. Fusce viverra mollis nulla, semper blandit nunc. '
            'Mauris vestibulum, ad ultricies porttitor, iaculis nibh. Tincidunt tellus eu molestie orci. '
            'Phasellus ultrices lacinia arcu, aliquam erat volutpat.';

        expect(paragraphs[0], standardParagraph);
      },
    );

    test(
      'startWithLorem: false ayarlandığında, standart paragrafı içermemeli',
      () {
        final result = loremParagraphGenerator(
          startWithLorem: false,
          numParagraphs: 1,
        );
        final paragraphs = result.split('\n\n');

        // 1. Paragraf sayısı 1 olmalı
        expect(paragraphs.length, 1);

        // 2. İlk paragraf standart metin OLMAMALI
        // (Testin başarısız olmaması için standart metinden farklı bir şey bekliyoruz)
        expect(result.startsWith('Lorem ipsum dolor sit amet'), isFalse);
      },
    );

    test('numParagraphs: 0 ayarlandığında boş string döndürmeli', () {
      final result = loremParagraphGenerator(numParagraphs: 0);
      expect(result, '');
    });

    test(
      'startWithLorem: true ve numParagraphs: 5, toplam 5 paragraf döndürmeli',
      () {
        final result = loremParagraphGenerator(
          numParagraphs: 5,
          startWithLorem: true,
        );
        final paragraphs = result.split('\n\n');
        expect(paragraphs.length, 5);
      },
    );

    test(
      'Cümleler büyük harf ile başlamalı (toUpperFirstLetter test ediliyor)',
      () {
        final result = loremParagraphGenerator(
          startWithLorem: false, // Rastgele paragrafı test etmek için
          numParagraphs: 1,
        );

        // 'toUpperFirstLetter()' eklentinizin çalıştığını varsayarak
        // cümlenin ilk harfinin büyük olduğunu kontrol ediyoruz.
        final firstLetter = result[0];
        expect(firstLetter, firstLetter.toUpperCase());

        // Diğer cümleleri de kontrol edelim (noktadan sonraki boşluk)
        if (result.contains('. ')) {
          final sentences = result.split('. ');
          // Son cümle hariç (sonunda nokta olabilir)
          for (var i = 0; i < sentences.length - 1; i++) {
            final sentenceFirstLetter = sentences[i][0];
            expect(sentenceFirstLetter, sentenceFirstLetter.toUpperCase());
          }
        }
      },
    );

    test('Cümle sayısı belirtilen aralıkta olmalı', () {
      final result = loremParagraphGenerator(
        startWithLorem: false,
        numParagraphs: 1,
        minSentencesPerParagraph: 2, // Min ve Max aynı
        maxSentencesPerParagraph: 2, //
      );

      // Cümleleri nokta sayısına göre saymak daha güvenilirdir.
      final sentenceCount = '.'.allMatches(result).length;
      expect(sentenceCount, 2);
    });
  });

  group('loremWordGenerator', () {
    test(
      'Varsayılan parametreler (5 kelime) 5 kelime ve bir nokta döndürmeli',
      () {
        final result = loremWordGenerator();

        // Sonundaki noktayı kaldırıp kelimeleri sayalım
        final words = result.substring(0, result.length - 1).split(' ');

        expect(words.length, 5);
        expect(result.endsWith('.'), isTrue);
      },
    );

    test(
      'startWithLorem: true ve wordCount: 10, ilk 5 standart kelime + 5 rastgele kelime döndürmeli',
      () {
        final result = loremWordGenerator(wordCount: 10, startWithLorem: true);

        // 1. Doğru metinle başladığını kontrol et (kodunuzdaki "amet." dahil)
        expect(result.startsWith('Lorem ipsum dolor sit amet.'), isTrue);

        // 2. Toplam kelime sayısını kontrol et
        // Kodunuzdaki mantık: "Lorem ipsum dolor sit amet. word6 word7 word8 word9 word10."
        // Bu, "amet." kelimesini bir kelime olarak sayar.
        final words = result.substring(0, result.length - 1).split(' ');
        expect(words.length, 10);

        // 3. Sonunun tek nokta ile bittiğini kontrol et
        expect(result.endsWith('.'), isTrue);
        expect(result.endsWith('..'), isFalse);
      },
    );

    test(
      'startWithLorem: true ve wordCount: 5, 5 RASTGELE kelime döndürmeli (kenar durum)',
      () {
        // Kodunuzdaki mantık (if wordCount > 5) nedeniyle,
        // wordCount == 5 ve startWithLorem == true ise, 5 rastgele kelime üretir.
        final result = loremWordGenerator(wordCount: 5, startWithLorem: true);
        final words = result.substring(0, result.length - 1).split(' ');

        expect(words.length, 5);
        // Standart kelimelerle başlamadığını varsayıyoruz (olasılık çok düşük)
        expect(result.startsWith('Lorem ipsum'), isFalse);
      },
    );

    test(
      'wordCount < 5 ve startWithLorem: true ise ArgumentError fırlatmalı',
      () {
        expect(
          () => loremWordGenerator(wordCount: 4, startWithLorem: true),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test('Her zaman bir nokta ile bitmeli', () {
      final result1 = loremWordGenerator();
      final result2 = loremWordGenerator(wordCount: 1, startWithLorem: false);
      final result3 = loremWordGenerator(wordCount: 10, startWithLorem: true);

      expect(result1.endsWith('.'), isTrue);
      expect(result2.endsWith('.'), isTrue);
      expect(result3.endsWith('.'), isTrue);
    });
  });
}
