import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesUploadGraph extends StatelessWidget {
  final double totalSales;

  const SalesUploadGraph({super.key, required this.totalSales});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Total Sales', totalSales),
      ChartData('Remaining', 100000 - totalSales), // Assume max sales is 100,000 for demo
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: SfCircularChart(
          title: const ChartTitle(
            text: 'Total Sales',
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointColorMapper: (ChartData data, _) => data.x == 'Total Sales' ? Colors.green : Colors.grey[300],
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(color: Colors.black, fontSize: 14),
              ),
              radius: '80%',
              innerRadius: '50%',
              enableTooltip: true,
              animationDuration: 2000,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  String x;
  double y;

  ChartData(this.x, this.y);
}
