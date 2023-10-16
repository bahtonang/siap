import 'package:flutter/material.dart';

class ValidasiTicket extends StatefulWidget {
  final String? vali, teknisi, barang;
  ValidasiTicket({super.key, this.barang, this.teknisi, this.vali});

  @override
  State<ValidasiTicket> createState() => _ValidasiTicketState();
}

class _ValidasiTicketState extends State<ValidasiTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                'Scan Untuk Validasi Closing Ticket',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${widget.vali}'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('rata kiri'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('rata kiri'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
