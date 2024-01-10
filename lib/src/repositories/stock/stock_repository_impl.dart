import 'dart:convert';
import 'dart:developer';
import 'dart:js_interop';

import 'package:intl/intl.dart';
import 'package:my_stock/src/core/global/constants.dart';
import 'package:my_stock/src/models/stock.dart';
import 'package:my_stock/src/repositories/stock/stock_repository.dart';
import 'package:http/http.dart' as http;

import '../../core/env/env.dart';

class StockRepositoryImpl implements StockRepository {
  final client = http.Client();
  final String path = Env.instance.get(Constants.BACKEND_BASE_URL_KEY);

  @override
  Future<List<Stock>> fecthByDateInterval(
      String symbol, DateTime inicialDate, DateTime endDate) async {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(
        (endDate.millisecondsSinceEpoch / 1000).round() * 1000);
    String formattedDate = DateFormat.yMMMMd('pt_BR').format(data);

    log((inicialDate.millisecondsSinceEpoch / 1000).round().toString());
    log((endDate.millisecondsSinceEpoch / 1000).round().toString());

    final queryParameters = {
      'interval': '1d',
      'period1': (inicialDate.millisecondsSinceEpoch / 1000).round().toString(),
      'period2': (endDate.millisecondsSinceEpoch / 1000).round().toString(),
    };

    final url =
        Uri.parse('$path/$symbol').replace(queryParameters: queryParameters);

    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> timestamps = data['chart']['result'][0]['timestamp'];
        List<dynamic> prices =
            data['chart']['result'][0]['indicators']['quote'][0]['open'];

        return _fetchLast30days(timestamps, prices);
      }
    } catch (e, s) {
      log('erro fetching data', error: e, stackTrace: s);
      throw Exception(e.toString());
    } finally {
      client.close();
    }
    return [];
  }

  //https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA?range=1mo
  //https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA?range=1mon

  List<Stock> _fetchLast30days(List<dynamic> timestamp, List<dynamic> price) {
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
