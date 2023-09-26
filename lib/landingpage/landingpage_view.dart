import 'package:flutter/material.dart';
import 'package:siap/clients/chiefs.dart';
import 'package:siap/constans.dart';
// import 'package:siap/manager/home.dart';
import 'package:siap/spv/spv_home.dart';
import 'package:siap/teknisi/mekaniksewing.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final String bagian = 'SPV';

  pilihWidget() {
    if (bagian == 'SPV') {
      return new SpvHome();
    } else if (bagian == 'MS') {
      //  return MenkanikSewing();
      return ChiefHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: pilihWidget(), bottomNavigationBar: buildBottomNavigation());
  }

  Widget buildBottomNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // onTap: (index) {
      //   setState(() {
      //     _bottomNavCurrentIndex = index;
      //   });
      // },
      onTap: null,

      // currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: GojekPalette.green,
          ),
          icon: new Icon(
            Icons.home,
            color: Colors.grey,
          ),
          // title: new Text(
          //   'Beranda',
          // ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: GojekPalette.green,
          ),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          label: 'Inbox',

          // title: new Text('Inbox'),
        ),
        BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.person,
              color: GojekPalette.green,
            ),
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            ),
            // title: new Text('Akun'),
            label: 'Profile'),
      ],
    );
  }
}
