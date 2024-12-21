import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokesListScreen extends StatefulWidget {
  final String jokeType;

  const JokesListScreen({
    Key? key,
    required this.jokeType,
  }) : super(key: key);

  @override
  _JokesListScreenState createState() => _JokesListScreenState();
}

class _JokesListScreenState extends State<JokesListScreen> {
  final ApiService _apiService = ApiService();
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    try {
      final loadedJokes = await _apiService.getJokesByType(widget.jokeType);
      setState(() {
        jokes = loadedJokes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType} Jokes'),
      ),
      body: ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(jokes[index].setup),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    jokes[index].punchline,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}