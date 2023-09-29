import 'package:siap/models/model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class SiapApiService {
  Client client = Client();

  Future<Person?> login(String pid, String pass) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    var respond = await client.post(
        Uri.parse("http://192.168.32.1/apisiap/public/otentikasi/login"),
        headers: header,
        body: json.encode({"pid": pid, "pass": pass}));
    if (respond.statusCode == 200) {
      final data = personFromJson(respond.body);
      return data;
    }
    return null;
  }

  Future<List<Teknisi>> getTeknisi(String gedung, kodebagian) async {
    var respond = await client.get(Uri.parse(
        "http://192.168.32.1/apisiap/public/teknisi/$gedung/$kodebagian"));
    if (respond.statusCode == 200) {
      var jsonData = jsonDecode(respond.body);
      var jsonArray = jsonData['data'];
      List<Teknisi> listteknisi = [];
      for (var data in jsonArray) {
        Teknisi teknisi = Teknisi(nama: data['nama']);
        listteknisi.add(teknisi);
      }
      return listteknisi;
    }
    return [];
  }

  Future<List<Personal>> getPersonal(String gedung, statusstaf) async {
    var respond = await client.get(Uri.parse(
        "http://192.168.32.1/apisiap/public/personal/$gedung/$statusstaf"));
    if (respond.statusCode == 200) {
      var jsonData = jsonDecode(respond.body);
      var jsonArray = jsonData['data'];
      List<Personal> listpersonal = [];
      for (var data in jsonArray) {
        Personal personal = Personal(
            pid: data['pid'], nama: data['nama'], gedung: data['gedung']);
        listpersonal.add(personal);
      }
      return listpersonal;
    }
    return [];
  }

  Future<List<Lokasi>> getLokasi(String gedung) async {
    var respond = await client
        .get(Uri.parse("http://192.168.32.1/apisiap/public/lokasi/$gedung"));
    if (respond.statusCode == 200) {
      var jsonData = json.decode(respond.body);
      var jsonArray = jsonData['data'];
      List<Lokasi> listlokasi = [];
      for (var data in jsonArray) {
        Lokasi lokasi = Lokasi(
          nama: data['nama'],
        );
        listlokasi.add(lokasi);
      }
      return listlokasi;
    }
    return [];
  }

  // Future<List<TCard>> getTimecard(
  //     String pid, String bulan, String tahun) async {
  //   var respond = await client.get(Uri.parse(
  //       "http://192.168.19.3/ciasik/public/tcard/$pid/$bulan/$tahun"));
  //   if (respond.statusCode == 200) {
  //     var jsonData = json.decode(respond.body);

  //     var jsonArray = jsonData['data'];
  //     List<TCard> tc = [];
  //     for (var jsonTC in jsonArray) {
  //       TCard ntcard = TCard(
  //           tgl: jsonTC['tgl'],
  //           absenstatus: jsonTC['absenstatus'],
  //           checkin: jsonTC['checkin'],
  //           checkout: jsonTC['checkout'],
  //           checkoutcount: jsonTC['checkoutcount'],
  //           overtime: jsonTC['overtime']);
  //       tc.add(ntcard);
  //     }
  //     return tc;
  //   }
  //   return [];
  // }
}
