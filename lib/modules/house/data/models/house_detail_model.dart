// Versión simplificada del modelo para recibir JSON y mostrar en UI.

import 'package:find_your_home_test/modules/house/domain/entities/house_detail.dart';

class HouseDetailModel extends HouseDetail {

  const HouseDetailModel({
    super.id,
    super.title,
    super.image,
    super.city,
    super.price,
    super.description,
    super.address,
    super.houseNumber,
    super.zipCode,
    super.createdAt,
  });

  factory HouseDetailModel.fromJson(Map<String, dynamic> json) {
    double _parseDouble(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString().replaceAll(',', '.')) ?? 0;
    }

    return HouseDetailModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      price: _parseDouble(json['price']),
      description: (json['description'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      houseNumber: (json['house_number'] ?? '').toString(),
      zipCode: (json['zip_code'] ?? '').toString(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'city': city,
        'price': price,
        'description': description,
        'address': address,
        'house_number': houseNumber,
        'zip_code': zipCode,
        'createdAt': createdAt?.toIso8601String(),
      };

  HouseDetailModel copyWith({
    String? id,
    String? title,
    String? image,
    String? city,
    double? price,
    String? description,
    String? address,
    String? houseNumber,
    String? zipCode,
    DateTime? createdAt,
  }) {
    return HouseDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      city: city ?? this.city,
      price: price ?? this.price,
      description: description ?? this.description,
      address: address ?? this.address,
      houseNumber: houseNumber ?? this.houseNumber,
      zipCode: zipCode ?? this.zipCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
