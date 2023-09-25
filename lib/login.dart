import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siap/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormkey = GlobalKey<FormState>();
  TextEditingController txtPid = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  String? errorMsg;
  String namauser = "";
  String nopid = "";
  SiapApiService? siapApiService;

  late SharedPreferences _prefs;

  @override
  void initState() {
    siapApiService = SiapApiService();
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveValue() async {
    await _prefs.setString("pidKey", namauser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0, left: 40.0, right: 40.0),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Form(
            key: loginFormkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                  width: 10,
                  child: Image.asset("assets/images/logosiap.png"),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Nama Harus di Isi';
                    }
                    return null;
                  },
                  controller: txtPid,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'PID',
                    errorText: errorMsg,
                    labelStyle: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password Harus Di isi';
                    }
                    return null;
                  },
                  controller: txtPass,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: errorMsg ?? null,
                    labelStyle: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _handleLoginButton();
                  },
                  icon: const Icon(Icons.key),
                  label: const Text(
                    'Login',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _handleLoginButton() {
    if (loginFormkey.currentState!.validate()) {
      siapApiService?.login('SF13773', '1234').then((value) {
        if (value == null) {
          setState(() {
            errorMsg = "PID atau Password Salah";
          });
        } else {
          setState(() {});
          nopid = value.user.pid;
          namauser = value.user.nama;
          _saveValue();
          //print(resultApi?.user.pid);
          context.goNamed('menuutama');
        }
      });
    }
  }
}
