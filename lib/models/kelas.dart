
class Kelas {
  final String id;
  final String nama;
  final String waliKelas;

  Kelas({
    required this.id,
    required this.nama,
    required this.waliKelas,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
    id: json['id']?.toString() ?? '', 
    nama: json['nama']?.toString() ?? '', 
    waliKelas: json['waliKelas']?.toString() ?? '',
  );
}