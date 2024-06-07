class Relasi {
  String id_relasi;
  String id_user;
  String namaLengkap;
  String noBPJS;
  String tanggalLahir;
  String gender;
  String noTelp;
  String photoUrl;
  String alamat;
  String tipe;

  Relasi({
    this.id_relasi = '',
    this.id_user = '',
    required this.namaLengkap,
    required this.noBPJS,
    required this.tanggalLahir,
    required this.gender,
    required this.noTelp,
    required this.photoUrl,
    required this.alamat,
    required this.tipe,
  });

  factory Relasi.fromJson(Map<String, dynamic> json) {
    return Relasi(
      id_relasi: json['id_relasi'].toString(),
      id_user: json['id_user'].toString(),
      namaLengkap: json['nama_lengkap_relasi'],
      noBPJS: json['no_bpjs_relasi'],
      tanggalLahir: json['tgl_lahir_relasi'],
      gender: json['gender_relasi'],
      noTelp: json['no_telp_relasi'],
      photoUrl: json['foto_relasi'],
      alamat: json['alamat_relasi'],
      tipe: json['tipe_relasi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_lengkap_relasi': namaLengkap,
      'no_bpjs_relasi': noBPJS,
      'tgl_lahir_relasi': tanggalLahir,
      'gender_relasi': gender,
      'no_telp_relasi': noTelp,
      'alamat_relasi': alamat,
      'foto_relasi': photoUrl,
      'tipe_relasi': tipe,
    };
  }
}
