// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Stock {
  final DateTime date;
  final double price;

  Stock({required this.date, required this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.toIso8601String,
      'price': price,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      date: DateTime.parse(map['date']),
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) =>
      Stock.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Stock(date: $date, price: $price)';
}
