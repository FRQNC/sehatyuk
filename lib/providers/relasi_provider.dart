import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/auth/auth.dart';
import 'dart:convert';
import 'package:sehatyuk/models/relasi.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class RelasiProvider extends ChangeNotifier {
  List<Relasi> _relasiList = [];

  List<Relasi> get relasiList => _relasiList;

  set relasiList(List<Relasi> value) {
    _relasiList = value;
    notifyListeners();
  }

  AuthService auth = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


  Future<void> fetchData(String id, String token) async {
    try {
      final url = Uri.parse("${Endpoint.url}get_relasi/$id");
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _relasiList = responseData.map((data) => Relasi.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<int> addRelasi(String token, Relasi relasi) async{
    _setLoading(true);
    final response = await http.post(
      Uri.parse("${Endpoint.url}create_relasi/"),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(relasi.toJson())
    );
    _setLoading(false);
    if(response.statusCode == 200){
      return response.statusCode;
    }
    else{
      print(response.body);
      return response.statusCode;
    }
  }
}
