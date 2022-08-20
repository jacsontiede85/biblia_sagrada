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
  ControllerBase(){
    getBible;
  }
  @observable
  String versao = 'nvi';
  @observable
  String livroSelecionado = 'gn';
  @observable
  String nomeLivroSelecionado = 'Gênesis';
  @observable
  int capituloSelecionado = 1;
  @observable
  int versiculoSelecionado = 1;
  @observable
  String pesquisar='';
  @observable
  String pesquisarNaBiblia='';

  List bible = [];

  List<Map> versions = [
    {'abrev': 'nvi', 'nome': 'Nova Versão Internacional'},
    {'abrev': 'acf', 'nome': 'Almeida Corrigida e Fiel'},
    {'abrev': 'aa' , 'nome': 'Almeida Revisada Imprensa Bíblica'}
  ];

  @computed
  String get getNomeVersao{
    String temp='';
    for (var element in versions) {
      if(element['abrev']==versao)
        temp = element['nome'];
    }
    return temp;
  }

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
        if(element['abbrev'].toString().toLowerCase().contains(pesquisar.toLowerCase()) || element['name'].toString().toLowerCase().contains(pesquisar.toLowerCase())  || removerAcentos(element['name'].toString()).toLowerCase().contains(pesquisar.toLowerCase()))
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
          '$versiculos';
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
          '$versiculos';
          count++;
        }
        return itens;
      }
    }
    return itens;
  }


  //variavel para monitorar digitação da busca geral, permitir buscar somente após final digitação do usuário.
  //isso eliminará buscas desnecessárias durante digitação
  @observable
  bool loading = false;
  @observable
  bool exibirPesquisa = false;
  int qtteclasdigitadas=0;
  @action
  onKeyBoard({required String value}) async{
    loading = true;
    qtteclasdigitadas = value.length;
    await Future.delayed(const Duration(milliseconds: 1000));
    pesquisarNaBiblia = value;
    if(qtteclasdigitadas == pesquisarNaBiblia.length)
      loading = false;
  }

  @computed
  List get getVersiculosExibirLeitura{
    List<Map> vers=[];
    if( pesquisarNaBiblia.isEmpty ){
      for (var element in bible) {
        if( element['abbrev'] == livroSelecionado ){
          Object? obj = element['chapters'];
          List capitulos = jsonDecode(jsonEncode(obj));
          int count =1;
          for(var versiculos in capitulos[capituloSelecionado-1]) {
            vers.add({
              'abrev': element['abbrev'],
              'nome': element['name'],
              'capitulo': capituloSelecionado,
              'versiculo': count,
              'versiculotext': versiculos,
              'versao': versao
            });
            count++;
          }
          return vers;
        }
      }

    } else {
      if(qtteclasdigitadas==pesquisarNaBiblia.length && !loading)
        for (var element in bible) {
          Object? obj = element['chapters'];
          List capitulos = jsonDecode(jsonEncode(obj));

          for( int i=0; i<capitulos.length; i++) {
            // print('${element['name']}  ${capitulos.length}   $i');
            int count = 0;
            for (var versiculos in capitulos[i]) {
              if (removerAcentos(versiculos.toString().toLowerCase()).contains(pesquisarNaBiblia.toLowerCase())) {
                vers.add({
                  'abrev': element['abbrev'],
                  'nome': element['name'],
                  'capitulo': i + 1,
                  'versiculo': count,
                  'versiculotext': versiculos,
                  'versao': versao
                });
              }
              count++;
            }
          }
      }
      return vers;
    }
    return vers;
  }


  String removerAcentos(String str) {
    if(str.isEmpty)
      return '';
    var comAcento = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž()[]"\'!@#\$%&*+={}ªº,.;?/°|\\';
    var semAcento = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz()[]"\'!@#\$%&*+={}ªº,.;?/°|\\';
    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }
    return str;
  }
}