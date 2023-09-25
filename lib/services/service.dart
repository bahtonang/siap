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

  Future<List<Lokasi>> getLokasi(String pid) async {
    var respond = await client
        .get(Uri.parse("http://192.168.19.3/ciasik/public/lokasi/$pid"));
    if (respond.statusCode == 200) {
      var jsonData = json.decode(respond.body);
      var jsonArray = jsonData['data'];
      List<Lokasi> lokasi = [];
      for (var jsonLokasi in jsonArray) {
        Lokasi lok = Lokasi(
          pid: jsonLokasi['pid'],
          nama: jsonLokasi['nama'],
        );
        lokasi.add(lok);
      }
      return lokasi;
    }
    return [];
  }

  Future<List<TCard>> getTimecard(
      String pid, String bulan, String tahun) async {
    var respond = await client.get(Uri.parse(
        "http://192.168.19.3/ciasik/public/tcard/$pid/$bulan/$tahun"));
    if (respond.statusCode == 200) {
      var jsonData = json.decode(respond.body);

      var jsonArray = jsonData['data'];
      List<TCard> tc = [];
      for (var jsonTC in jsonArray) {
        TCard ntcard = TCard(
            tgl: jsonTC['tgl'],
            absenstatus: jsonTC['absenstatus'],
            checkin: jsonTC['checkin'],
            checkout: jsonTC['checkout'],
            checkoutcount: jsonTC['checkoutcount'],
            overtime: jsonTC['overtime']);
        tc.add(ntcard);
      }
      return tc;
    }
    return [];
  }
}
