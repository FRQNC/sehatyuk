import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/models/pengingat_minum_obat.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class PengingatMinumObatProvider extends ChangeNotifier {
  List<PengingatMinumObat> _pengingatMinumObatList = [];

  List<PengingatMinumObat> get pengingatMinumObatList => _pengingatMinumObatList;

  PengingatMinumObat _dataPengingatMinumObat = PengingatMinumObat(idPengingat: 0, idObat: 0, idUser: 0,dosis: 0, sendok: '', jadwal: '', aturan: '', obat: {}, user: {});

  PengingatMinumObat get dataPengingatMinumObat => _dataPengingatMinumObat;

  set pengingatMinumObatList(List<PengingatMinumObat> value) {
    _pengingatMinumObatList = value;
    notifyListeners();
  }

  Future<void> fetchData(String token, String idUser) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_pengingat_minum_obat/$idUser'); // url read obat
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _pengingatMinumObatList = responseData.map((data) => PengingatMinumObat.fromJson(data)).toList();
        notifyListeners(); // Memberi tahu pendengar tentang perubahan pada data
      } else {
        throw Exception('sdasa');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners(); // Memberi tahu pendengar bahwa terjadi kesalahan
      // Handle error sesuai dengan kebutuhan aplikasi Anda
    }
  }

  // Future<void> fetchDataById(String token, String id) async {
  //   try {
  //     final url = Uri.parse('${Endpoint.url}get_pengingat_minum_obat_by_id/$id'); // url read obat
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     print(response.statusCode);

  //     if (response.statusCode == 200) {
  //       final dynamic responseData = json.decode(response.body);
  //       _dataPengingatMinumObat = PengingatMinumObat.fromJson(responseData);
  //       notifyListeners(); // Memberi tahu pendengar tentang perubahan pada data
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     notifyListeners(); // Memberi tahu pendengar bahwa terjadi kesalahan
  //     // Handle error sesuai dengan kebutuhan aplikasi Anda
  //   }
  // }
}


