import 'package:flutter_emergency_app_one/utils/verse_picker_converter.dart';
import 'package:flutter_emergency_app_one/widgets/verse_picker.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('All picker and verse rest', () {
    test('String should be converted to corresponding picker options', () {
      expect(verseStringToPicker('John 3:16'),
          VersePickerOptions('John', 3, 16, 0));
      expect(verseStringToPicker('John 4:17-19'),
          VersePickerOptions('John', 4, 17, 19));
      expect(verseStringToPicker('1       John 4:7-8'),
          VersePickerOptions('1 John', 4, 7, 8));
    });

    test('Picker should be converted to corresponding string', () {
      expect(pickerToVerseString(VersePickerOptions('John', 3, 16, 0)),
          'John 3:16');
      expect(
          pickerToVerseString(VersePickerOptions('John', 3, 16)), 'John 3:16');
      expect(pickerToVerseString(VersePickerOptions('John', 4, 17, 19)),
          'John 4:17-19');
    });
  });
}
