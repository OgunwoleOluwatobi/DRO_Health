import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String name;
  final String image;
  final String price;
  final String description;
  final String category;
  final String company;
  final String packSize;
  final String constituent;
  final String dispenseType;
  final String productId;

  Item({this.name, this.image, this.price, this.description, this.category, this.company, this.packSize, this.constituent, this.dispenseType, this.productId});

  @override
  List<Object> get props => [this.name, this.image, this.description, this.category];
  
}