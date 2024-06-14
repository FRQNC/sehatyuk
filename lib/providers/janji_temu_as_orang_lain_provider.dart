import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/models/janji_temu_as_orang_lain.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class JanjiTemuAsOrangLainProvider extends ChangeNotifier {
  JanjiTemuAsOrangLain _item = JanjiTemuAsOrangLain(
      namaOrangLain: "",
      noBPJS: "",
      tglLahir: "",
      gender: "",
      noTelp: "",
      alamat: "",
      id_user: 0);
  JanjiTemuAsOrangLain get item => _item;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


  Future<void> fetchData(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_janji_temu_as_orang_lain/$id');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        _item = JanjiTemuAsOrangLain.fromJson(responseData);
        // _janjiTemuList = responseData.map((data) => JanjiTemu.fromJson(data)).toList();
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

  Future<dynamic> createJanjiTemuAsOrangLain(String token, JanjiTemuAsOrangLain janji_temu) async {
    _setLoading(true);
    final response = await http.post(
      Uri.parse('${Endpoint.url}create_janji_temu_as_orang_lain/'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(janji_temu.toJson()),
    );
    _setLoading(false);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print("ololololololo " +
          responseBody['id_janji_temu_as_orang_lain'].toString());
      return responseBody;
    } else {
      return false;
    }
  }
}
