import 'package:flutter/material.dart';
import 'package:sehatyuk/models/obat.dart'; // Pastikan Anda memiliki model Obat yang sesuai
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';

class ObatProvider extends ChangeNotifier {
  List<Obat> _obats = [];

  List<Obat> get obats => _obats;

  set obats(List<Obat> value) {
    _obats = value;
    notifyListeners();
  }

  Future<void> fetchData(String token) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_obat/'); // url read obat
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _obats = responseData.map((data) => Obat.fromJson(data)).toList();
        notifyListeners(); // Memberi tahu pendengar tentang perubahan pada data
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners(); // Memberi tahu pendengar bahwa terjadi kesalahan
      // Handle error sesuai dengan kebutuhan aplikasi Anda
    }
  }
}
