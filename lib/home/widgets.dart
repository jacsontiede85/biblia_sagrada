// ignore_for_file: prefer_const_constructors

import 'package:biblia_sagrada/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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

  //banner 300 x 50
  BannerAd get getBanner300x50 => BannerAd(
    adUnitId: 'ca-app-pub-3923445449692502/5218720788',
    // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
      },
    ),
  );
}