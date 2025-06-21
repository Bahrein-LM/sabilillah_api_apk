import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  
  final List<BarChartGroupData> groups;
  final List<String> labels;

  const BarChartWidget({
    required this.groups,
    required this.labels,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final accent = theme.colorScheme.onSecondary;

    // if no data at all, show placeholder
    if (groups.isEmpty || labels.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text('Tidak ada data untuk grafik')),
      );
    }

    // Log for debugging
    // ignore: avoid_print
    print('BarChartWidget: group = $groups');
    // ignore: avoid_print
    print('BarChartWidget: labels = $labels');

    final values = groups
      .expand((g) => g.barRods.map((r) => r.toY))
      .toList();

    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final chartMaxY = maxVal > 0 ? maxVal * 1.2 : 1.0;

    return SizedBox(
      height: 300,
      child: Card(
        color: theme.cardColor,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              minY: 0,
              maxY: chartMaxY,
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: chartMaxY / 5,
                getDrawingHorizontalLine: (_) => 
                  FlLine(color: Colors.white10, strokeWidth: 1)
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true, 
                    interval: chartMaxY / 5,
                    getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          color: theme.textTheme.bodySmall!.color,
                          fontSize: 10
                        ),
                    )
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    // map x index -> label
                    getTitlesWidget: (value, _) {

                      final i = value.toInt();

                      if (i < 0 || i >= labels.length) {
                        return const SizedBox();
                      }
                      
                      return Text(
                        labels[i],
                        style: TextStyle(
                          color: theme.textTheme.bodySmall!.color,
                          fontSize: 10
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: groups.map((g) => BarChartGroupData(
                x: g.x,
                barRods: g.barRods.map((rod) => BarChartRodData(
                  toY: rod.toY,
                  width: 20,
                  color: accent,
                  borderRadius: BorderRadius.circular(4)
                )).toList()
              )).toList(),
            ),
          ),
        ),
      ),
    );
  } 
}