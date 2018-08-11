// import 'dart:io';

// import 'package:flutter_emergency_app_one/services/local/database_helper.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:mockito/mockito.dart';

// void main(){


/*
can't run unit test on codes that depends on plugins...

https://github.com/tekartik/sqflite/issues/49
https://stackoverflow.com/questions/46382789/how-to-run-tests-with-code-that-depends-on-plugins
*/ 
      // MockDatabaseHelper dbHelper = new MockDatabaseHelper();

      // Future<String> _getDbPath() async {
      //  // Directory path = await getApplicationDocumentsDirectory();
      //  // return join(path.path, 'mock_soul_db');
      //  return "/data/user/0/com.nony.flutteremergencyappone/app_flutter/mock_soul_db";
      // }
      // setUp(() async{
          
      //     String path = await _getDbPath();
      //     Future<Database> db =  openDatabase(path,
      //     version: 1,
      //     onCreate: (database, version) async{
      //           await database.execute('CREATE TABLE "Verse" ( `id` INTEGER NOT NULL, `content` TEXT, `quotation` TEXT, `isFaved` INTEGER DEFAULT 0, `categoryId` INTEGER NOT NULL, `dateAdded` TEXT, `isDefault` INTEGER DEFAULT 0, PRIMARY KEY(`id`) )');
      //     },
      //     onOpen: (database) {
      //       print('the database is open');
      //  });
      //     when(dbHelper.db).thenAnswer((_) => db);
      // });

      // test('Database executes', () async{
       
      //       Database db = await dbHelper.db;

      //       await db.rawQuery("INSERT INTO Verse VALUES(15,'hello','john 11:25',1,1,'date',1)");

      //       List<Map> verses = await db.rawQuery("SELECT * FROM Verse");

      //       expect(verses.length, 1);
        
      // });


      // tearDownAll(() async{
      //     String path = await _getDbPath();
      //     deleteDatabase(path);
      // });

// }

//class MockDatabaseHelper extends Mock implements DatabaseHelper{}