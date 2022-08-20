// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:biblia_sagrada/home/home.selecionar.livro.page.dart';
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
        if(!pausarAcaoListennerScroll){
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

  bool pausarAcaoListennerScroll = true;
  moveScroll() async{
    await Future.delayed(Duration(milliseconds: 100));
    await itemScrollController.scrollTo(
        index: controller.versiculoSelecionado-1,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutCubic
    );
    pausarAcaoListennerScroll = false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black87,
      child: Observer(builder: (_)=>
          Stack(
            children: [
              Scaffold(
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  titleSpacing: 3.0,
                  title: Observer(builder: (_)=>
                      Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Column(
                                children: [
                                  Text('Bíblia Sagrada', style: TextStyle(color: fonteColor, fontSize: fontSize),),
                                  SizedBox(height: 1,),
                                  Text('${controller.getNomeVersao} (${controller.versao.toUpperCase()})', style: TextStyle(color: Colors.grey.shade300, fontSize: fontSize-5),),
                                ],
                              ),
                              Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 12, bottom: 5),
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceAround,
                                    children: [

                                      if(!controller.exibirPesquisa)
                                        InkWell(
                                          onTap: () async{
                                            await Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeSelecionarLivroPage()));
                                            moveScroll();
                                          },
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Container(
                                                color: Colors.grey.shade900,
                                                height: 26,
                                                padding: EdgeInsets.only(left: 10, right: 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text('${controller.nomeLivroSelecionado} ${controller.capituloSelecionado}', style: TextStyle(color: fonteColor, fontSize: fontSize-2),),
                                                    SizedBox(width: 2,),
                                                    Text(': ${controller.versiculoSelecionado}', style: TextStyle(color: Colors.grey.shade300, fontSize: fontSize-2),),
                                                    SizedBox(width: 2,),
                                                    Icon(Icons.arrow_drop_down_sharp, color: Colors.white, size: 25,)
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),

                                      SizedBox(width: 5,),
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Container(
                                            color: Colors.grey.shade900,
                                            child: SizedBox(width: 60, height: 26, child: dropdownVersion(context: context),),
                                          )
                                      ),

                                      // SizedBox(width: 5,),
                                      // SizedBox(height: 26, child: Icon(Icons.brightness_6, size: 20, color: Colors.white,),),
                                      //
                                      // SizedBox(width: 5,),
                                      // SizedBox(height: 26, child: Icon(Icons.font_download, size: 20, color: Colors.white,),),
                                      if(controller.exibirPesquisa)
                                        SizedBox(width: 5,),
                                    ],
                                  )
                              ),
                            ],
                          ),

                          Positioned(
                              top: 5,
                              right: 10,
                              child: Observer(builder: (_)=>
                                  InkWell(
                                    onTap: (){
                                      controller.exibirPesquisa=!controller.exibirPesquisa;
                                      if(!controller.exibirPesquisa)
                                        controller.pesquisarNaBiblia = '';
                                    },
                                    child: Icon(!controller.exibirPesquisa ? Icons.search_rounded : Icons.search_off_outlined, size: 30, color: !controller.exibirPesquisa ? Colors.grey.shade600 : Colors.redAccent,),
                                  )
                              )
                          ),

                          if(controller.exibirPesquisa)
                            Positioned(
                              top: 3,
                              right: 50,
                              left: 50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                      color: Colors.grey.shade900.withOpacity(0.95),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade800
                                      ),
                                    ),
                                    height: 35,
                                    child: TextField(
                                        style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left: 0, bottom: 5, top: 3, right: 30),
                                          hintText: 'Pesquisar na Bíblia',
                                          hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            size: 20,
                                            color: Theme.of(context).colorScheme.secondary,
                                          ),
                                        ),
                                        maxLines: 1,
                                        onChanged: (value) => controller.onKeyBoard(value: value)
                                    ),
                                  )
                              ),
                            ),


                          Positioned(
                              top: 14,
                              right: 65,
                              child: Observer(builder: (_)=>!controller.loading ? SizedBox() : SizedBox(width:12, height:12, child: CircularProgressIndicator(strokeWidth: 2),),)
                          ),

                        ],
                      )
                  ),
                  backgroundColor: Colors.black54,
                  elevation: 0.0,
                  toolbarHeight: 100,
                  centerTitle: true,
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
                                    onTap: controller.pesquisarNaBiblia.isEmpty ? null : (){
                                      controller.versao = controller.getVersiculosExibirLeitura[index]['versao'];
                                      controller.livroSelecionado = controller.getVersiculosExibirLeitura[index]['abrev'];
                                      controller.nomeLivroSelecionado = controller.getVersiculosExibirLeitura[index]['nome'];
                                      controller.capituloSelecionado = controller.getVersiculosExibirLeitura[index]['capitulo'];
                                      controller.versiculoSelecionado = controller.getVersiculosExibirLeitura[index]['versiculo'];
                                      controller.pesquisarNaBiblia='';
                                      controller.exibirPesquisa = false;
                                      pausarAcaoListennerScroll=true;
                                      moveScroll();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
                                        child: Row(
                                          children: [
                                            if(controller.pesquisarNaBiblia.isEmpty)
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${index+1} ${controller.getVersiculosExibirLeitura[index]['versiculotext']}',
                                                  style: TextStyle(color: fonteColor, fontSize: fontSize+3),
                                                ),
                                              ),

                                            if(controller.pesquisarNaBiblia.isNotEmpty)
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${controller.getVersiculosExibirLeitura[index]['versiculotext']}',
                                                        style: TextStyle(color: fonteColor, fontSize: fontSize+3),
                                                      ),
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        '${controller.getVersiculosExibirLeitura[index]['nome']}'
                                                            ' (${controller.getVersiculosExibirLeitura[index]['abrev'].toString().toUpperCase()})'
                                                            ' - ${controller.getVersiculosExibirLeitura[index]['capitulo']}'
                                                            ': ${controller.getVersiculosExibirLeitura[index]['versiculo']}'
                                                            ' ${controller.getVersiculosExibirLeitura[index]['versao'].toString().toUpperCase()}'
                                                        ,
                                                        style: TextStyle(color: Colors.grey.shade600, fontSize: fontSize-1),
                                                      ),
                                                    ],
                                                  )
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
              ),

              if(controller.exibirBotaoAvancarCapitulo)
                Positioned(
                  right: 10,
                  bottom: 5,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: IconButton(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        iconSize: 25,
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          controller.setAvancarCapitulo();
                          pausarAcaoListennerScroll = true;
                          moveScroll();
                        },
                      ),
                    ),
                  )
                ),

              if(controller.exibirBotaoVoltarCapitulo)
                Positioned(
                  left: 10,
                  bottom: 5,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: IconButton(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        iconSize: 25,
                        icon: Icon(Icons.arrow_back),
                        onPressed: (){
                          controller.setVoltarCapitulo();
                          pausarAcaoListennerScroll = true;
                          moveScroll();
                        },
                      ),
                    ),
                  )
                ),

            ],
          ),
      )
    );
  }
}
