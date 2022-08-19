// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  final controller = GetIt.I.get<Controller>();
  late TabController tabController;

  double fontSize = 16;
  Color fonteColor = Colors.white;
  Color backgroundColor = Colors.black87;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this );
    super.initState();
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0.0,
        toolbarHeight: 0,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Text('Livro', style: TextStyle(color: fonteColor, fontSize: fontSize+2),),
            Text('Capítulo', style: TextStyle(color: fonteColor, fontSize: fontSize+2),),
            Text('Versículo', style: TextStyle(color: fonteColor, fontSize: fontSize+2),),
          ],
        ),
      ),
      body: Observer(builder: (_)=>
          ListView.builder(
            itemCount: controller.getLivros.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade600, width: 1.0, ),),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${controller.getLivros[index]['abrev']}'.toUpperCase(),
                      style: TextStyle(color: fonteColor, fontSize: fontSize-2),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '${controller.getLivros[index]['nome']}',
                      style: TextStyle(color: fonteColor, fontSize: fontSize),
                    ),
                  ),
                ],
              )
            ),
          ),
      )
    );
  }
}
