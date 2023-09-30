import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtKodebarang = TextEditingController();
  TextEditingController txtNamabarang = TextEditingController();
  TextEditingController txtKeluhan = TextEditingController();
  String? errorMsg;
  String? errorTeknisi;
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

  Future savetiket() async {
    siapApiService
        ?.kirimticket('kdbrg', txtNamabarang.text, txtKeluhan.text,
            widget.gedung.toString(), 'surti')
        .then((value) => true);
    if (true) {
      setState(() {});
      txtKodebarang.clear();
      txtKeluhan.clear();
      txtNamabarang.clear();
      await _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tiket Terkirim'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Permintaan sudah di kirim ke Mekanik'),
                Text('Silakan periksa status tiket di menu utama'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                //Navigator.of(context).pop();
                context.goNamed('menuutama');
              },
            ),
          ],
        );
      },
    );
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
                    key: _formKey,
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
                          validator: (_selectedItem) => _selectedItem == null
                              ? 'Nama Harus di pilih'
                              : null,
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
                          validator: (_selectedItem) => _selectedItem == null
                              ? 'Lokasi Harus di pilih'
                              : null,
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
                          controller: txtKodebarang,
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
                          controller: txtNamabarang,
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
                          controller: txtKeluhan,
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              savetiket();
                            }
                          },
                          icon: Icon(Icons.send),
                          label: Text(
                            'Kirim',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 50),
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
