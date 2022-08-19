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
  String livroSelecionado = '';
  @observable
  String nomeLivroSelecionado = '';
  @observable
  int capituloSelecionado = 0;
  @observable
  int versiculoSelecionado = 0;
  @observable
  String pesquisar='';

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
    List<Map> itens =[];
    for (var element in bible) {
      if(pesquisar.isEmpty)
        itens.add({'abrev': element['abbrev'], 'nome': element['name']});
      else
        if(element['abbrev'].toString().toLowerCase().contains(pesquisar.toLowerCase()) || element['name'].toString().toLowerCase().contains(pesquisar.toLowerCase()))
          itens.add({'abrev': element['abbrev'], 'nome': element['name']});
    }
    return itens;
  }

  @computed
  List get getCapitulos{
    List itens =[];
    for (var element in bible) {
      if( element['abbrev'] == livroSelecionado ){
        Object? obj = element['chapters'];
        List capitulos = jsonDecode(jsonEncode(obj));
        int count = 1;
        for(var versiculos in capitulos){
          itens.add(count);
          count++;
        }
        return itens;
      }
    }
    return itens;
  }

  @computed
  List get getVersiculos{
    List itens =[];
    for (var element in bible) {
      if( element['abbrev'] == livroSelecionado ){
        Object? obj = element['chapters'];
        List capitulos = jsonDecode(jsonEncode(obj));
        int count = 1;
        for(var versiculos in capitulos[capituloSelecionado-1]){
          itens.add(count);
          count++;
        }
        return itens;
      }
    }
    return itens;
  }

  @computed
  List get getVersiculosExibirLeitura{
    List<String> vers=[];
    for (var element in bible) {
      if( element['abbrev'] == livroSelecionado ){
        Object? obj = element['chapters'];
        List capitulos = jsonDecode(jsonEncode(obj));
        for(var versiculos in capitulos[capituloSelecionado-1]){
          vers.add(versiculos);
        }
        return vers;
      }
    }
    return vers;
  }


}