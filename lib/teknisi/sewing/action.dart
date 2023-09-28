import 'package:flutter/material.dart';

class ActionMKSewing extends StatefulWidget {
  const ActionMKSewing({super.key});

  @override
  State<ActionMKSewing> createState() => _ActionMKSewingState();
}

class _ActionMKSewingState extends State<ActionMKSewing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih '),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text(
                    'Lacak',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text(
                    'Ticket Baru',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text(
                    'Close Ticket',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
