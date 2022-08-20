// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on ControllerBase, Store {
  Computed<String>? _$getNomeVersaoComputed;

  @override
  String get getNomeVersao =>
      (_$getNomeVersaoComputed ??= Computed<String>(() => super.getNomeVersao,
              name: 'ControllerBase.getNomeVersao'))
          .value;
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
  Computed<List<dynamic>>? _$getCapitulosComputed;

  @override
  List<dynamic> get getCapitulos => (_$getCapitulosComputed ??=
          Computed<List<dynamic>>(() => super.getCapitulos,
              name: 'ControllerBase.getCapitulos'))
      .value;
  Computed<List<dynamic>>? _$getVersiculosComputed;

  @override
  List<dynamic> get getVersiculos => (_$getVersiculosComputed ??=
          Computed<List<dynamic>>(() => super.getVersiculos,
              name: 'ControllerBase.getVersiculos'))
      .value;
  Computed<bool>? _$exibirBotaoAvancarCapituloComputed;

  @override
  bool get exibirBotaoAvancarCapitulo =>
      (_$exibirBotaoAvancarCapituloComputed ??= Computed<bool>(
              () => super.exibirBotaoAvancarCapitulo,
              name: 'ControllerBase.exibirBotaoAvancarCapitulo'))
          .value;
  Computed<bool>? _$exibirBotaoVoltarCapituloComputed;

  @override
  bool get exibirBotaoVoltarCapitulo => (_$exibirBotaoVoltarCapituloComputed ??=
          Computed<bool>(() => super.exibirBotaoVoltarCapitulo,
              name: 'ControllerBase.exibirBotaoVoltarCapitulo'))
      .value;
  Computed<List<dynamic>>? _$getVersiculosExibirLeituraComputed;

  @override
  List<dynamic> get getVersiculosExibirLeitura =>
      (_$getVersiculosExibirLeituraComputed ??= Computed<List<dynamic>>(
              () => super.getVersiculosExibirLeitura,
              name: 'ControllerBase.getVersiculosExibirLeitura'))
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

  late final _$livroSelecionadoAtom =
      Atom(name: 'ControllerBase.livroSelecionado', context: context);

  @override
  String get livroSelecionado {
    _$livroSelecionadoAtom.reportRead();
    return super.livroSelecionado;
  }

  @override
  set livroSelecionado(String value) {
    _$livroSelecionadoAtom.reportWrite(value, super.livroSelecionado, () {
      super.livroSelecionado = value;
    });
  }

  late final _$nomeLivroSelecionadoAtom =
      Atom(name: 'ControllerBase.nomeLivroSelecionado', context: context);

  @override
  String get nomeLivroSelecionado {
    _$nomeLivroSelecionadoAtom.reportRead();
    return super.nomeLivroSelecionado;
  }

  @override
  set nomeLivroSelecionado(String value) {
    _$nomeLivroSelecionadoAtom.reportWrite(value, super.nomeLivroSelecionado,
        () {
      super.nomeLivroSelecionado = value;
    });
  }

  late final _$capituloSelecionadoAtom =
      Atom(name: 'ControllerBase.capituloSelecionado', context: context);

  @override
  int get capituloSelecionado {
    _$capituloSelecionadoAtom.reportRead();
    return super.capituloSelecionado;
  }

  @override
  set capituloSelecionado(int value) {
    _$capituloSelecionadoAtom.reportWrite(value, super.capituloSelecionado, () {
      super.capituloSelecionado = value;
    });
  }

  late final _$versiculoSelecionadoAtom =
      Atom(name: 'ControllerBase.versiculoSelecionado', context: context);

  @override
  int get versiculoSelecionado {
    _$versiculoSelecionadoAtom.reportRead();
    return super.versiculoSelecionado;
  }

  @override
  set versiculoSelecionado(int value) {
    _$versiculoSelecionadoAtom.reportWrite(value, super.versiculoSelecionado,
        () {
      super.versiculoSelecionado = value;
    });
  }

  late final _$pesquisarAtom =
      Atom(name: 'ControllerBase.pesquisar', context: context);

  @override
  String get pesquisar {
    _$pesquisarAtom.reportRead();
    return super.pesquisar;
  }

  @override
  set pesquisar(String value) {
    _$pesquisarAtom.reportWrite(value, super.pesquisar, () {
      super.pesquisar = value;
    });
  }

  late final _$pesquisarNaBibliaAtom =
      Atom(name: 'ControllerBase.pesquisarNaBiblia', context: context);

  @override
  String get pesquisarNaBiblia {
    _$pesquisarNaBibliaAtom.reportRead();
    return super.pesquisarNaBiblia;
  }

  @override
  set pesquisarNaBiblia(String value) {
    _$pesquisarNaBibliaAtom.reportWrite(value, super.pesquisarNaBiblia, () {
      super.pesquisarNaBiblia = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'ControllerBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$exibirPesquisaAtom =
      Atom(name: 'ControllerBase.exibirPesquisa', context: context);

  @override
  bool get exibirPesquisa {
    _$exibirPesquisaAtom.reportRead();
    return super.exibirPesquisa;
  }

  @override
  set exibirPesquisa(bool value) {
    _$exibirPesquisaAtom.reportWrite(value, super.exibirPesquisa, () {
      super.exibirPesquisa = value;
    });
  }

  late final _$onKeyBoardAsyncAction =
      AsyncAction('ControllerBase.onKeyBoard', context: context);

  @override
  Future onKeyBoard({required String value}) {
    return _$onKeyBoardAsyncAction.run(() => super.onKeyBoard(value: value));
  }

  late final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase', context: context);

  @override
  dynamic setAvancarCapitulo() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setAvancarCapitulo');
    try {
      return super.setAvancarCapitulo();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setVoltarCapitulo() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setVoltarCapitulo');
    try {
      return super.setVoltarCapitulo();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
versao: ${versao},
livroSelecionado: ${livroSelecionado},
nomeLivroSelecionado: ${nomeLivroSelecionado},
capituloSelecionado: ${capituloSelecionado},
versiculoSelecionado: ${versiculoSelecionado},
pesquisar: ${pesquisar},
pesquisarNaBiblia: ${pesquisarNaBiblia},
loading: ${loading},
exibirPesquisa: ${exibirPesquisa},
getNomeVersao: ${getNomeVersao},
getBible: ${getBible},
getLivros: ${getLivros},
getCapitulos: ${getCapitulos},
getVersiculos: ${getVersiculos},
exibirBotaoAvancarCapitulo: ${exibirBotaoAvancarCapitulo},
exibirBotaoVoltarCapitulo: ${exibirBotaoVoltarCapitulo},
getVersiculosExibirLeitura: ${getVersiculosExibirLeitura}
    ''';
  }
}
