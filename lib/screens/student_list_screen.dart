import 'package:data_apk/models/student.dart';
import 'package:data_apk/screens/report_screen.dart';
import 'package:data_apk/screens/student_detail_screen.dart';
import 'package:data_apk/services/api_service.dart';
import 'package:data_apk/widgets/student_card.dart';
import 'package:flutter/material.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({ super.key });

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

  final ApiService api = ApiService();
  late Future<List<Student>> futureStudents;

  @override
  void initState() {
    super.initState();
    futureStudents = api.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Siswa'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ReportScreen()), 
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Student>>(
        future: futureStudents, 
        builder: (ctx, snap) {

          if (snap.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }

          final list = snap.data!;
          
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) => StudentCard(
              student: list[i], 
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => StudentDetailScreen(student: list[i]),
                )
              )
            ),
          );
        }
      ),
    );
  }
}