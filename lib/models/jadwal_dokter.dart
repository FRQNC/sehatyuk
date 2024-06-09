class JadwalDokter {
  final int idJadwalDokter;
  final int idDokter;
  final DateTime tanggalJadwalDokter;
  final int isFull;
  final String startTime;
  final String endTime;

  JadwalDokter({
    required this.idJadwalDokter,
    required this.idDokter,
    required this.tanggalJadwalDokter,
    required this.isFull,
    required this.startTime,
    required this.endTime,
  });

  factory JadwalDokter.fromJson(Map<String, dynamic> json) {
    // Assuming time format is 'HH:mm'
    List<String> startTimeComponents = json['start_time'].toString().split(':');
    List<String> endTimeComponents = json['end_time'].toString().split(':');

    // Extract hour and minute
    String startHour = startTimeComponents[0];
    String startMinute = startTimeComponents[1];
    String endHour = endTimeComponents[0];
    String endMinute = endTimeComponents[1];

    // Extract only the hour and minute parts from the DateTime objects
    String startTimeString = '${startHour}:${startMinute}';
    String endTimeString = '${endHour}:${endMinute}';

    return JadwalDokter(
      idJadwalDokter: json['id_jadwal_dokter'],
      idDokter: json['id_dokter'],
      tanggalJadwalDokter: DateTime.parse(json['tanggal_jadwal_dokter']),
      isFull: json['is_full'],
      startTime: startTimeString,
      endTime: endTimeString,
    );
  }
}