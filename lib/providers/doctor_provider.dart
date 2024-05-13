import 'package:flutter/material.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> _doctors = [];

  List<Doctor> get doctors => _doctors;

  set doctors(List<Doctor> value) {
    _doctors = value;
    notifyListeners();
  }

  Future<void> fetchData(String token) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_dokter/'); // url read doctornya
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _doctors = responseData.map((data) => Doctor.fromJson(data)).toList();
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