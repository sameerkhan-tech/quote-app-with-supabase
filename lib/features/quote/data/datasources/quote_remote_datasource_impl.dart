import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:quote_app_with_supabase/core/error/app_exception.dart';
import 'package:quote_app_with_supabase/features/quote/data/datasources/quotes_remote_datasource.dart';
import 'package:quote_app_with_supabase/features/quote/model/quote_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuotesRemoteDatasourceImpl implements QuotesRemoteDatasource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<QuoteModel>> fetchQuotes() async {
    final hasInternet =
        await InternetConnection.createInstance().hasInternetAccess;
    if (!hasInternet) {
      throw AppException(
        'No internet connection please check you internet and try again',
      );
    }
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('quotes')
          .select();
      final List<QuoteModel> quotes = response
          .map((e) => QuoteModel.fromMap(e))
          .toList();
      return quotes;
    } on PostgrestException catch (e) {
      throw AppException(e.message);
    } on TimeoutException {
      throw AppException(
        'Request timeout please check your internet connection',
      );
    } catch (e) {
      throw AppException('Unknown exception');
    }
  }
}
