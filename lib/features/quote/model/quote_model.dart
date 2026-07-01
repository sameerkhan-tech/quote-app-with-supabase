class QuoteModel {
  final String id;
  final String quote;
  final String? author;

  const QuoteModel({required this.id, required this.quote, this.author});

  factory QuoteModel.fromMap(Map<String, dynamic> map) => QuoteModel(
    id: map['id'] as String,
    quote: map['quote'] as String,
    author: map['author'] as String?,
  );

  QuoteModel copyWith({String? id, String? quote, String? author}) =>
      QuoteModel(
        id: id ?? this.id,
        quote: quote ?? this.quote,
        author: author ?? this.author,
      );
}
