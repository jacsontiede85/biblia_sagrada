// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:biblia_sagrada/home/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LeituraPage extends StatefulWidget {
  const LeituraPage({Key? key}) : super(key: key);

  @override
  State<LeituraPage> createState() => _LeituraPageState();
}

class _LeituraPageState extends State<LeituraPage> with Widgets{
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
      // ignore: unused_local_variable
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
        if(!loading){
          // print('Min index: $min ::: Max index: $max');
          if(min==0)
            controller.versiculoSelecionado = 1;
          else if(max==controller.getVersiculosExibirLeitura.length-1)
            controller.versiculoSelecionado = max+1;
          else
            controller.versiculoSelecionado = min+1;
        }
      }
    });
  }

  bool loading = true;
  moveScroll() async{
    await Future.delayed(Duration(milliseconds: 100));
    await itemScrollController.scrollTo(
        index: controller.versiculoSelecionado-1,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutCubic
    );
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Observer(builder: (_)=>
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${controller.nomeLivroSelecionado} ${controller.capituloSelecionado}', style: TextStyle(color: fonteColor, fontSize: fontSize+4),),
                    SizedBox(width: 2,),
                    Text(': ${controller.versiculoSelecionado}', style: TextStyle(color: Colors.grey.shade300, fontSize: fontSize+4),),
                  ],
                ),
                SizedBox(height: 5,),
                Text('${controller.getNomeVersao} (${controller.versao.toUpperCase()})', style: TextStyle(color: Colors.grey.shade300, fontSize: fontSize-5),),
              ],
            )
        ),
        backgroundColor: Colors.black54,
        elevation: 0.0,
        toolbarHeight: 70,
        centerTitle: true,
        actions: [
          SizedBox(width: 50, height: 15, child: dropdownVersion(context: context),),
        ],
      ),
      body: Observer(builder: (_)=>
          Column(
            children: [
              Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade600, width: 0.5, ),),),),
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
