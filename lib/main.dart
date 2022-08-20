import 'package:biblia_sagrada/controller/controller.dart';
import 'package:biblia_sagrada/home/home.leitura.page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  Controller controller = Controller();
  // controller.getVersiculos(versao: 'nvi', livro: 'gn', capitulo: 50);
  // controller.getCapitulos(versao: 'nvi', livro: 'dt');
  // controller.getNumVersiculos(versao: 'nvi', livro: 'ap', capitulo: 22);

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Controller>(Controller());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bíblia Sagrada',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LeituraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
