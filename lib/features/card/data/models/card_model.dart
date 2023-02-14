import 'package:card/features/card/domain/entities/CardEntity.dart';

class CardModel extends CardEntity {
  CardModel(
      {required String name,
      required double price,
      required String image,
      required int? id,
      bool? selected,
      int? countOfNeeded,
      required int count})
      : super(
            name: name,
            price: price,
            image: image,
            id: id,
            selected: false,
            countOfNeeded: 0,
            count: count);
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        price: json['price'] ?? '',
        image: json['image'] ?? '',
        selected: json['selected'] ?? false,
        countOfNeeded: json['countOfNeeded'] ?? 0,
        count: json['count'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'selected': selected,
      'countOfNeeded': countOfNeeded,
      'price': price,
      'count': count
    };
  }
}
