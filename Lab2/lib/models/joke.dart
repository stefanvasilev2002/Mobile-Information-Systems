// models/joke.dart
class Joke {
  final String type;
  final String setup;
  final String punchline;
  final int id;
  bool isFavorite;  // Додадено ново поле

  Joke({
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
    this.isFavorite = false,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
      id: json['id'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}