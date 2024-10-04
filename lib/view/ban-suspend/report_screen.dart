import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/report_model.dart';
import 'report_detail_screen.dart';

class BanSuspendScreen extends StatefulWidget {
  const BanSuspendScreen({super.key});

  @override
  _BanSuspendScreenState createState() => _BanSuspendScreenState();
}

class _BanSuspendScreenState extends State<BanSuspendScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Report>> fetchReportsStream() {
    return _firestore.collection('reports').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Report.fromSnap(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Report>>(
        stream: fetchReportsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching reports'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reports available.'));
          }
          List<Report> reports = snapshot.data!;

          return ListView(
            children: [
               Padding(
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    const  Text(
                      "Report Screen",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 6,),
                    SizedBox(
                      height: 35,
                        width: 35,
                        child: Image.asset("assets/banned.png"))
                  ],
                ),
              ),
              ...reports.map((report) => Card(
                elevation: 1,
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                color: Colors.white,
                child: ListTile(
                  title: Align(
                    alignment: report.additionalDetails.isEmpty ? Alignment.centerLeft : Alignment.centerLeft,
                    child: Text(
                      report.reason,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  subtitle: report.additionalDetails.isNotEmpty
                      ? Text(
                    report.additionalDetails,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                      : null,
                  leading:  SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset("assets/report.png"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(
                          report: report,
                          onActionTaken: () => setState(() {}),
                        ),
                      ),
                    );
                  },
                ),
              )),
            ],
          );
        },
      ),
    );
  }
}
