import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S T A T  T A B L E  &  G R A P H S'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(child: 
          DChartBarO(
            groupList: [
              OrdinalGroup(
                id: '1',
                data: [
                  OrdinalData(domain: 'Mon', measure: 2, color: Colors.pink[900]),
                  OrdinalData(domain: 'Tue', measure: 6, color: Colors.pink[900]),
                  OrdinalData(domain: 'Wed', measure: 3, color: Colors.pink[900]),
                  OrdinalData(domain: 'Thu', measure: 7, color: Colors.pink[900]),
                ],
              ),
            ],
          ),
          )])
    );
  }
}