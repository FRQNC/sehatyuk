class PengingatMinumObat {
  final int? idPengingat;
  final int idObat;
  final int idUser;
  final int dosis;
  final String sendok;
  final String jadwal;
  final String aturan;
  Map<String, dynamic> obat;
  final Map<String, dynamic> user;

  PengingatMinumObat({
    this.idPengingat,
    required this.idObat,
    required this.idUser,
    required this.dosis,
    required this.sendok,
    required this.jadwal,
    required this.aturan,
    required this.obat,
    required this.user,
  });

  factory PengingatMinumObat.fromJson(Map<String, dynamic> json) {
    return PengingatMinumObat(
      idPengingat: json['id_pengingat'],
      idObat: json['id_obat'],
      idUser: json['id_user'],
      dosis: json['dosis'],
      sendok: json['sendok'],
      jadwal: json['jadwal'],
      aturan: json['aturan'],
      obat: json['obat'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_obat': idObat,
      'id_user': idUser,
      'dosis': dosis,
      'sendok': sendok,
      'jadwal': jadwal,
      'aturan': aturan,
    };
  }
}
