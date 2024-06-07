import 'package:flutter/material.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/models/jadwal_dokter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/models/janji_temu.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> _doctors = [];
  List<JadwalDokter> _jadwal_dokter = [];
  Doctor _dataDokter = Doctor(id: 0, namaLengkap: '', spesialis: '', pengalaman: 0, alumnus: '', harga: 0, minatKlinis: '', foto: '', rating: 0, idPoli: 0);
  List<Doctor> _dataDokterJoin = [];

  List<Doctor> get doctors => _doctors;
  List<JadwalDokter> get jadwal_dokter => _jadwal_dokter;
  Doctor get dataDokter => _dataDokter;
  List<Doctor> get dataDokterJoin => _dataDokterJoin;

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
  Future<void> fetchDataById(String token, int id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_dokter_by_id/$id'); // url read doctornya
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        _dataDokter = Doctor.fromJson(responseData);
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

  Future<void> fetchDataJoin(String token, List<JanjiTemu> janji_temu) async{
    _dataDokterJoin.clear();
    for(int i = 0; i < janji_temu.length; i++){
      await fetchDataById(token, janji_temu[i].idDokter);
      _dataDokterJoin.add(_dataDokter);
      // print(_dataDokterJoin[i].namaLengkap);
      notifyListeners();
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
