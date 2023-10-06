import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/src/core/data/remote/app_dio.dart';
import 'package:quotes_app/src/models/quote.dart';

typedef QuotesRepoData = ({List<Quote>? quotes, DioException? failure});

final quotesRepoProvider = Provider((ref) {
  final api = ref.watch(dioProvider);
  return QuotesRepo(dioInstance: api);
});

class QuotesRepo {
  final Dio _dioInstance;

  QuotesRepo({required Dio dioInstance}) : _dioInstance = dioInstance;

  Future<QuotesRepoData> getQuotes() async {
    try {
      final response = await _dioInstance.get('/quotes',
          options: Options(
            responseType: ResponseType.json,
          ));
      List<Quote> quotesData = [];
      final jsonResp = jsonDecode(response.data);
      for(final quote in jsonResp){
        quotesData.add(Quote.fromJson(quote));
      }
      return (quotes: quotesData, failure: null);
    } on DioException catch (e) {
      return (quotes: null, failure: e);
    }
  }
}
