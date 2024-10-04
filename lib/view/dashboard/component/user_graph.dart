import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserGraph extends StatelessWidget {
  final int totalUsers;

  const UserGraph({super.key, required this.totalUsers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: SfCircularChart(
          title: const ChartTitle(
          text: 'Total Registered Users',
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
          legend: const Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: <CircularSeries>[
            RadialBarSeries<ChartData, String>(
              dataSource: [
                ChartData('Users', totalUsers
                )],
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              cornerStyle: CornerStyle.bothCurve,
              maximumValue: totalUsers.toDouble() + 10, // Adjust based on your data
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  String x;
  int y;

  ChartData(this.x, this.y);
}
