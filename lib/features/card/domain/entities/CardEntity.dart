import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String name;
  final int count;
  final int? id;
  late bool? selected;
  late int? countOfNeeded;
  final String image;
  final double price;

  CardEntity(
      {required this.name,
      required this.count,
      required this.image,
      this.countOfNeeded = 0,
      this.selected = false,
      this.id,
      required this.price});

  @override
  List<Object?> get props =>
      [count, name, image, id, countOfNeeded, selected, price];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,

      'price': price,
      'count': count
    };
  }
}
