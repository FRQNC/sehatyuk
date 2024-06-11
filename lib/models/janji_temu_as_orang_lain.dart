class JanjiTemuAsOrangLain {
  final int? id;
  final String namaOrangLain;
  final String noBPJS;
  final String tglLahir;
  final String gender;
  final String noTelp;
  final String alamat;
  final int id_user;

  JanjiTemuAsOrangLain({
    this.id,
    required this.namaOrangLain,
    required this.noBPJS,
    required this.tglLahir,
    required this.gender,
    required this.noTelp,
    required this.alamat,
    required this.id_user,
  });

  factory JanjiTemuAsOrangLain.fromJson(Map<String, dynamic> json) {
    return JanjiTemuAsOrangLain(
      id: json['id_janji_temu_as_orang_lain'],
      namaOrangLain: json['nama_lengkap_orang_lain'],
      noBPJS: json['no_bpjs_orang_lain'],
      tglLahir: json['tgl_lahir_orang_lain'],
      gender: json['gender_orang_lain'],
      noTelp: json['no_telp_orang_lain'],
      alamat: json['alamat_orang_lain'],
      id_user: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_lengkap_orang_lain': namaOrangLain,
      'no_bpjs_orang_lain': noBPJS,
      'tgl_lahir_orang_lain': tglLahir,
      'gender_orang_lain': gender,
      'no_telp_orang_lain': noTelp,
      'alamat_orang_lain': alamat,
      'id_user': id_user,
    };
  }
}
