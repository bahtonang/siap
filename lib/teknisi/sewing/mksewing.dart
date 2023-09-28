import 'package:flutter/material.dart';
import 'package:siap/models/model.dart';
import 'package:siap/services/service.dart';

class MekanikSewing extends StatefulWidget {
  final String? gedung;
  MekanikSewing({super.key, this.gedung});

  @override
  State<MekanikSewing> createState() => _MekanikSewingState();
}

class _MekanikSewingState extends State<MekanikSewing> {
  SiapApiService? siapApiService;

  List<Personal> _items = [];
  List<Lokasi> _lokasi = [];
  Personal? _selectedItem;
  Lokasi? _selectedLokasi;

  @override
  void initState() {
    super.initState();
    siapApiService = SiapApiService();
    siapApiService?.getPersonal(widget.gedung.toString(), 'T').then((value) {
      setState(() {
        _items = value;
      });
    });

    siapApiService?.getLokasi(widget.gedung.toString()).then((valuelokasi) {
      setState(() {
        _lokasi = valuelokasi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mekanik Sewing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 233, 235, 236)),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        DropdownButtonFormField<Personal>(
                          value: _selectedItem,
                          items: _items.map((item) {
                            return DropdownMenuItem<Personal>(
                                child: Text(item.nama), value: item);
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedItem = newValue;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'Pilih Nama',
                              border: OutlineInputBorder(
                                borderSide: (BorderSide(
                                    color: Color.fromARGB(255, 42, 4, 85),
                                    width: 12)),
                              )),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<Lokasi>(
                          value: _selectedLokasi,
                          onChanged: (newValuelok) {
                            setState(() {
                              _selectedLokasi = newValuelok;
                            });
                          },
                          items: _lokasi.map((itemlok) {
                            return DropdownMenuItem<Lokasi>(
                                value: itemlok, child: Text(itemlok.nama));
                          }).toList(),
                          decoration: InputDecoration(
                              labelText: 'Pilih Lokasi',
                              border: OutlineInputBorder(
                                borderSide: (BorderSide(
                                    color: Color.fromARGB(255, 42, 4, 85),
                                    width: 12)),
                              )),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
