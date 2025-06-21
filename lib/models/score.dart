
class Score {
  final String id;
  final String siswaId;
  final String mataPelajaran;
  final int nilai;
  final String semester;
  final String namaSiswa;
  final String namaKelas;

  Score({
    required this.id,
    required this.siswaId,
    required this.mataPelajaran,
    required this.nilai,
    required this.semester,
    required this.namaSiswa,
    required this.namaKelas
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id']?.toString() ?? '', 
      siswaId: json['siswaId']?.toString() ?? '', 
      mataPelajaran: json['mataPelajaran']?.toString() ?? '', 
      nilai: (json['nilai'] is int) 
              ? json['nilai']
              : int.tryParse(json['nilai']?.toString() ?? '') ?? 0, 
      semester: json['semester']?.toString() ?? '', 
      namaSiswa: json['namaSiswa']?.toString() ?? '', 
      namaKelas: json['namaKelas']?.toString() ?? '',
    );
  }
}