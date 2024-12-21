import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/joke_type_card.dart';
import 'jokes_list_screen.dart';
import 'random_joke_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    _loadJokeTypes();
  }

  Future<void> _loadJokeTypes() async {
    try {
      final types = await _apiService.getJokeTypes();
      setState(() {
        jokeTypes = types;
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
        title: const Text('Joke Types'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton.icon(
              icon: const Icon(Icons.shuffle, color: Colors.black),
              label: const Text(
                'Random Joke',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RandomJokeScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
        ),
        itemCount: jokeTypes.length,
        itemBuilder: (context, index) {
          return JokeTypeCard(
            type: jokeTypes[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokesListScreen(
                    jokeType: jokeTypes[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}