// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:biblia_sagrada/home/home.selecionar.livro.page.dart';
import 'package:biblia_sagrada/home/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  late BannerAd banner1;

  @override
  void initState() {
    addListenerScroll();
    moveScroll();
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    banner1 = getBanner300x50;
    banner1.load();
  }

  @override
  void dispose(){
    super.dispose();
    banner1.dispose();
  }

  int positionScroll=0;
  int oldPositionScroll = 0;
  addListenerScroll(){
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();

    itemPositionsListener.itemPositions.addListener((){
      oldPositionScroll = positionScroll;

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
          positionScroll = min;
          controleToolbarHeight();
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


  controleToolbarHeight() async{
    if(positionScroll > oldPositionScroll) {
      if(controller.toolbarHeight==100)
        for (int i = 100; i >= 0; i--) {
          await Future.delayed(Duration(microseconds: 900));
          controller.toolbarHeight = i.toDouble();
        }
    } else if(positionScroll < oldPositionScroll) {
      if(controller.toolbarHeight==0)
        for (int i = 0; i <= 100; i++) {
          await Future.delayed(Duration(microseconds: 1000));
          controller.toolbarHeight = i.toDouble();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: controller.backgroundColor,
      child: Observer(builder: (_)=>
          Stack(
            children: [
              Scaffold(
                backgroundColor: controller.backgroundColor,
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
                                  Text('Bíblia Sagrada', style: TextStyle(color: controller.fonteColor, fontSize: 20),),
                                  SizedBox(height: 1,),
                                  Text('${controller.getNomeVersao} (${controller.versao.toUpperCase()})', style: TextStyle(color: controller.backgroundColor == Colors.white ? Colors.grey.shade600 : Colors.grey.shade300, fontSize: 14),),
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
                                                color: controller.backgroundColor == Colors.white ? Colors.grey.shade400 : Colors.grey.shade800,
                                                //height: 26,
                                                padding: EdgeInsets.only(left: 10, right: 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text('${controller.nomeLivroSelecionado} ${controller.capituloSelecionado}',
                                                      style: TextStyle(color: controller.fonteColor, fontSize: 17),
                                                    ),
                                                    SizedBox(width: 2,),
                                                    Text(': ${controller.versiculoSelecionado}',
                                                      style: TextStyle(color: controller.fonteColor, fontSize: 17),),
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
                                            color: controller.backgroundColor == Colors.white ? Colors.grey.shade400 : Colors.grey.shade800,
                                            child: SizedBox(width: 70, height: 25, child: dropdownVersion(context: context),),
                                          )
                                      ),

                                      SizedBox(width: 5,),
                                      InkWell(
                                        onTap: (){
                                          setState((){
                                            if( controller.backgroundColor == Colors.white ) {
                                              controller.backgroundColor = Colors.black87;
                                              controller.fonteColor = Colors.white;
                                            }else {
                                              controller.backgroundColor = Colors.white;
                                              controller.fonteColor = Colors.black;
                                            }
                                          });
                                        },
                                        child: SizedBox(height: 26, child: Icon(Icons.brightness_6, size: 20, color: controller.backgroundColor == Colors.white ? Colors.grey.shade500 : Colors.white),),
                                      ),

                                      SizedBox(width: 5,),
                                      InkWell(
                                        onTap: (){
                                          setState((){
                                            if(controller.fontSize==30)
                                              controller.fontSize = 22;
                                            else
                                              controller.fontSize++;
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            SizedBox(height: 26, child: Icon(Icons.font_download, size: 20, color: controller.backgroundColor == Colors.white ? Colors.grey.shade500 : Colors.white,),),
                                            if(controller.fontSize.floor()>22)
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: ClipOval(
                                                child: Container(
                                                  width: 15,
                                                  height: 15,
                                                  color: Theme.of(context).primaryColor,
                                                  alignment: Alignment.center,
                                                  child: Text('+${controller.fontSize.floor()}', style: TextStyle(fontSize: 7.5),),
                                                ),
                                              )
                                            )
                                          ],
                                        )
                                      ),
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
                  backgroundColor: controller.backgroundColor,
                  elevation: 0.0,
                  toolbarHeight: controller.toolbarHeight,
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
                                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 10),
                                        margin: EdgeInsets.only(bottom: controller.getVersiculosExibirLeitura.length-1 == index ? 100.0 : 0.0),
                                        child: Row(
                                          children: [

                                            if(controller.pesquisarNaBiblia.isEmpty)
                                              Expanded(
                                                flex: 2,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      top: 5,
                                                      child: Text(
                                                        '${index+1}',
                                                        style: TextStyle(color: controller.fonteColor.withOpacity(0.6), fontSize: controller.fontSize, height: 1.8),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${index<9?'   ': index<99?'     ': '      '}${controller.getVersiculosExibirLeitura[index]['versiculotext']}',
                                                      style: TextStyle(color: controller.fonteColor, fontSize: controller.fontSize+3, height: 1.8),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ],
                                                )
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
                                                        style: TextStyle(color: controller.fonteColor, fontSize: controller.fontSize+3),
                                                      ),
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        '${controller.getVersiculosExibirLeitura[index]['nome']}'
                                                            ' (${controller.getVersiculosExibirLeitura[index]['abrev'].toString().toUpperCase()})'
                                                            ' - ${controller.getVersiculosExibirLeitura[index]['capitulo']}'
                                                            ': ${controller.getVersiculosExibirLeitura[index]['versiculo']}'
                                                            ' ${controller.getVersiculosExibirLeitura[index]['versao'].toString().toUpperCase()}'
                                                        ,
                                                        style: TextStyle(color: Colors.grey.shade600, fontSize: controller.fontSize-1),
                                                      ),
                                                    ],
                                                  )
                                              ),

                                          ],
                                        )
                                    ),
                                  )
                          ),
                        ),

                        Container(
                          color: Colors.transparent,
                          height: 53,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 3),
                          child: AdWidget(ad: banner1),
                        )
                      ],
                    )
                ),
              ),

              if(controller.exibirBotaoAvancarCapitulo)
                Positioned(
                  right: 5,
                  bottom: 2,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: IconButton(
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                        iconSize: 30,
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
                  left: 5,
                  bottom: 2,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: IconButton(
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                        iconSize: 30,
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
