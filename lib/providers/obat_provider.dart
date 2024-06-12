import 'package:flutter/material.dart';
import 'package:sehatyuk/models/obat.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/auth/auth.dart';


class ObatProvider extends ChangeNotifier {
  AuthService auth = AuthService();

  List<Obat> _obats = [];

  List<Obat> get obats => _obats;

  Obat _dataObat = Obat(
      idObat: 0,
      namaObat: '',
      deskripsiObat: '',
      komposisiObat: '',
      dosisObat: '',
      peringatanObat: '',
      efekSampingObat: '',
      fotoObat: '',
      idJenisObat: 0,
      jenisObat: {});

  Obat get dataObat => _dataObat;

  set obats(List<Obat> value) {
    _obats = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    String token = await auth.getToken();
    try {
      final url = Uri.parse('${Endpoint.url}get_obat/');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _obats = responseData.map((data) => Obat.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
    }
  }

  Future<void> fetchDataById(String id) async {
    String token = await auth.getToken();
    try {
      final url = Uri.parse('${Endpoint.url}get_obat_by_id/$id');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        _dataObat = Obat.fromJson(responseData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
    }
  }

  List<Obat> searchObats(String query) {
    if (query.isEmpty) {
      return _obats;
    }
    return _obats
        .where(
            (obat) => obat.namaObat.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
