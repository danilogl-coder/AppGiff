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
  String? _search; // Criei uma variavel de pequisa
  String? _pos;
  Future<Map> _getGifs() async {
    http.Response response; //Declaramos a resposta

    if (_search == null) {
      // Fazendo a requisição padrão
      response = await http.get(Uri.parse(
          "https://tenor.googleapis.com/v2/search?q=excited&key=AIzaSyA41-KeNKvMHkTQ0pu_e8YA1hLmhJzb8NQ&client_key=AppGif&limit=19&pos=''&locale=pt-BR&media_filter=gif"));
    } else {
      //Fazendo a requisição com  base na variavel search
      response = await http.get(Uri.parse(
          "https://tenor.googleapis.com/v2/search?q=$_search&key=AIzaSyA41-KeNKvMHkTQ0pu_e8YA1hLmhJzb8NQ&client_key=AppGif&limit=19&pos=$_pos&locale=pt-BR&media_filter=gif"));
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
                labelStyle: TextStyle(color: Colors.lightBlue),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue)),
              ),
              style: TextStyle(color: Colors.lightBlue, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _pos = '';
                });
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, AsyncSnapshot snapshot) {
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

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createdGifTable(BuildContext context, AsyncSnapshot snapshot) {
    Padding(padding: EdgeInsets.all(10.0));
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _getCount(snapshot.data['results']),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data['results'].length) {
            return GestureDetector(
              child: Image.network(
                snapshot.data['results'][index]['media_formats']['gif']['url'],
                height: 300.0,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text("Carregar mais..",
                        style: TextStyle(color: Colors.white, fontSize: 22.0))
                  ],
                ),
                onTap: () {
                  setState(() {
                    _pos = snapshot.data['next'];
                  });
                },
              ),
            );
          }
        });
  }
}
