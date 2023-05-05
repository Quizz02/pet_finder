import 'package:flutter/material.dart';

import '../widgets/report_card.dart';

class Community extends StatefulWidget {
  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    // final StorageMethods storage = StorageMethods();
    return Scaffold(
        appBar: AppBar(title: const Text('Comunidad')),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ReportCard(),
        ));
  }
}
