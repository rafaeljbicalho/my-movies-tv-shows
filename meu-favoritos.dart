/*
  App simples para adicionar filmes/séries assistidos/favoritos.
  Referências:
  - https://github.com/eduardo-ono/desenvolvimento-mobile
*/

import 'package:flutter/material.dart';

class FilmeSerie {
  // Atributos
  String _nome;
  String _nomeDiretor;
  int _anoLancamento;
  int _nota = 0;

  // Construtor
  FilmeSerie(this._nome, this._nomeDiretor, this._anoLancamento, this._nota) {
    this._nome = _nome;
    this._nomeDiretor = _nomeDiretor;
    this._anoLancamento = _anoLancamento;
    this._nota = _nota;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<FilmeSerie> lista = []; // Lista vazia

  // Construtor
  MyApp() {
    FilmeSerie filmeSerie1 = FilmeSerie("The office", "Greg Daniels", 2005, 10);
    FilmeSerie filmeSerie2 =
        FilmeSerie("Friends", "David Crane & Marta Kauffman", 1994, 10);
    FilmeSerie filmeSerie3 =
        FilmeSerie("Rocky I", "John G. Avildsen", 1976, 10);
    FilmeSerie filmeSerie4 =
        FilmeSerie("Em busca da felicidade", "Gabriele Muccino", 2007, 9);
    FilmeSerie filmeSerie5 =
        FilmeSerie("Seinfeld", "Jerry Seinfeld & Larry David", 1989, 10);
    lista.add(filmeSerie1);
    lista.add(filmeSerie2);
    lista.add(filmeSerie3);
    lista.add(filmeSerie4);
    lista.add(filmeSerie5);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App para adicionar filmes/séries",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<FilmeSerie> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<FilmeSerie> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Meus filmes e séries (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.personal_video_sharp),
            title: Text(
              "Minha lista de filmes/séries",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoPaciente(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search_rounded),
            title: Text(
              "Buscar por um filme/série",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaBuscarPorPaciente(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.my_library_add),
            title: Text(
              "Cadastrar um novo filme/série",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarPaciente(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                "Sobre o app",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sobre(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Tela Informações de filmes e séries
//-----------------------------------------------------------------------------

class TelaInformacoesDoPaciente extends StatefulWidget {
  final List<FilmeSerie> lista;

  // Construtor
  TelaInformacoesDoPaciente(this.lista);

  @override
  _TelaInformacoesDoPaciente createState() => _TelaInformacoesDoPaciente(lista);
}

class _TelaInformacoesDoPaciente extends State<TelaInformacoesDoPaciente> {
  // Atributos
  final List lista;
  FilmeSerie filmeSerie;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final nomeDiretorController = TextEditingController();
  final anoLancamentoController = TextEditingController();
  final notaController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesDoPaciente(this.lista) {
    if (lista.length > 0) {
      index = 0;
      filmeSerie = lista[0];
      nomeController.text = filmeSerie._nome;
      nomeDiretorController.text = filmeSerie._nomeDiretor;
      anoLancamentoController.text = filmeSerie._anoLancamento.toString();
      notaController.text = filmeSerie._nota.toString();
    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      filmeSerie = lista[index];
      nomeController.text = filmeSerie._nome;
      nomeController.text = filmeSerie._nome;
      nomeDiretorController.text = filmeSerie._nomeDiretor;
      anoLancamentoController.text = filmeSerie._anoLancamento.toString();
      notaController.text = filmeSerie._nota.toString();
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._nomeDiretor = nomeDiretorController.text;
      lista[index]._anoLancamento = int.parse(anoLancamentoController.text);
      lista[index]._nota = int.parse(notaController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Paciente";
    if (filmeSerie == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum paciente encontrado!"),
            Container(
              color: Colors.blueGrey,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Hab. Edição"),
              ),
            ),
            // Nome Filme/Série
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome filme/série",
                  // hintText: "Nome do paciente",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // Nome Diretor
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome diretor/produtor",
                  // hintText: 'Peso do paciente (kg)',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeDiretorController,
              ),
            ),
            // Ano lançamento
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ano de lançamento",
                  hintText: "Ex: 1991",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: anoLancamentoController,
              ),
            ),
            // Nota
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sua nota do filme/série",
                  hintText: "De 0 a 10",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: notaController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Tela: Sobre
// ----------------------------------------------------------------------------

class Sobre extends StatefulWidget {
  @override
  _Sobre createState() => _Sobre();
}

class _Sobre extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sobre o app")),
      body: Center(
        child: Text(
            'O app tem como objetivo permitir que o usuário adicione sua lista de filmes/séries preferidos. Adicionando nome, diretor/produtor, ano de lançamento e sua nota. Desenvolvido por: Rafael Bicalho, RA: 130003352'),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Tela: Buscar por filme/séire (Em construção)
// ----------------------------------------------------------------------------

class TelaBuscarPorPaciente extends StatefulWidget {
  @override
  _TelaBuscarPorPacienteState createState() => _TelaBuscarPorPacienteState();
}

class _TelaBuscarPorPacienteState extends State<TelaBuscarPorPaciente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Opção em construção")),
    );
  }
}

// ----------------------------------------------------------------------------
// Tela: Cadastrar filme/série
// ----------------------------------------------------------------------------

class TelaCadastrarPaciente extends StatefulWidget {
  final List<FilmeSerie> lista;

  // Construtor
  TelaCadastrarPaciente(this.lista);

  @override
  _TelaCadastrarPacienteState createState() =>
      _TelaCadastrarPacienteState(lista);
}

class _TelaCadastrarPacienteState extends State<TelaCadastrarPaciente> {
  // Atributos
  final List<FilmeSerie> lista;
  String _nome = "";
  String _nomeDiretor = "";
  int _anoLancamento = 0;
  int _nota = 0;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final nomeDiretorController = TextEditingController();
  final anoLancamentoController = TextEditingController();
  final notaController = TextEditingController();

  // Construtor
  _TelaCadastrarPacienteState(this.lista);

  // Métodos
  void _cadastrarPaciente() {
    _nome = nomeController.text;
    _nomeDiretor = nomeDiretorController.text;
    _anoLancamento = int.parse(anoLancamentoController.text);
    _nota = int.parse(notaController.text);
    var paciente = FilmeSerie(
        _nome, _nomeDiretor, _anoLancamento, _nota); // Cria um novo objeto
    lista.add(paciente);
    nomeController.text = "";
    nomeDiretorController.text = "";
    anoLancamentoController.text = "";
    notaController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar filme/série"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Informações do filme/série:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            // Nome do filme/série
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do filme/série",
                  // hintText: "Nome do paciente",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // Nome diretor/produtor
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome diretor/produtor",
                  //hintText: 'Nome diretor',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeDiretorController,
              ),
            ),
            // Ano lançamento
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ano de lançamento",
                  hintText: "Ex: 1991",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: anoLancamentoController,
              ),
            ),
            // Nota
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Sua nota do filme/série",
                    hintText: "Nota de 0 a 10"),
                style: TextStyle(fontSize: _fontSize),
                controller: notaController,
              ),
            ),
            // Saída
            RaisedButton(
              child: Text(
                "Cadastrar",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarPaciente,
            ),
          ],
        ),
      ),
    );
  }
}
