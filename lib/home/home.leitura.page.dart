// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LeituraPage extends StatefulWidget {
  const LeituraPage({Key? key}) : super(key: key);

  @override
  State<LeituraPage> createState() => _LeituraPageState();
}

class _LeituraPageState extends State<LeituraPage>{
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final controller = GetIt.I.get<Controller>();

  double fontSize = 16;
  Color fonteColor = Colors.white;
  Color backgroundColor = Colors.black87;

  @override
  void initState() {
    addListenerScroll();
    moveScroll();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  addListenerScroll(){
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();

    itemPositionsListener.itemPositions.addListener((){
      int min, max, index;
      if (itemPositionsListener.itemPositions.value.isNotEmpty) {
        min = itemPositionsListener.itemPositions.value
            .where((ItemPosition position) => position.itemTrailingEdge > 0)
            .reduce((ItemPosition min, ItemPosition position) =>
        position.itemTrailingEdge < min.itemTrailingEdge
            ? position
            : min
        ).index;

        max = itemPositionsListener.itemPositions.value
            .where((ItemPosition position) => position.itemTrailingEdge > 0)
            .reduce((ItemPosition max, ItemPosition position) =>
        position.itemTrailingEdge > max.itemTrailingEdge
            ? position
            : max
        ).index;
        // print('Min index: $min ::: Max index: $max');
        // controller.versiculoSelecionado = min+2;
      }
    });
  }

  moveScroll() async{
    await Future.delayed(Duration(milliseconds: 100));
    await itemScrollController.scrollTo(
        index: controller.versiculoSelecionado-1,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutCubic
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Observer(builder: (_)=>
            Column(
              children: [
                Text(controller.nomeLivroSelecionado, style: TextStyle(color: fonteColor, fontSize: fontSize+2),),
                Text('Capítulo: ${controller.capituloSelecionado}  Versículo: ${controller.versiculoSelecionado}', style: TextStyle(color: Colors.grey.shade300, fontSize: fontSize-3),),
              ],
            ),
        ),
        backgroundColor: Colors.black54,
        elevation: 0.0,
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: Observer(builder: (_)=>
          Column(
            children: [
              Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade600, width: 1.0, ),),),),
              Flexible(
                child: ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    itemCount: controller.getVersiculosExibirLeitura.length,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: (){
                          },
                          child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
                              // decoration: BoxDecoration(
                              //   border: Border(top: BorderSide(color: Colors.grey.shade600, width: 1.0, ),),
                              // ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      '${index+1} ${controller.getVersiculosExibirLeitura[index]}',
                                      style: TextStyle(color: fonteColor, fontSize: fontSize+3),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        )
                ),
              )
            ],
          )
      ),
    );
  }
}
