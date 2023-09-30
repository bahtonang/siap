import 'package:flutter/material.dart';
import 'package:siap/models/model.dart';
import 'package:siap/services/service.dart';

class CobaDropdwn extends StatefulWidget {
  const CobaDropdwn({super.key});

  @override
  State<CobaDropdwn> createState() => _CobaDropdwnState();
}

class _CobaDropdwnState extends State<CobaDropdwn> {
  SiapApiService? siapApiService;
  List<Teknisi> _items = [];

  Teknisi? _selectedItem;

  @override
  void initState() {
    siapApiService = SiapApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drop'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            DropdownButtonHideUnderline(
                child: FutureBuilder(
                    future: siapApiService?.getTeknisi('STL2', 'MKS'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container();
                      } else if (snapshot.hasData) {
                        _items.clear();
                      }

                      return Container();
                    }))
          ],
        ),
      ),
    );
  }
}
