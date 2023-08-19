import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:movie/helpers/debouncer.dart';
import 'package:movie/models/model.dart';
import 'package:http/http.dart' as http;

import '../models/popular_response.dart';
import '../models/search_response.dart';
class MoviesProvider extends ChangeNotifier{
  String _apiKey = "1865f43a0549ca50d341dd9ab8b29f49";
  String _baseUrl = "api.themoviedb.org";
  String _languaje = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast ={};
  int _popularPage =0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Movie>> _suggesterStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestedStream => this._suggesterStreamController.stream;
  MoviesProvider(){
    print("Movies Provider has started");
    this.getOnDiplayMovies();
    this.getPopularMovies(); 
  }
  
  Future<String> _getJsonData(String endpoint, [int page = 1]) async{
    final url = Uri.https(_baseUrl,endpoint,{
      'api_key': _apiKey,
      'base_url': _baseUrl,
      'page': '$page'
    });
    final response = await http.get(url);
    return response.body;

  }
  Future<String> _getJsonDataWithQuery(String endpoint, query) async{
    final url = Uri.https(_baseUrl,endpoint,{
      'api_key': _apiKey,
      'base_url': _baseUrl,
      'query': query
    });
    final response = await http.get(url);
    return response.body;

  }

  getOnDiplayMovies() async  {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
  
  getPopularMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final jsonData = await this._getJsonDataWithQuery('3/movie/search', query);
    final searchMovieResponse = SearchResponse.fromJson(jsonData);
    return searchMovieResponse.results;
  }

  //para auto complete
  void getSuggestionByQuery(String searchTerm){
    debouncer.value ='';  
    debouncer.onValue= ( value ) async{
      final results = await this.searchMovie(value);
      this._suggesterStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds:301)).then((value) => timer.cancel());
  }
}