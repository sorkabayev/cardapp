import 'dart:convert';

List<Note> imagesFromJson(String str) => List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String imagesToJson(List<Note> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

bool isConnected = false;

class Note{

  late String id;
  late String cardNumber;
  late String cardHolder;
  late String expiredDate;
  late String cvv2;

  Note(this.cardNumber, this.cardHolder, this.expiredDate, this.cvv2);

  Note.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'].toString();
    cardHolder = json['cardHolder'];
    expiredDate = json['expiredDate'].toString();
    cvv2 = json['cvv2'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cardNumber'] = cardNumber.toString();
    map['cardHolder'] = cardHolder;
    map['expiredDate'] = expiredDate.toString();
    map['cvv2'] = cvv2.toString();
    return map;
  }

}
