import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cep_model.dart';

class CepRepository {
  Future<Cep> fetchCep(String cep) async {
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      return Cep.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao buscar CEP: ${response.statusCode}');
    }
  }
}
