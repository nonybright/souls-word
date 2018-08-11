import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){

  test('Can Create Preferences', () async{
    
    SharedPreferences.setMockInitialValues({});
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isWorking = false;
    String name = 'nony';
    pref.setBool('isWorking', isWorking);
    pref.setString('name', name);


    expect(pref.getBool('isWorking'), false);
    expect(pref.getString('name'), 'nony');
  });

  test('Can load Asset', () async {

       //String data = await rootBundle.loadString('C:/Users/nony/AndroidStudio2017/flutter_emergency_app_one/assets/texts/text.txt');
       //expect(data, 'TestText');
       //final file = new File('../../assets/texts/text.txt');
      final file = new File('C:/Users/nony/AndroidStudio2017/flutter_emergency_app_one/assets/texts/text.txt');
      String fileString = '';
      try{
              fileString = await file.readAsString();
      }catch(e){
        print('ddd');
      }
        print(fileString);
       expect(fileString, 'This is the test file content');

  });
}