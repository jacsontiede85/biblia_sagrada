// ignore_for_file: prefer_const_constructors

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class Widgets{
  Widget dropdownVersion({required BuildContext context, bool? exibirDesc}){
      final controller = GetIt.I.get<Controller>();
      return Observer(builder: (_)=>
          DropdownButton<String>(
              value: controller.versao,
              icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.white,),
              isExpanded: true,
              iconSize: 25,
              elevation: 16,
              focusColor: Colors.transparent,
              dropdownColor: Theme.of(context).colorScheme.secondary,
              style: TextStyle(color: controller.fonteColor),
              underline: Container(height: 0, color: Theme.of(context).colorScheme.secondary,),
              onChanged: (String? value) async {
                controller.versao = value??'nvi';
                controller.getBible;
                int temp = controller.capituloSelecionado;
                controller.capituloSelecionado=0;
                controller.capituloSelecionado=temp;
              },
              items: controller.versions.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                    value: value['abrev'],
                    child: Padding(
                        padding: EdgeInsets.only(left: 0, top: 3, bottom: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '${value['abrev']}'.toUpperCase(),
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                              ),
                            ),),
                          ],
                        )
                    )
                );
              }).toList())
      );
    }
}