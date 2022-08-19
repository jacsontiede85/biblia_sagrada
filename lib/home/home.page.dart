// ignore_for_file: prefer_const_constructors

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final controller = GetIt.I.get<Controller>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),
      body: Observer(builder: (_)=>
          ListView.builder(
            itemCount: controller.getLivros.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${controller.getLivros[index]['abrev']}'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '${controller.getLivros[index]['nome']}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              )
            ),
          ),
      )
    );
  }
}
