// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:biblia_sagrada/versoes/nvi.dart';

class Controller{

  getVersiculos({required String livro, required int capitulo, int? versiculo}) {
    for (var element in VersionNvi().bible) {
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

  getLivros() {
    for (var element in VersionNvi().bible) {
      print('${element['abbrev'].toString().toUpperCase()} - ${element['name']}');
    }
  }

  getCapitulos({required String livro}) {
    for (var element in VersionNvi().bible) {
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
    for (var element in VersionNvi().bible) {
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