import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _getGifs() async {
    http.Response response; //Declaramos a resposta
    String? _search; // Criei uma variavel de pequisa
    int _offSet = 0;

    if (_search == null) {
      // Fazendo a requisição padrão
      response = await http.get(Uri.parse(
          "https://tenor.googleapis.com/v2/search?q=excited&key=AIzaSyA41-KeNKvMHkTQ0pu_e8YA1hLmhJzb8NQ&client_key=AppGif&limit=20"));
    } else {
      //Fazendo a requisição com  base na variavel search
      response = await http.get(Uri.parse(
          "https://tenor.googleapis.com/v2/search?q=$_search&key=AIzaSyA41-KeNKvMHkTQ0pu_e8YA1hLmhJzb8NQ&client_key=AppGif&limit=20"));
    }
    return json.decode(response.body); //Retornado a resposta da requisição
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Container(
          height: kToolbarHeight,
          width: 300,
          child: Image.network(
              'https://media.tenor.com/nkDFXzgz1iMAAAAC/gif-gif-keyboard.gif',
              fit: BoxFit.fill),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquisar Aqui!",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Container();
                        } else {
                          return _createdGifTable(context, snapshot);
                        }
                    }
                  }))
        ],
      ),
    );
  }

  Widget _createdGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return Container();
  }
}
