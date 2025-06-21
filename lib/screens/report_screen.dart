import 'package:data_apk/models/kelas.dart';
import 'package:data_apk/models/score.dart';
import 'package:data_apk/services/api_service.dart';
import 'package:data_apk/widgets/bar_chart_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({ super.key });
  
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  
  final ApiService api = ApiService();
  late Future<List<Score>> fScores;
  late Future<List<Kelas>> fKelas;

  @override
  void initState() {
    super.initState();
    fScores = api.fetchScores('');
    fKelas = api.fetchKelas();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Laporan'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([fScores, fKelas]), 
        builder: (ctx, snap) {
          
          // Loading
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snap.hasError) {
            return Center(
              child: Text(
                'Error ${snap.error}', 
                style: const TextStyle(color: Colors.red)
              )
            );
          }

          final scores = snap.data![0] as List<Score>;
          final kelas = snap.data![1] as List<Kelas>;

          if (scores.isEmpty || kelas.isEmpty) {
            return const Center(child: Text('Data nilai atau kelas tidak tersedia.'));
          }

          final Map<String, double> sumMap = {};
          final Map<String, int> countMap = {};

          for (var s in scores) {
            sumMap[s.mataPelajaran] = (sumMap[s.mataPelajaran] ?? 0) + s.nilai;
            countMap[s.mataPelajaran] = (countMap[s.mataPelajaran] ?? 0) + 1;
          }

          final avgLabels = sumMap.keys.toList();
          final avgGroups = <BarChartGroupData>[];

          for (var i = 0; i < avgLabels.length; i++) {

            final subject = avgLabels[i];
            final sum = sumMap[subject]!;
            final cnt = countMap[subject]!;
            final avg = cnt > 0 ? sum / cnt : 0.0;
            avgGroups.add(BarChartGroupData(
              x: i,
              barRods: [BarChartRodData(toY: avg)]
            ));
          }
          
          // Build Count for Classrooms

          final Map<String, int> cntClass = {
            for (var k in kelas) k.nama: 0
          };

          for (var s in scores) {
            if (cntClass.containsKey(s.namaKelas)){
              cntClass[s.namaKelas] = cntClass[s.namaKelas]! + 1;
            }
          }

          final cntLabels = cntClass.keys.toList();
          final cntGroups = <BarChartGroupData>[];

          for (var i = 0; i < cntLabels.length; i++) {
            final cls = cntLabels[i];
            cntGroups.add(BarChartGroupData(
              x: i, 
              barRods: [BarChartRodData(
                toY: cntClass[cls]!.toDouble())
              ]
            ));
          }

          // Log for debugging
          // ignore: avoid_print
          print('avgLabels: $avgLabels');
          // ignore: avoid_print
          print('avgGroups: $avgGroups');
          // ignore: avoid_print
          print('cntLabels: $cntLabels');
          // ignore: avoid_print
          print('cntGroups: $cntGroups');

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
                  child: Text(
                    'Rata-rata Nilai per Mata Pelajaran', 
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodySmall!.color
                    )
                  )
                ),
                if (avgGroups.every((g) => g.barRods.first.toY == 0.0)) 
                  const Center(
                    child: Text('Belum ada nilai untuk grafik rata-rata.')
                  )  
                else 
                  BarChartWidget(
                    groups: avgGroups,
                    labels: avgLabels,
                  ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
                  child: Text(
                    'Jumlah Nilai per Kelas', 
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                       color: Theme.of(context).textTheme.bodySmall!.color
                    )
                  )
                ),
                if (cntGroups.every((g) => g.barRods.first.toY == 0.0))
                  const Center(child: Text('Belum ada data untuk grafik jumlah.'))
                else
                  BarChartWidget(
                    groups: cntGroups, 
                    labels: cntLabels,
                  ),
              ],
            ),
          );
        }
      ),
    );
  }
}