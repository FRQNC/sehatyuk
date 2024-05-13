class Doctor {
  final int id;
  final String namaLengkap;
  final String spesialis;
  final int pengalaman;
  final String alumnus;
  final int harga;
  final String minatKlinis;
  final String foto;
  final double rating;
  final int idPoli;

  Doctor({
    required this.id,
    required this.namaLengkap,
    required this.spesialis,
    required this.pengalaman,
    required this.alumnus,
    required this.harga,
    required this.minatKlinis,
    required this.foto,
    required this.rating,
    required this.idPoli,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id_dokter'],
      namaLengkap: json['nama_lengkap_dokter'],
      spesialis: json['spesialisasi_dokter'],
      pengalaman: json['lama_pengalaman_dokter'],
      alumnus: json['alumnus_dokter'],
      harga: json['harga_dokter'],
      minatKlinis: json['minat_klinis_dokter'],
      foto: json['foto_dokter'],
      rating: json['rating_dokter'].toDouble(),
      idPoli: json['id_poli'],
    );
  }

}