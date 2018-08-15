import 'package:flutter_emergency_app_one/utils/verse_parser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;


class MockHttpClient extends Mock implements http.Client{}

main(){

  MockHttpClient httpClient;
setUp((){

    httpClient =  MockHttpClient();

});
  test('Parse the verse from the API', () async {

    //Romans12:1-2 could not parse cuz it contained invalid ascii characters .. check more on that later.

       String john316 = 'For God so loved the world, that he gave his one and only Son, that whoever believes in him should not perish, but have eternal life.';

       List<String> roman12 = [
        'so we, who are many, are one body in Christ, and individually members one of another.',
        'Having gifts differing according to the grace that was given to us, if prophecy, let us prophesy according to the proportion of our faith;'
       ];

       when(httpClient.get(VerseParser.apiUrl + 'john 3:16')).thenAnswer((_) => Future.value(new http.Response(johnThreeSixteen, 200)));
       when(httpClient.get(VerseParser.apiUrl + 'romans 12:5-6')).thenAnswer((_) => Future.value(new http.Response(romansTwelveFiveToSix, 200) ));
      

       VerseParser parser = VerseParser(httpClient);
       List<String> verses = await parser.parse('john 3:16');
       expect(verses.length, 1);
       expect(verses[0], john316);


       List<String> romanVerses = await parser.parse('romans 12:5-6');
       expect(romanVerses.length == 2, true);
       expect(romanVerses[0], roman12[0]);
       expect(romanVerses[1], roman12[1]);



  });



 


}


  // List<String> parseVerse(String verse){

  //     Map decoded = json.decode(verse);
  //     List<Map> verses = decoded['verses'];
  //     verses[0]['text'];
  //      print(decoded);

  // }

   String johnThreeSixteen = '''{"reference":"John 3:16","verses":[{"book_id":"JHN","book_name":"John","chapter":3,"verse":16,"text":"\nFor God so loved the world, that he gave his one and only Son, that whoever believes in him should not perish, but have eternal life.\n\n"}],"text":"\nFor God so loved the world, that he gave his one and only Son, that whoever believes in him should not perish, but have eternal life.\n\n","translation_id":"web","translation_name":"World English Bible","translation_note":"Public Domain"}''';




  String romansTwelveFiveToSix = '''{"reference":"Romans 12:5-6","verses":[{"book_id":"ROM","book_name":"Romans","chapter":12,"verse":5,"text":"so we, who are many, are one body in Christ, and individually members one of another.\n"},{"book_id":"ROM","book_name":"Romans","chapter":12,"verse":6,"text":"Having gifts differing according to the grace that was given to us, if prophecy, let us prophesy according to the proportion of our faith;\n"}],"text":"so we, who are many, are one body in Christ, and individually members one of another.\nHaving gifts differing according to the grace that was given to us, if prophecy, let us prophesy according to the proportion of our faith;\n","translation_id":"web","translation_name":"World English Bible","translation_note":"Public Domain"}''';