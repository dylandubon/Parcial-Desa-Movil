import 'package:flutter/material.dart';
import 'package:movie/models/model.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;
  final String title;
  const MovieSlider({super.key, required this.movies, required this.onNextPage, required this.title});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController= new ScrollController();

  @override
  initialize(){
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels  >= scrollController.position.maxScrollExtent -500){
        widget.onNextPage();
      }
    });

  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(this.widget.title != null)
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(this.widget.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 5,),
            Expanded(child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index)=> 
              _MoviePoster( heroId: '${ widget.title }-$index-${ widget.movies[index] }.id', movie: widget.movies[index],)))
            
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;
  const _MoviePoster({super.key, required this.movie, required this.heroId});

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: NetworkImage('https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png'), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height:190,
                fit: BoxFit.cover,) ,
            ),
          )
        ]),
    );
  }
}