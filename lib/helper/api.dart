import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static final  Api _api = Api._internal();

  factory Api() {
    return _api;
  }
  Api._internal() {
  }

  Future<Map> getcursos() async {
    var response = await rootBundle.loadString("assets/json.json");
    Map<String, dynamic> dadosJson;
    try {
      // Metodo de conexao com APi
      // http.Response response = await http.get( urlApi );

      if( response != null  ){
        dadosJson = json.decode( response );
      }
      return dadosJson;
    }catch(e){
      return {};
    }
  }
}

