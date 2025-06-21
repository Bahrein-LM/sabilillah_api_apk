
class Student {
  
  final String id;
  final String nama;
  final String tanggalLahir;
  final String kelasId;
  final String namaKelas;
  final String waliKelas;

  Student({
    required this.id,
    required this.nama,
    required this.tanggalLahir,
    required this.kelasId,
    required this.namaKelas,
    required this.waliKelas,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    final tgl = json['tanggalLahir'] ?? json['tanggalLayer'] ?? '';
    return Student(
      id: json['id']?.toString() ?? '', 
      nama: json['nama']?.toString() ?? '', 
      tanggalLahir: tgl.toString(),
      kelasId: json['kelasId']?.toString() ?? '', 
      namaKelas: json['namaKelas']?.toString() ?? '', 
      waliKelas: json['waliKelas']?.toString() ?? ''
    );
  }  
}