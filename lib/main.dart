import 'package:dinamik_ortalama_hesaplama/constants/app_constants.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/ortalama_hesaplama.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Ortalama Hesaplama',
      theme: ThemeData(
          primarySwatch:Sabitler.anaRenk,

          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: OrtalamaHesaplamaPage(),
    );
  }
}
