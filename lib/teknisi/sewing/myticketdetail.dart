import 'package:flutter/material.dart';
import 'package:siap/models/model.dart';
import 'package:siap/services/service.dart';

class MktiketDetail extends StatefulWidget {
  final String? notiket;
  const MktiketDetail({super.key, this.notiket});

  @override
  State<MktiketDetail> createState() => _MktiketDetailState();
}

class _MktiketDetailState extends State<MktiketDetail> {
  SiapApiService? siapApiService;
  String? tiketno;

  @override
  void initState() {
    siapApiService = SiapApiService();
    super.initState();
    _getData();
  }

  _getData() async {
    final respond =
        await siapApiService?.tiketAction(widget.notiket.toString());
    setState(() {
      tiketno = respond!.datanotiket.notiket;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Detail'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  title: Text('No Tiket'),
                  subtitle: Text(tiketno ?? ''),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text(
                    'Mulai',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text(
                    'Tutup',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
