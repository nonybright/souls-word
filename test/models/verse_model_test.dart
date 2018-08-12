import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

   test('Verses Should be equal as long as contents are same', (){

      Verse verse = Verse(
        id: 8,
        content: 'jesus wept 8',
        isFaved: false,
        dateAdded: DateTime.now(),
        quotation: 'john 11:35',
        categoryId: 2,
        isDefault: false
      );

      Verse verse1 = verse.copyWith(isFaved: !verse.isFaved);
      Verse verse2 = verse.copyWith(isFaved: !verse.isFaved);

      expect(verse, Verse(
        id: 8,
        content: 'jesus wept 8',
        isFaved: false,
        dateAdded: DateTime.now(),
        quotation: 'john 11:35',
        categoryId: 2,
        isDefault: false
      ));
      expect(verse1.hashCode, verse2.hashCode);
      expect(verse1, verse2);

  });


  test('Should Create a verse from map', (){

        Map map = {"id":1, "content":'content',"quotation":'John 11:35', "isFaved": 1, "dateAdded": "2013-10-07 08:23:19", "categoryId":1, "isDefault": 1};
        Map map2 = {"id":1, "content":'content',"quotation":'John 11:35', "isFaved": 0, "dateAdded": "2013-10-07 08:23:19", "categoryId":1, "isDefault": 0};
        Verse verse = new Verse.fromMap(map);
        Verse verse2 = new Verse.fromMap(map2);

        expect(verse.id, 1);
        expect(verse.content, 'content');
        expect(verse.quotation, 'John 11:35');
        expect(verse.isFaved, true);
        expect(verse2.isFaved, false);
        expect(verse.categoryId, 1);
        expect(verse.isDefault, true);
        expect(verse2.isDefault, false);
        expect(verse.dateAdded, isInstanceOf<DateTime>());
        expect(verse.dateAdded.second,19);
  });


  test('Should convert verse to map', (){

      Verse verse = new Verse(id:1, content: 'content', quotation:'John 11:35', isFaved: false, categoryId: 1, isDefault: true , dateAdded: DateTime.parse('2013-10-07 08:23:19') );

      Map verseMap = verse.toMap();


      expect(verseMap['dateAdded'], '2013-10-07 08:23:19');
      expect(verseMap['id'], 1);
      expect(verseMap['content'], 'content');
      expect(verseMap['quotation'], 'John 11:35');
      expect(verseMap['categoryId'], 1);
      expect(verseMap['isDefault'], 1);
      expect(verseMap['isFaved'], 0);
  });


}