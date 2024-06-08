import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/models/pengingat_minum_obat.dart';
import 'package:sehatyuk/providers/endpoint.dart';

// class PengingatMinumObatProvider extends ChangeNotifier {
//   List<PengingatMinumObat> _pengingatMinumObatList = [];
//   PengingatMinumObat? _pengingatMinumObat;
//   // List<Obat> _obatList = [];

//   List<PengingatMinumObat> get pengingatMinumObatList => _pengingatMinumObatList;
//   PengingatMinumObat? get pengingatMinumObat => _pengingatMinumObat;
//   // List<Obat> get obatList => _obatList;

//   Future<void> fetchPengingatMinumObat(String token) async {
//     try {
//       final url = Uri.parse('${Endpoint.url}get_pengingat_minum_obat/');
//       final response = await http.get(
//         url,
//         headers: {
//           'accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       print(response.body);
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         _pengingatMinumObatList = responseData.map((data) => PengingatMinumObat.fromJson(data)).toList();
//         notifyListeners();
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print('Error: $error');
//       notifyListeners();
//     }
//   }
// // }

//   // Future<void> fetchObat(String token) async {
//   //   try {
//   //     final url = Uri.parse('${Endpoint.url}get_obat/');
//   //     final response = await http.get(
//   //       url,
//   //       headers: {
//   //         'accept': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final List<dynamic> responseData = json.decode(response.body);
//   //       _obatList = responseData.map((data) => Obat.fromJson(data)).toList();
//   //       notifyListeners();
//   //     } else {
//   //       throw Exception('Failed to load data');
//   //     }
//   //   } catch (error) {
//   //     print('Error: $error');
//   //     notifyListeners();
//   //   }
//   }

//   // Future<void> fetchData(String token) async {
//   //   await fetchPengingatMinumObat(token);
//   //   await fetchObat(token);
//   // }
// // }

class PengingatMinumObatProvider extends ChangeNotifier {
  List<PengingatMinumObat> _pengingatMinumObatList = [];

  List<PengingatMinumObat> get pengingatMinumObatList => _pengingatMinumObatList;

  PengingatMinumObat _dataPengingatMinumObat = PengingatMinumObat(idPengingat: 0, idObat: 0, idUser: 0,dosis: 0, sendok: '', jadwal: '', aturan: '', obat: {}, user: {});

  PengingatMinumObat get dataPengingatMinumObat => _dataPengingatMinumObat;

  set pengingatMinumObatList(List<PengingatMinumObat> value) {
    _pengingatMinumObatList = value;
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
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _pengingatMinumObatList = responseData.map((data) => PengingatMinumObat.fromJson(data)).toList();
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

  Future<void> fetchDataById(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_obat_by_id/$id'); // url read obat
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
        _dataPengingatMinumObat = PengingatMinumObat.fromJson(responseData);
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


