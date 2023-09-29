import 'package:flutter/material.dart';
import 'package:siap/models/model.dart';
import 'package:siap/services/service.dart';

class MekanikSewing extends StatefulWidget {
  final String? gedung;
  final String? kodebagian;
  MekanikSewing({super.key, this.gedung, this.kodebagian});

  @override
  State<MekanikSewing> createState() => _MekanikSewingState();
}

class _MekanikSewingState extends State<MekanikSewing> {
  TextEditingController txt_kodebarang = TextEditingController();
  TextEditingController txt_namabarang = TextEditingController();
  TextEditingController txt_rusak = TextEditingController();
  String? errorMsg;
  SiapApiService? siapApiService;

  List<Teknisi> _items = [];
  List<Lokasi> _lokasi = [];
  Teknisi? _selectedItem;
  Lokasi? _selectedLokasi;

  @override
  void initState() {
    super.initState();
    siapApiService = SiapApiService();
    siapApiService
        ?.getTeknisi(widget.gedung.toString(), widget.kodebagian.toString())
        .then((value) {
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
                        DropdownButtonFormField<Teknisi>(
                          value: _selectedItem,
                          items: _items.map((item) {
                            return DropdownMenuItem<Teknisi>(
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
                        SizedBox(height: 10.0),
                        TextFormField(
                          // validator: (String? value) {
                          //   if (value!.isEmpty) {
                          //     return 'Kode Barang';
                          //   }
                          //   return null;
                          // },
                          controller: txt_kodebarang,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Kode Barang',
                            errorText: errorMsg,
                            labelStyle: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Nama Barang Harus Di Isi';
                            }
                            return null;
                          },
                          controller: txt_namabarang,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Nama Barang',
                            errorText: errorMsg,
                            labelStyle: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Keluhan Harus Di Isi';
                            }
                            return null;
                          },
                          controller: txt_rusak,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Keluhan',
                            errorText: errorMsg,
                            labelStyle: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.send),
                          label: Text(
                            'Kirim',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 50),
                          ),
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
