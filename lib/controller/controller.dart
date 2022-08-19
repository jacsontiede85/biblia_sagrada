// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:biblia_sagrada/versoes/aa.dart';
import 'package:biblia_sagrada/versoes/acf.dart';
import 'package:biblia_sagrada/versoes/nvi.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

//flutter packages pub run build_runner watch --delete-conflicting-outputs

class Controller = ControllerBase with _$Controller;
abstract class ControllerBase with Store{

  getVersao({required String versao}){
    if(versao=='nvi')
      return VersionNvi().bible;
    else if(versao=='acf')
      return VersionAcf().bible;
    else
      return VersionAa().bible;
  }

  getVersiculos({required String versao, required String livro, required int capitulo, int? versiculo}) {
    List bible = getVersao(versao: versao);
    for (var element in bible) {
      if( element['abbrev'] == livro ){
        Object? obj = element['chapters'];
        List capitulos = jsonDecode(jsonEncode(obj));
        for(var versiculos in capitulos[capitulo-1]){
          print(versiculos);
        }
        return;
      }
    }
  }

  getLivros({required String versao}) {
    List bible = getVersao(versao: versao);
    for (var element in bible) {
      print('${element['abbrev'].toString().toUpperCase()} - ${element['name']}');
    }
  }

  getCapitulos({required String versao, required String livro}) {
    List bible = getVersao(versao: versao);
    for (var element in bible) {
      if( element['abbrev'] == livro ){
        Object? obj = element['chapters'];
        List capitulos = jsonDecode(jsonEncode(obj));
        int count = 1;
        for(var versiculos in capitulos){
          print(count);
          count++;
        }
        return;
      }
    }
  }

  getNumVersiculos({required String versao, required String livro, required int capitulo}) {
    List bible = getVersao(versao: versao);
    for (var element in bible) {
      if( element['abbrev'] == livro ){
        Object? obj = element['chapters'];
        List capitulos = jsonDecode(jsonEncode(obj));
        int count = 1;
        for(var versiculos in capitulos[capitulo-1]){
          print(count);
          count++;
        }
        return;
      }
    }
  }

}