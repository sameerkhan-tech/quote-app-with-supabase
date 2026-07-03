import 'package:quote_app_with_supabase/features/quote/data/datasources/quotes_remote_datasource.dart';
import 'package:quote_app_with_supabase/features/quote/data/repositories/quote_repository.dart';
import 'package:quote_app_with_supabase/features/quote/model/quote_model.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuotesRemoteDatasource _quoteRemoteDatasource;
  const QuoteRepositoryImpl(QuotesRemoteDatasource quoteRemoteDatasource)
    : _quoteRemoteDatasource = quoteRemoteDatasource;
  @override
  Future<List<QuoteModel>> fetchQuotes() async {
    final quotes = await _quoteRemoteDatasource.fetchQuotes();
    return quotes;
  }
}
