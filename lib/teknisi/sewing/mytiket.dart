import 'package:flutter/material.dart';
import 'package:siap/services/service.dart';
import 'package:siap/models/model.dart';

class MyTiket extends StatefulWidget {
  final String? gedung;
  MyTiket({super.key, this.gedung});

  @override
  State<MyTiket> createState() => _MyTiketState();
}

class _MyTiketState extends State<MyTiket> {
  SiapApiService? siapApiService;

  @override
  void initState() {
    super.initState();
    siapApiService = SiapApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Tiket'),
      ),
      body: Container(
        child: FutureBuilder(
            future: siapApiService?.getTiket(widget.gedung.toString()),
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Center(
                      child: Text('No Connection'),
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Tidak Ada Data'),
                      ),
                    );
                  } else {
                    List<Tiket?> data = snapshot.data ?? [];
                    return snapshot.hasData
                        ? _dataTiket(data)
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                    // return Container();
                  }
              }
            }),
      ),
    );
  }

  Widget _dataTiket(List<Tiket?> list) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int i) =>
                Divider(color: Colors.black54),
            itemCount: list.length,
            itemBuilder: (context, index) {
              Tiket? tiket = list[index]!;
              return ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            tiket.notiket ?? '',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(tiket.lokasi ?? '',
                              style: TextStyle(fontSize: 16.0)),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(tiket.keluhan ?? '',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue,
                  ));
            },
          ),
        ),
      ],
    );
  }
}