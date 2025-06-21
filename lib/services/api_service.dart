import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import '../models/score.dart';
import '../models/kelas.dart';

class ApiService {
  
  Future<List<Student>> fetchStudents() async {
    
    final uri = Uri.parse('https://test-api.sekolahsabilillah.sch.id?endpoint=siswa');
    final String token = '40f6c8e7fb3f22be8449ffd7980b85e74a0dd65a';

    final response = await http.get(
      uri, 
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if (response.statusCode != 200) {
      throw Exception('Server merespon ${response.statusCode}: ${response.reasonPhrase}');
    }
    
    final data = json.decode(response.body)['data'];

    if (data is! List) return [];

    final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(data);

    final students = list.map((json) => Student.fromJson(json)).toList();

    return students;
  }

  Future <List<Score>> fetchScores(String siswaId) async {
    final uri = Uri.parse('https://test-api.sekolahsabilillah.sch.id?endpoint=nilai');
    final String token = '40f6c8e7fb3f22be8449ffd7980b85e74a0dd65a';
    
    final response = await http.get(uri, 
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if (response.statusCode != 200) {
      throw Exception('Server merespon ${response.statusCode}: ${response.reasonPhrase}');
    }

    final raw = json.decode(response.body)['data'];
    if (raw is! List) return [];

    final list = raw.cast<Map<String, dynamic>>();
    final allScores = list.map((json) => Score.fromJson(json));

    return siswaId.isEmpty
        ? allScores.toList()
        : allScores.where((s) => s.siswaId == siswaId).toList();
  }

  Future <List<Kelas>> fetchKelas() async {
    final uri = Uri.parse('https://test-api.sekolahsabilillah.sch.id?endpoint=kelas');
    final String token = '40f6c8e7fb3f22be8449ffd7980b85e74a0dd65a';
    
    final response = await http.get(uri, 
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if (response.statusCode != 200) {
      throw Exception('Server merespon ${response.statusCode}: ${response.reasonPhrase}');
    }

    final raw = json.decode(response.body)['data'];
    if (raw is! List) return [];

    final list = raw.cast<Map<String, dynamic>>();
    return list.map((json) => Kelas.fromJson(json)).toList();
  } 

}
