// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'dart:convert';


class Pets {
    Pets({
        required this.nameOwner,
        required this.cellphoneOwner,
        required this.raza,
        required this.sex,
        required this.age,
        required this.type,
        required this.dateBirth
    });

      String nameOwner;
      String cellphoneOwner;
      int raza;
      int sex;
      int age;
      String type;
      DateTime dateBirth;


    factory Pets.fromJson(String str) => Pets.fromMap(json.decode(str));

    factory Pets.fromMap(Map<String, dynamic> json) => Pets(
        nameOwner       : json["nameOwner"],
        cellphoneOwner: json["cellphoneOwner"],
        raza    : json["cellphoneOwner"],
        sex          : json["sex"],
        age: json["age"],
        type   : json["type"],
        dateBirth    : json["dateBirth"],
    );
   


}