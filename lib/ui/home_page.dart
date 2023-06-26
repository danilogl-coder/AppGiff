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
    return const Placeholder();
  }
}
