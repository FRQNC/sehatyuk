import 'package:flutter/material.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/models/jadwal_dokter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> _doctors = [];
  List<JadwalDokter> _jadwal_dokter = [];

  List<Doctor> get doctors => _doctors;
  List<JadwalDokter> get jadwal_dokter => _jadwal_dokter;

  set doctors(List<Doctor> value) {
    _doctors = value;
    notifyListeners();
  }
  set jadwal_dokter(List<JadwalDokter> value) {
    _jadwal_dokter = value;
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
  
  Future<void> fetchDataJadwal(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_jadwal_dokter_by_id/$id'); // url read doctornya
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _jadwal_dokter = responseData.map((data) => JadwalDokter.fromJson(data)).toList();
        // print(_jadwal_dokter[0].idDokter);
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