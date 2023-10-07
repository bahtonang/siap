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

  @override
  void initState() {
    siapApiService = SiapApiService();
    super.initState();
  }

  // getData() async {
  //   final respond =
  //       await siapApiService?.tiketAction(widget.notiket.toString());
  //   setState(() {
  //     tiketlist = respond;
  //     print(tiketlist);
  //   });
  // }

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
                FutureBuilder<List<Tiket?>>(
                    future:
                        siapApiService?.tiketAction(widget.notiket.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Container();
                      } else {
                        List<Tiket?> list = snapshot.data ?? [];
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              Tiket? tikets = list[index];
                              return Column(
                                children: [
                                  Text('$tikets.keluhan'),
                                ],
                              );
                            });
                      }
                    }),
                SizedBox(
                  height: 20.0,
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
                SizedBox(height: 300),
                Text(widget.notiket.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
