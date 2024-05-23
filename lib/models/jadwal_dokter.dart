class JadwalDokter {
  final int idJadwalDokter;
  final int idDokter;
  final String tanggalJadwalDokter;
  final int isFull;

  JadwalDokter({
    required this.idJadwalDokter,
    required this.idDokter,
    required this.tanggalJadwalDokter,
    required this.isFull,
  });

  factory JadwalDokter.fromJson(Map<String, dynamic> json) {
    return JadwalDokter(
      idJadwalDokter: json['id_jadwal_dokter'],
      idDokter: json['id_dokter'],
      tanggalJadwalDokter: json['tanggal_jadwal_dokter'],
      isFull: json['isFull'],
    );
  }
}