// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:biblia_sagrada/home/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeSelecionarLivroPage extends StatefulWidget {
  const HomeSelecionarLivroPage({Key? key}) : super(key: key);

  @override
  State<HomeSelecionarLivroPage> createState() => _HomeSelecionarLivroPageState();
}

class _HomeSelecionarLivroPageState extends State<HomeSelecionarLivroPage> with TickerProviderStateMixin, Widgets{

  final controller = GetIt.I.get<Controller>();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this );
    controller.pesquisar='';
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
      backgroundColor: controller.backgroundColor,
      appBar: AppBar(
        title: Observer(builder: (_)=>
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bíblia Sagrada', style: TextStyle(color: controller.fonteColor, fontSize: 20),),
                Text('${controller.getNomeVersao} (${controller.versao.toUpperCase()})', style: TextStyle(color: controller.backgroundColor == Colors.white ? Colors.grey.shade500 : Colors.grey.shade300, fontSize: 15),),
              ],
            ),
        ),
        iconTheme: IconThemeData(color: controller.backgroundColor == Colors.white ? Theme.of(context).primaryColor : Colors.white),
        backgroundColor: controller.backgroundColor,
        elevation: 0.0,
        toolbarHeight: 50,
        bottom: TabBar(
          controller: tabController,
          padding: EdgeInsets.only(bottom: 0),
          labelPadding: EdgeInsets.only(bottom: 7),
          tabs: [
            Text('Livro', style: TextStyle(color: controller.fonteColor, fontSize: 20),),
            Text('Capítulo', style: TextStyle(color: controller.fonteColor, fontSize: 20),),
            Text('Versículo', style: TextStyle(color: controller.fonteColor, fontSize: 20),),
          ],
        ),
        actions: [
          SizedBox(width: 60, child: dropdownVersion(context: context),)
        ],
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
                              color: controller.backgroundColor==Colors.white ? Colors.grey.shade200 : Colors.black87,
                              border: Border.all(
                                  width: 1,
                                  color: controller.backgroundColor==Colors.white ? Colors.grey.shade300 : Colors.grey.shade600,
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
                                    controller.nomeLivroSelecionado = controller.nomeLivroSelecionado.length>15? '${controller.nomeLivroSelecionado.substring(0,12)}...' : controller.nomeLivroSelecionado;
                                    tabController.animateTo(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
                                      decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: controller.backgroundColor==Colors.white ? Colors.grey.shade400 : Colors.grey.shade900, width: 0.5, ),),
                                        color: controller.livroSelecionado == '${controller.getLivros[index]['abrev']}' ? controller.backgroundColor==Colors.white ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.grey.shade800 : Colors.transparent,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${controller.getLivros[index]['abrev']}'.toUpperCase(),
                                              style: TextStyle(color: controller.fonteColor, fontSize: controller.fontSize-2),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              '${controller.getLivros[index]['nome']}',
                                              style: TextStyle(color: controller.fonteColor, fontSize: controller.fontSize),
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
                                  style: TextStyle(color: controller.fonteColor, fontSize: controller.fontSize-2),
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
                            Navigator.of(context).pop();
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
                                  style: TextStyle(color: controller.fonteColor, fontSize: controller.fontSize-2),
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
