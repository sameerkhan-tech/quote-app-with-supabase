import 'package:quote_app_with_supabase/features/quote/model/quote_model.dart';

abstract interface class QuotesRemoteDatasource {
  Future<List<QuoteModel>> fetchQuotes();
}
