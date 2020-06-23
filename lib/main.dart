import 'package:flutter/material.dart';
import 'package:qouteapp/pages/loading.dart';
import 'package:qouteapp/pages/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));
}
