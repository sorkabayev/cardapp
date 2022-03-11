import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/model.dart';

class HiveDB{
  static String DB_NAME = "add_card_with_hive_database";
  static var box = Hive.box(DB_NAME);

  static Future<void> storeCardList(List<Note> list) async{
    List<String> stringList = list.map((card) => jsonEncode(card.toJson())).toList();
    await box.put('cardList', stringList);
  }

  static Future<List> loadList() async{
    var result = await box.get("cardList");
    List cardList = result.map((stringCard) => Note.fromJson(jsonDecode(stringCard))).toList();
    return cardList;
  }

  static void removeCard(int index) async{
    await box.deleteAt(index);
  }

}