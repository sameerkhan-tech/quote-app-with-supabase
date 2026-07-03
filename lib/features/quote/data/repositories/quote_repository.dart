import 'package:quote_app_with_supabase/features/quote/model/quote_model.dart';

abstract class QuoteRepository {
  Future<List<QuoteModel>> fetchQuotes();
}
