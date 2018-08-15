import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class VerseParser{


  http.Client client;
  VerseParser( this.client);

  static String apiUrl = 'https://bible-api.com/';

  Future<List<String>> parse(verseString) async {

    String fullVerseLink = apiUrl+verseString;
    Response response = await client.get(fullVerseLink);

    String body = response.body;
    String newString = body.replaceAll("\n", '<br>');
    Map decodedVerse = json.decode(newString);
    String gottenVerseText = decodedVerse['text'];
    
    List<String> verseList = gottenVerseText.split('<br>');
    verseList.removeWhere((verse)=> verse.trim().isEmpty);

    return verseList;
  }

}