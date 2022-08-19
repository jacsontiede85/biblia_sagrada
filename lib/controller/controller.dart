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

  @observable
  String versao = 'nvi';
  @observable
  String livro = 'gn';
  @observable
  int capitulo = 1;
  @observable
  int versiculo = 1;

  List bible = [];

  @computed
  bool get getBible{
    if(versao=='nvi')
      bible = VersionNvi().bible;
    else if(versao=='acf')
      bible = VersionAcf().bible;
    else
      bible = VersionAa().bible;
    return true;
  }

  @computed
  List get getLivros{
    getBible;
    List<Map> itens =[];
    for (var element in bible) {
      print(element['abbrev']);
      itens.add({'abrev': element['abbrev'], 'nome': element['name']});
    }
    return itens;
  }

  getVersiculos({required String livro, required int capitulo, int? versiculo}) {
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

  getCapitulos({required String livro}) {
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

  getNumVersiculos({required String livro, required int capitulo}) {
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