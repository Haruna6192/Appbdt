import 'package:th_0809/app/model/bill.dart';
import 'package:flutter/material.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: bill.length,
        itemBuilder: (context, index) {
        var data = bill[index];
        return Column(
          children: [
            Text(data.productName),
            Text(data.imageUrl),
            Text(data.price.toString()),
            Text(data.total.toString()),
          ],
        );
      },),
    );
  }
}