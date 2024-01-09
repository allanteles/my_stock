import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_stock/src/core/global/constants.dart';
import 'package:my_stock/src/models/stock.dart';
import 'package:my_stock/src/repositories/stock/stock_repository.dart';
import 'package:http/http.dart' as http;

class StockRepositoryImpl implements StockRepository {
  final url = Uri.https(DotEnv().get(Constants.BACKEND_BASE_URL_KEY));

  final client = http.Client();

  @override
  Future<List<Stock>> fecthAllData(String symbol) async {
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {}
      final data = jsonDecode(response.body);
    } catch (e, s) {
      log('erro fetching data', error: e, stackTrace: s);
      throw Exception();
    } finally {
      client.close();
    }
  }
}
