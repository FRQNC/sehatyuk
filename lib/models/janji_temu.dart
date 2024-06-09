class JanjiTemu {
  final int? id;
  final String kodeJanjiTemu;
  final String tanggalJanjiTemu;
  final int idDokter;
  final int idUser;
  final int isRelasi;
  final int idRelasi;
  final int biaya;
  final int idOrangLain;
  final String status;
  final Map<String, dynamic> dokter;
  final Map<String, dynamic> user;
  final Map<String, dynamic> relasi;
  final Map<String, dynamic> janjiOrangLain;

  JanjiTemu({
    this.id,
    required this.kodeJanjiTemu,
    required this.tanggalJanjiTemu,
    required this.idDokter,
    required this.idUser,
    required this.isRelasi,
    required this.idRelasi,
    required this.biaya,
    required this.idOrangLain,
    required this.dokter,
    required this.user,
    required this.relasi,
    required this.janjiOrangLain,
    required this.status,
  });

  factory JanjiTemu.fromJson(Map<String, dynamic> json) {
    var rel = json['is_relasi'] == 1 ? json['relasi'] : null;
    var orangLain = json['id_janji_temu_as_orang_lain'] != 0 ? json['janji_temu_as_orang_lain'] : null;

    return JanjiTemu(
      id: json['id_janji_temu'],
      kodeJanjiTemu: json['kode_janji_temu'] ?? '',
      tanggalJanjiTemu: json['tgl_janji_temu'] ?? '',
      idDokter: json['id_dokter'] ?? 0,
      idUser: json['id_user'] ?? 0,
      isRelasi: json['is_relasi'] ?? 0,
      idRelasi: json['id_relasi'] ?? 0,
      biaya: json['biaya_janji_temu'] ?? 0, // Pastikan nilai default jika null
      idOrangLain: json['id_janji_temu_as_orang_lain'] ?? 0,
      status: json['status'] ?? 1,
      dokter: json['dokter'] ?? {},
      user: json['user'] ?? {},
      relasi: rel ?? {},
      janjiOrangLain: orangLain ?? {},
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
      'id_janji_temu_as_orang_lain': idOrangLain,
      'status': status,
    };
  }

}