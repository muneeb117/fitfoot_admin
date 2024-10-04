
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_data.dart';
import '../../../models/video.dart';
import '../../../utils/colors.dart';

class VideoDetailsGraph extends StatelessWidget {
  final Video video;

  const VideoDetailsGraph({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    // Create data for the graph
    final List<ChartData> data = [
      ChartData('Likes', video.likeList.length),
      ChartData('Comments', video.totalComment),
      ChartData('Shares', video.totalShare),
    ];

    return SfCartesianChart(
      backgroundColor:      AppColors.primarySecondaryBackground,

      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Video Interaction Details'),
      series: <LineSeries<ChartData, String>>[
        LineSeries<ChartData, String>(
          color: AppColors.primaryElementStatus,
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      ],
    );
  }
}

