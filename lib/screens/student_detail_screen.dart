import 'package:data_apk/models/score.dart';
import 'package:data_apk/models/student.dart';
import 'package:data_apk/services/api_service.dart';
import 'package:flutter/material.dart';

class StudentDetailScreen extends StatefulWidget {
  
  final Student student;
  const StudentDetailScreen({
    required this.student,
    super.key
  }); 

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {

  final ApiService api = ApiService();
  late Future<List<Score>> futureScores;

  @override
  void initState() {
    super.initState();
    futureScores = api.fetchScores(widget.student.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.nama),
      ),
      body: FutureBuilder<List<Score>>(
        future: futureScores, 
        builder: (ctx, snap) {
          
          if (snap.connectionState != ConnectionState.done) return Center(child: CircularProgressIndicator());

          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));

          final scores = snap.data!;

          return ListView(
            padding: EdgeInsets.all(12),
            children: [
              Card(
                elevation: 3,
                color: Theme.of(context).cardColor,
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama: ${widget.student.nama}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color
                        ), 
                      ),
                      Text(
                        'ID Kelas: ${widget.student.kelasId}',
                         style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color
                         ), 
                      ),
                      Text(
                        'Nama Kelas: ${widget.student.namaKelas}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color
                          ), 
                      ),
                      Text(
                        'Wali Kelas: ${widget.student.waliKelas}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color
                          ), 
                      ),
                      Text(
                        widget.student.tanggalLahir.isNotEmpty
                          ? 'Tanggal Lahir: ${widget.student.tanggalLahir}'
                          : 'Tanggal Lahir: –',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ...scores.map((s) => Card(
                color: Theme.of(context).cardColor,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(s.mataPelajaran),
                  subtitle: Text('Semester: ${s.semester}'),
                  trailing: Text(
                    s.nilai.toString(), 
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      fontSize: 20
                    ),
                  ),
                ),
              )),

            ],
          );
        }
      ),
    );
  }
}