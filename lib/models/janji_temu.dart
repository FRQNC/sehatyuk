class JanjiTemu {
  final int? id;
  final String kodeJanjiTemu;
  final String tanggalJanjiTemu;
  final int idDokter;
  final int idUser;
  final int isRelasi;
  final int idRelasi;
  final int biaya;

  JanjiTemu({
    this.id,
    required this.kodeJanjiTemu,
    required this.tanggalJanjiTemu,
    required this.idDokter,
    required this.idUser,
    required this.isRelasi,
    required this.idRelasi,
    required this.biaya,
  });

  factory JanjiTemu.fromJson(Map<String, dynamic> json) {
    return JanjiTemu(
      id: json['id_janji_temu'],
      kodeJanjiTemu: json['kode_janji_temu'],
      tanggalJanjiTemu: json['tgl_janji_temu'],
      idDokter: json['id_dokter'],
      idUser: json['id_user'],
      isRelasi: json['is_relasi'],
      idRelasi: json['id_relasi'],
      biaya: json['biaya_janji_temu'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'kode_janji_temu': kodeJanjiTemu,
      'tgl_janji_temu': tanggalJanjiTemu,
      'id_dokter': idDokter,
      'id_user': idUser,
      'is_relasi': isRelasi,
      'id_relasi': idRelasi,
      'biaya_janji_temu': biaya,
    };
  }

}