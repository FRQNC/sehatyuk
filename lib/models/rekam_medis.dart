class RekamMedis {
final int idRekamMedis;
final int idJanjiTemu;
final String hasilDiagnosis;
final String pengobatan;
final String obat;
final String catatan;
final Map<String, dynamic> janjiTemu;

  // Constructor
  RekamMedis({
    required this.idRekamMedis,
    required this.idJanjiTemu,
    required this.hasilDiagnosis,
    required this.pengobatan,
    required this.obat,
    required this.catatan,
    required this.janjiTemu,
  });

  factory RekamMedis.fromJson(Map<String, dynamic> json) {
    return RekamMedis(
      idRekamMedis: json['id_rekam_medis'] ?? 0,
      idJanjiTemu: json['id_janji_temu'] ?? 0,
      hasilDiagnosis: json['hasil_diagnosis'] ?? '',
      pengobatan: json['pengobatan'] ?? '',
      obat: json['obat'] ?? '',
      catatan: json['catatan'] ?? '',
      janjiTemu: json['janji_temu'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_rekam_medis': idRekamMedis,
      'id_janji_temu': idJanjiTemu,
      'hasil_diagnosis': hasilDiagnosis,
      'pengobatan': pengobatan,
      'obat': obat,
      'catatan': catatan,
      'janji_temu': janjiTemu,
    };
  }
}
