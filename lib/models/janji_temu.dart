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
  });

  factory JanjiTemu.fromJson(Map<String, dynamic> json) {
    var rel;
    if(json['is_relasi'] == 0){
      rel = {"content": "null"};
    }
    else{
      rel = json['relasi'];
    }

    var orangLain;
    if(json['id_janji_temu_orang_lain'] == 0){
      orangLain = {"content": "null"};
    }
    else{
      orangLain = json['janji_temu_as_orang_lain'];
    }
    return JanjiTemu(
      id: json['id_janji_temu'],
      kodeJanjiTemu: json['kode_janji_temu'],
      tanggalJanjiTemu: json['tgl_janji_temu'],
      idDokter: json['id_dokter'],
      idUser: json['id_user'],
      isRelasi: json['is_relasi'],
      idRelasi: json['id_relasi'],
      biaya: json['biaya_janji_temu'],
      idOrangLain: json['id_janji_temu_as_orang_lain'],
      dokter: json['dokter'],
      user: json['user'],
      relasi: rel,
      janjiOrangLain: orangLain,
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
    };
  }

}