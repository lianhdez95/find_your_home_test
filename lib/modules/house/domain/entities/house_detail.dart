import 'package:equatable/equatable.dart';

class HouseDetail extends Equatable {
  final String? id;
  final String? title;
  final String? image;
  final String? city;
  final double? price;
  final String? description;
  final String? address;
  final String? houseNumber;
  final String? zipCode;
  final DateTime? createdAt;

  const HouseDetail({
    this.id,
    this.title,
    this.image,
    this.city,
    this.price,
    this.description,
    this.address,
    this.houseNumber,
    this.zipCode,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        city,
        price,
        description,
        address,
        houseNumber,
        zipCode,
        createdAt,
      ];

  @override
  bool get stringify => true;
}