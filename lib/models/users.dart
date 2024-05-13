class Users {
  int user_id;
  String namaLengkap;
  DateTime tanggalLahir;
  String gender;
  String alamat;
  String noBPJS;
  String noTelp;
  String email;
  String password;
  String photoUrl;

  Users({
    required this.user_id,
    required this.namaLengkap,
    required this.tanggalLahir,
    required this.gender,
    required this.alamat,
    required this.noBPJS,
    required this.noTelp,
    required this.email,
    required this.password,
    required this.photoUrl,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      user_id: json['user_id_user'],
      namaLengkap: json['nama_lengkap_user'],
      tanggalLahir: DateTime.parse(json['tgl_lahir_user']),
      gender: json['gender_user'],
      alamat: json['alamat_user'],
      noBPJS: json['no_bpjs_user'],
      noTelp: json['no_telp_user'],
      email: json['email_user'],
      password: json['password_user'],
      photoUrl: json['foto_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id_user': user_id,
      'nama_lengkap_user': namaLengkap,
      'tgl_lahir_user': tanggalLahir.toIso8601String(),
      'gender_user': gender,
      'alamat_user': alamat,
      'no_bpjs_user': noBPJS,
      'no_telp_user': noTelp,
      'email_user': email,
      'password_user': password,
      'foto_user': photoUrl,
    };
  }
}
