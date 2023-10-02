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

class Personal {
  Personal({required this.pid, required this.nama, required this.gedung});
  String pid;
  String nama;
  String gedung;
}

class Lokasi {
  Lokasi({required this.nama});
  String nama;
}

class Teknisi {
  Teknisi({required this.nama});
  String nama;

  factory Teknisi.fromJson(Map<String, dynamic> json) => Teknisi(
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
      };
}

class Tiket {
  final String? notiket;
  final String? tgl;
  final String? kodebarang;
  final String? namabarang;
  final String? keluhan;
  final String? lokasi;
  final String? gedung;
  final String? pengirim;
  final String? teknisi;
  final String? mulai;
  final String? selesai;
  final String? statustiket;
  final String? baca;
  final String? tutup;
  final String? keterangan;

  Tiket({
    required this.notiket,
    required this.tgl,
    required this.kodebarang,
    required this.namabarang,
    required this.keluhan,
    required this.lokasi,
    required this.gedung,
    required this.pengirim,
    required this.teknisi,
    required this.mulai,
    required this.selesai,
    required this.statustiket,
    required this.baca,
    required this.tutup,
    required this.keterangan,
  });

  factory Tiket.fromJson(Map<String, dynamic> json) => Tiket(
        notiket: json["notiket"],
        tgl: json["tgl"],
        kodebarang: json["kodebarang"],
        namabarang: json["namabarang"],
        keluhan: json["keluhan"],
        lokasi: json["lokasi"],
        gedung: json["gedung"],
        pengirim: json["pengirim"],
        teknisi: json["teknisi"],
        mulai: json["mulai"],
        selesai: json["selesai"],
        statustiket: json["statustiket"],
        baca: json["baca"],
        tutup: json["tutup"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "notiket": notiket,
        "tgl": tgl,
        "kodebarang": kodebarang,
        "namabarang": namabarang,
        "keluhan": keluhan,
        "lokasi": lokasi,
        "gedung": gedung,
        "pengirim": pengirim,
        "teknisi": teknisi,
        "mulai": mulai,
        "selesai": selesai,
        "statustiket": statustiket,
        "baca": baca,
        "tutup": tutup,
        "keterangan": keterangan,
      };
}
