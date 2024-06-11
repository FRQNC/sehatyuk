class RekamMedis {
final int idRekamMedis;
final int idJanjiTemu;
final int idObat;
final String hasilDiagnosis;
final String pengobatan;
final String dosisobat;
final String catatan;
final Map<String, dynamic> janjiTemu;
final Map<String, dynamic> obat;

  // Constructor
  RekamMedis({
    required this.idRekamMedis,
    required this.idJanjiTemu,
    required this.idObat,
    required this.hasilDiagnosis,
    required this.pengobatan,
    required this.dosisobat,
    required this.catatan,
    required this.janjiTemu,
    required this.obat,
  });

  factory RekamMedis.fromJson(Map<String, dynamic> json) {
    return RekamMedis(
      idRekamMedis: json['id_rekam_medis'] ?? 0,
      idJanjiTemu: json['id_janji_temu'] ?? 0,
      idObat: json['id_obat'] ?? 0,
      hasilDiagnosis: json['hasil_diagnosis'] ?? '',
      pengobatan: json['pengobatan'] ?? '',
      dosisobat: json['dosis_obat'] ?? '',
      catatan: json['catatan'] ?? '',
      janjiTemu: json['janji_temu'] ?? {},
      obat: json['obat'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_rekam_medis': idRekamMedis,
      'id_janji_temu': idJanjiTemu,
      'id_obat': idObat,
      'hasil_diagnosis': hasilDiagnosis,
      'pengobatan': pengobatan,
      'dosis_obat': dosisobat,
      'catatan': catatan,
      'janji_temu': janjiTemu,
      'obat': obat,
    };
  }
}
