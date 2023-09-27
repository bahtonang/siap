import 'package:flutter/material.dart';
import 'package:siap/component/siapappbar.dart';
import 'package:siap/models/menus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChiefHome extends StatefulWidget {
  const ChiefHome({super.key});

  @override
  State<ChiefHome> createState() => _ChiefHomeState();
}

class _ChiefHomeState extends State<ChiefHome> {
  late SharedPreferences _preferences;
  late String _storedValue = "";

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadStoredValue();
  }

  Future<void> _loadStoredValue() async {
    setState(() {
      _storedValue = _preferences.getString("pidKey") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new SiapAppBar(),
        backgroundColor: Colors.white,
        body: new Container(
          child: new ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      _buildTopMenu(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildMenu(),
                    ],
                  )),
              new Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 16.0),
                child: new Column(
                  children: <Widget>[
                    _menuGambar(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopMenu() {
    return new Container(
      height: 120.0,
      decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(3.0))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome :",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: "NeoSans"),
                  ),
                  Text(
                    _storedValue.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "NeoSansBold"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  "https://cdn1-production-images-kly.akamaized.net/6xrsJLddHBYsPX4H4_Sb1AHjreE=/469x625/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/1043120/original/b720028eb1c8d0a921769dda0c33126d-063745600_1446613692-raisa__9_.jpg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return new SizedBox(
        width: double.infinity,
        height: 250.0,
        child: new Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: <Widget>[
              MenuIcon(
                icon: Icons.auto_stories,
                iconColor: Colors.orange,
                label: "Profile",
                onPres: () {
                  print('profile');
                },
              ),
              MenuIcon(
                icon: Icons.add_to_home_screen,
                iconColor: Colors.green,
                label: "Pulang",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.deck_rounded,
                iconColor: Colors.purple,
                label: "Absen",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.auto_stories,
                iconColor: Colors.green,
                label: "Kode Gaji ",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.article_outlined,
                iconColor: Colors.orange,
                label: "SlipGaji",
                onPres: () {},
              ),
            ],
          ),
        ));
  }

  Widget _menuGambar() {
    return new Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text(
            "Aktivitas",
            style: new TextStyle(fontFamily: "NeoSansBold"),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          new Text(
            "Aktifitas Terupdate",
            style: new TextStyle(fontFamily: "NeoSansBold"),
          ),
          new SizedBox(
            height: 172.0,
            child: FutureBuilder<List>(
                future: fetchFood(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new ListView.builder(
                      itemCount: snapshot.data?.length,
                      padding: EdgeInsets.only(top: 12.0),
                      physics: new ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _rowGambar(snapshot.data?[index]);
                      },
                    );
                  }
                  return Center(
                    child: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: const CircularProgressIndicator()),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _rowGambar(Food food) {
    return new Container(
      margin: EdgeInsets.only(right: 16.0),
      child: new Column(
        children: <Widget>[
          new ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image.network(
              food.url,
              width: 132.0,
              height: 132.0,
            ),
          ),
          //  ),
          new Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          new Text(
            food.title,
          ),
        ],
      ),
    );
  }

  Future<List<Food>> fetchFood() async {
    List<Food> _goFoodFeaturedList = [];
    _goFoodFeaturedList.add(new Food(
        title: "Steak Andakar",
        url:
            'https://upload.wikimedia.org/wikipedia/commons/7/78/Wulan_Guritno_on_Festival_Film_Indonesia_2015.jpg'));
    _goFoodFeaturedList.add(new Food(
        title: "Mie Ayam Tumini",
        url:
            'https://media.suara.com/suara-partners/manado/thumbs/653x367/2023/08/19/1-dian.png'));
    _goFoodFeaturedList.add(new Food(
        title: "Tengkleng Hohah",
        url:
            'https://img.antaranews.com/cache/1200x800/2021/08/31/Screenshot_2020-09-18-17-02-01-33_copy_1320x880.jpg.webp'));
    _goFoodFeaturedList.add(new Food(
        title: "Warung Steak",
        url:
            'https://fajar.co.id/wp-content/uploads/2020/05/Dian-Sastro-1.jpg'));
    _goFoodFeaturedList.add(new Food(
        title: "Kindai Warung Banjar",
        url: 'http://192.168.32.1/asik/images/SF13773.jpg'));
    return new Future.delayed(new Duration(seconds: 1), () {
      return _goFoodFeaturedList;
    });
  }
}

class Food {
  String title;
  String url;

  Food({required this.title, required this.url});
}