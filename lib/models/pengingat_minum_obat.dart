class PengingatMinumObat {
  final int idPengingat;
  final int idObat;
  final int idUser;
  final int dosis;
  final String sendok;
  final String jadwal;
  final String aturan;
  Map<String, dynamic> obat;
  final Map<String, dynamic> user;
  // Map<String, dynamic> namaObat;
  // Map<String, dynamic> fotoObat;

  PengingatMinumObat({
    required this.idPengingat,
    required this.idObat,
    required this.idUser,
    required this.dosis,
    required this.sendok,
    required this.jadwal,
    required this.aturan,
    required this.obat,
    required this.user,
    // required this.namaObat,
    // required this.fotoObat,
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
      // namaObat: json['nama_obat'],
      // fotoObat: json['foto_obat'],
    );
  }

}