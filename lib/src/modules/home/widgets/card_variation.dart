import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardVariation extends StatelessWidget {
  final String day;
  final DateTime date;
  final double price;
  final double sequenceVariation;
  final double firstVariation;

  const CardVariation(
      {super.key,
      required this.day,
      required this.date,
      required this.price,
      required this.sequenceVariation,
      required this.firstVariation});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMd('pt_BR').format(date);

    return SizedBox(
      height: 25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(day),
          Text(formattedDate),
          Text(price.toStringAsFixed(2)),
          Text('${sequenceVariation.toStringAsFixed(2)}%'),
          Text('${firstVariation.toStringAsFixed(2)}%'),
        ],
      ),
    );
  }
}
