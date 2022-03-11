import 'package:cardapp/pages/add_card.dart';
import 'package:cardapp/pages/create_card_page.dart';
import 'package:cardapp/services/hive_service.dart';
import 'package:cardapp/services/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  //
  // /// for FireBase
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  /// for Hive
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: AddCardPage(),
        routes: {
          AddCardPage.id: (context) => AddCardPage(),
          CardsPage.id: (context) => CardsPage(),
        });
  }

}