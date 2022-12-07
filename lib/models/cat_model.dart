import 'dart:convert';

class Cat {
  final int?id;
  final String Name;
  final String Race;
  final String Image;
  final String Food;

  Cat(
  {
    this.id,  required this.Name, required this.Race, required this.Image, required this.Food
  }
  );
  factory Cat.formMap(Map<String, dynamic> json) => 
    Cat(id: json['id'], Name: json['Name'], Race: json['Race'], Image: json['Image'], Food: json['Food']);

    Map<String, dynamic> toMap(){
      return{
        'id': id,
        'Name': Name,
        'Race': Race,
        'Image': Image,
        'Food': Food,
      };
    }
}