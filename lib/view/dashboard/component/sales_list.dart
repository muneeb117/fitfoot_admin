import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesList extends StatelessWidget {
  final Map<String, double> salesData;
  final double totalSales;

  const SalesList({super.key, required this.salesData, required this.totalSales});

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    List<String> productNames = salesData.keys.toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: productNames.length,
      itemBuilder: (context, index) {
        String productName = productNames[index];
        double productSales = salesData[productName]!;
        double salesPercentage = (productSales / totalSales) * 100;

        return Card(
          elevation: 0,
          color: Colors.white,
          shadowColor: Colors.grey[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Text(
                  "Sales: PKR ${productSales.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                        dataSource: [
                          ChartData('Sales', salesPercentage, Colors.green),
                          ChartData('Remaining', 100 - salesPercentage, Colors.grey[300]!),
                        ],
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        pointColorMapper: (ChartData data, _) => data.color,
                        dataLabelSettings: const DataLabelSettings(isVisible: false),
                        radius: '70%',
                        innerRadius: '50%',
                        animationDuration: 1500, // Animation for the doughnut chart
                        animationDelay: 500, // Delay before animation starts
                      ),
                    ],
                  ),
                ),
                Text(
                  "${salesPercentage.toStringAsFixed(2)}% of total sales",
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}
