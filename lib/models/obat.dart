class Obat {
  int idObat;
  String namaObat;
  String deskripsiObat;
  String komposisiObat;
  String dosisObat;
  String peringatanObat;
  String efekSampingObat;
  String fotoObat;
  int idJenisObat;
  Map<String, dynamic> jenisObat;

  Obat(
      {required this.idObat,
      required this.namaObat,
      required this.deskripsiObat,
      required this.komposisiObat,
      required this.dosisObat,
      required this.peringatanObat,
      required this.efekSampingObat,
      required this.fotoObat,
      required this.idJenisObat,
      required this.jenisObat});

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
        idObat: json['id_obat'],
        namaObat: json['nama_obat'],
        deskripsiObat: json['deskripsi_obat'],
        komposisiObat: json['komposisi_obat'],
        dosisObat: json['dosis_obat'],
        peringatanObat: json['peringatan_obat'],
        efekSampingObat: json['efek_samping_obat'],
        fotoObat: json['foto_obat'],
        idJenisObat: json['id_jenis_obat'],
        jenisObat: json['jenis_obat']);
  }
}
