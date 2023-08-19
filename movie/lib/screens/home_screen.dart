import 'package:flutter/material.dart';
import 'package:movie/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvier = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())), 
          icon: Icon(Icons.search))
        ],
      ),

    );
  }
}