import 'package:flutter/material.dart';
import 'package:movie/models/model.dart';
import 'package:movie/models/pets.dart';

class PetsSlider extends StatefulWidget {

  final Pets pets;
  const PetsSlider({super.key, required this.pets});

  @override
  State<PetsSlider> createState() => _PetsSliderState();
}

class _PetsSliderState extends State<PetsSlider> {
 final ScrollController scrollController= new ScrollController(); 
  @override
  initialize(){
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels  >= scrollController.position.maxScrollExtent -500){
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
      
      
    );
  }
}