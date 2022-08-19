// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on ControllerBase, Store {
  Computed<bool>? _$getBibleComputed;

  @override
  bool get getBible => (_$getBibleComputed ??=
          Computed<bool>(() => super.getBible, name: 'ControllerBase.getBible'))
      .value;
  Computed<List<dynamic>>? _$getLivrosComputed;

  @override
  List<dynamic> get getLivros =>
      (_$getLivrosComputed ??= Computed<List<dynamic>>(() => super.getLivros,
              name: 'ControllerBase.getLivros'))
          .value;

  late final _$versaoAtom =
      Atom(name: 'ControllerBase.versao', context: context);

  @override
  String get versao {
    _$versaoAtom.reportRead();
    return super.versao;
  }

  @override
  set versao(String value) {
    _$versaoAtom.reportWrite(value, super.versao, () {
      super.versao = value;
    });
  }

  late final _$livroAtom = Atom(name: 'ControllerBase.livro', context: context);

  @override
  String get livro {
    _$livroAtom.reportRead();
    return super.livro;
  }

  @override
  set livro(String value) {
    _$livroAtom.reportWrite(value, super.livro, () {
      super.livro = value;
    });
  }

  late final _$capituloAtom =
      Atom(name: 'ControllerBase.capitulo', context: context);

  @override
  int get capitulo {
    _$capituloAtom.reportRead();
    return super.capitulo;
  }

  @override
  set capitulo(int value) {
    _$capituloAtom.reportWrite(value, super.capitulo, () {
      super.capitulo = value;
    });
  }

  late final _$versiculoAtom =
      Atom(name: 'ControllerBase.versiculo', context: context);

  @override
  int get versiculo {
    _$versiculoAtom.reportRead();
    return super.versiculo;
  }

  @override
  set versiculo(int value) {
    _$versiculoAtom.reportWrite(value, super.versiculo, () {
      super.versiculo = value;
    });
  }

  @override
  String toString() {
    return '''
versao: ${versao},
livro: ${livro},
capitulo: ${capitulo},
versiculo: ${versiculo},
getBible: ${getBible},
getLivros: ${getLivros}
    ''';
  }
}
