// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:biblia_sagrada/home/home.leitura.page.dart';
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
    controller.getBible;
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
        title: Text('Bíblia Sagrada', style: TextStyle(color: fonteColor, fontSize: fontSize+2),),
        backgroundColor: Colors.black54,
        elevation: 0.0,
        toolbarHeight: 30,
        bottom: TabBar(
          controller: tabController,
          padding: EdgeInsets.only(bottom: 0),
          labelPadding: EdgeInsets.only(bottom: 7),
          tabs: [
            Text('Livro', style: TextStyle(color: fonteColor, fontSize: fontSize),),
            Text('Capítulo', style: TextStyle(color: fonteColor, fontSize: fontSize),),
            Text('Versículo', style: TextStyle(color: fonteColor, fontSize: fontSize),),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [

          //SELEÇÃO DE LIVROS
          Observer(builder: (_)=>
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.grey.shade900,
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade600
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
                                  hintText: 'Pesquisar livro',
                                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 20,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                maxLines: 1,
                                onChanged: (value) => controller.pesquisar = value
                            ),
                          )
                      ),
                      Flexible(
                        child: ListView.builder(
                            itemCount: controller.getLivros.length,
                            itemBuilder: (context, index) =>
                                InkWell(
                                  onTap: (){
                                    controller.livroSelecionado = '${controller.getLivros[index]['abrev']}';
                                    controller.capituloSelecionado = 1;
                                    controller.versiculoSelecionado = 0;
                                    controller.nomeLivroSelecionado = '${controller.getLivros[index]['nome']}';
                                    tabController.animateTo(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
                                      decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey.shade900, width: 0.5, ),),
                                        color: controller.livroSelecionado == '${controller.getLivros[index]['abrev']}' ? Colors.grey.shade800 : Colors.transparent,
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
                                )
                        ),
                      )
                    ],
                  )
              )
          ),


          //SELEÇÃO DE CAPITULOS
          Observer(builder: (_)=>
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: controller.getCapitulos.map((value) =>
                        InkWell(
                          onTap: (){
                            controller.capituloSelecionado = int.parse(value.toString());
                            tabController.animateTo(2, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  color: controller.capituloSelecionado == int.parse(value.toString()) ? Colors.grey.shade800 : Colors.transparent,
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade800
                                  ),
                                ),
                                width: 60,
                                height: 60,
                                child: Text(
                                  '$value'.toUpperCase(),
                                  style: TextStyle(color: fonteColor, fontSize: fontSize-2),
                                ),
                              )
                          ),
                        )
                    ).toList(),
                  ),
                ),
              )
          ),


          //SELEÇÃO DE VERSICULOS
          Observer(builder: (_)=>
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: controller.getVersiculos.map((value) =>
                        InkWell(
                          onTap: (){
                            controller.versiculoSelecionado = int.parse(value.toString());
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LeituraPage()));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  color: controller.versiculoSelecionado == int.parse(value.toString()) ? Colors.grey.shade800 : Colors.transparent,
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade800
                                  ),
                                ),
                                width: 60,
                                height: 60,
                                child: Text(
                                  '$value'.toUpperCase(),
                                  style: TextStyle(color: fonteColor, fontSize: fontSize-2),
                                ),
                              )
                          ),
                        )
                    ).toList(),
                  ),
                )
              )
          ),

        ],
      )
    );
  }
}
