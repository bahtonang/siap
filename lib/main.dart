import 'package:flutter/material.dart';
import 'package:siap/landingpage/landingpage_view.dart';
import 'package:siap/constans.dart';
import 'package:siap/login.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return LoginPage();
        }),
    GoRoute(
        path: '/',
        name: 'menuutama',
        builder: (context, state) {
          return LandingPage();
        }),
  ], initialLocation: '/login', debugLogDiagnostics: true, routerNeglect: true);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Siap',
      theme: new ThemeData(
        fontFamily: 'NeoSans',
        primaryColor: GojekPalette.green,
      ),
      //  home: LandingPage(),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
