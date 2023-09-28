import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siap/models/model.dart';
import 'package:siap/services/service.dart';

class MekanikSewing extends StatefulWidget {
  const MekanikSewing({super.key});

  @override
  State<MekanikSewing> createState() => _MekanikSewingState();
}

class _MekanikSewingState extends State<MekanikSewing> {
  SiapApiService? siapApiService;

  List<Personal> _items = [];
  Personal? _selectedItem;

  late SharedPreferences _preferences;
  late String spNama = "";
  late String spGedung = "";
  late String spPid = "";

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadSpValue();
  }

  Future<void> _loadSpValue() async {
    setState(() {
      spPid = _preferences.getString("sp_pid") ?? "";
      spNama = _preferences.getString("sp_nama") ?? "";
      spGedung = _preferences.getString("sp_gedung") ?? "";
    });
  }

  @override
  void initState() {
    siapApiService = SiapApiService();
    super.initState();
    _initSharedPreferences();
    siapApiService?.getPersonal('STL11', 'T').then((value) {
      setState(() {
        _items = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mekanik Sewing'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('$spGedung'),
            SizedBox(
              height: 300,
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.access_alarm),
                  label: Text('Panggil')),
            ),
          ],
        ),
      ),
    );
  }
}
