import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));
String personToJson(Person data) => json.encode(data.toJson());

class Person {
  Person({
    required this.error,
    required this.message,
    required this.user,
    required this.accessToken,
  });

  bool error;
  String message;
  User user;
  String accessToken;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        error: json["error"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class User {
  User({
    required this.pid,
    required this.nama,
    required this.gedung,
  });

  String pid;
  String nama;
  String gedung;

  factory User.fromJson(Map<String, dynamic> json) => User(
        pid: json["pid"],
        nama: json["nama"],
        gedung: json["gedung"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "nama": nama,
        "gedung": gedung,
      };
}

//-------------------------------------------------------
class TCard {
  TCard({
    required this.tgl,
    required this.absenstatus,
    required this.checkin,
    required this.checkout,
    required this.checkoutcount,
    required this.overtime,
  });

  String tgl;
  String absenstatus;
  String checkin;
  String checkout;
  String checkoutcount;
  String overtime;
}

class Lokasi {
  Lokasi({required this.pid, required this.nama});
  String pid;
  String nama;
}
