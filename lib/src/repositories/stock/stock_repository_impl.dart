import 'dart:convert';
import 'dart:developer';

import 'package:my_stock/src/core/global/constants.dart';
import 'package:my_stock/src/models/stock.dart';
import 'package:my_stock/src/repositories/stock/stock_repository.dart';
import 'package:http/http.dart' as http;

import '../../core/env/env.dart';
import '../../core/exceptions/repository_exeception.dart';

class StockRepositoryImpl implements StockRepository {
  final client = http.Client();
  final String path = Env.instance.get(Constants.BACKEND_BASE_URL_KEY);

  @override
  Future<List<Stock>> fecthByDateInterval(
      String symbol, DateTime inicialDate, DateTime endDate) async {
    final queryParameters = {
      'interval': '1d',
      'period1': (inicialDate.millisecondsSinceEpoch / 1000).round().toString(),
      'period2': (endDate.millisecondsSinceEpoch / 1000).round().toString(),
    };

    final url =
        Uri.parse('$path/$symbol').replace(queryParameters: queryParameters);

    try {
      final response = await client.get(url);
      log(response.statusCode.toString());
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          List<dynamic> timestamps = data['chart']['result'][0]['timestamp'];
          List<dynamic> prices =
              data['chart']['result'][0]['indicators']['quote'][0]['open'];
          return _fillData(timestamps, prices);

        case 400:
          throw RepositoryException(message: 'Erro ao processar requisição');

        case 404:
          throw RepositoryException(
              message: 'Servidor temporariamente indisponível');
        default:
          return [];
      }
    } on Error catch (e, s) {
      log('erro fetching data', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao consultar dados');
    }
  }

  List<Stock> _fillData(List<dynamic> timestamp, List<dynamic> price) {
    List<Stock> stocksList = [];
    for (var i = 0; i < timestamp.length; i++) {
      stocksList.add(
        Stock(
          date: DateTime.fromMillisecondsSinceEpoch(timestamp[i] * 1000),
          price: double.parse(price[i].toString()),
        ),
      );
    }
    log(stocksList.toString());
    return stocksList;
  }
}
