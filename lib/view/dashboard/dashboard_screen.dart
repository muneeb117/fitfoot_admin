import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/responsive.dart';
import 'component/header.dart';
import 'component/user_graph.dart';
import 'component/sales_list.dart';
import 'component/sales_target.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<int> fetchTotalUsersRealTime() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.length; // Number of registered users
    });
  }

  Stream<Map<String, double>> fetchAggregatedSalesRealTime() {
    return _firestore.collection('sales_log').snapshots().map((querySnapshot) {
      Map<String, double> aggregatedSales = {};

      for (var doc in querySnapshot.docs) {
        String productName = doc['product_name'];
        double sales = (doc['amount'] as num).toDouble();

        if (aggregatedSales.containsKey(productName)) {
          aggregatedSales[productName] = aggregatedSales[productName]! + sales;
        } else {
          aggregatedSales[productName] = sales;
        }
      }

      return aggregatedSales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(), // Custom header at the top of the page
              const SizedBox(height: 30),
              ResponsiveWidget.isLargeScreen(context)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2, // Sales graph takes more space
                          child: _buildSalesSection(),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1, // User graph takes less space
                          child: UserGraphStreamBuilder(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildSalesSection(),
                        const SizedBox(height: 20),
                        UserGraphStreamBuilder(),
                      ],
                    ),
              const SizedBox(height: 30),
              _buildSalesListSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Sales graph section
  Widget _buildSalesSection() {
    return StreamBuilder<Map<String, double>>(
      stream: fetchAggregatedSalesRealTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Text('Loading sales data...');
        }
        double totalSales =
            snapshot.data!.values.fold(0, (sum, sales) => sum + sales);
        return SalesUploadGraph(totalSales: totalSales);
      },
    );
  }

  // Sales list section
  Widget _buildSalesListSection() {
    return StreamBuilder<Map<String, double>>(
      stream: fetchAggregatedSalesRealTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Text('Loading sales data...');
        }
        double totalSales =
            snapshot.data!.values.fold(0, (sum, sales) => sum + sales);
        return SalesList(salesData: snapshot.data!, totalSales: totalSales);
      },
    );
  }

  // User graph stream
  Widget UserGraphStreamBuilder() {
    return StreamBuilder<int>(
      stream: fetchTotalUsersRealTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Text('Error fetching user data');
        }
        int totalUsers = snapshot.data!;
        return UserGraph(totalUsers: totalUsers);
      },
    );
  }
}
