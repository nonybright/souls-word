import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_emergency_app_one/utils/date_formater.dart';

void main(){

  test('Should return a string value of date', () {
    
    DateTime date1 = new DateTime(2018,7,12,7,51,10);
    DateTime date2 = new DateTime(2018,7,12,14,51,10);


    expect(dateToString(date1), '2018-07-12 07:51:10');
    expect(dateToString(date2), '2018-07-12 14:51:10');
  });
}