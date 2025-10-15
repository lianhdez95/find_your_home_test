import 'package:equatable/equatable.dart';

class HousePreview extends Equatable {
  final String? id;
  final String? title;
  final String? image;
  final String? city;
  final double? price;

  const HousePreview({
    this.id,
    this.title,
    this.image,
    this.city,
    this.price,
  });

  @override
  List<Object?> get props => [id, title, image, city, price];

  @override
  bool get stringify => true;
}