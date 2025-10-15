// Versión simplificada del modelo para recibir JSON y mostrar en UI.

import 'package:find_your_home_test/modules/house/domain/entities/house_detail.dart';

class HousePreviewModel extends HouseDetail {

  const HousePreviewModel({
    super.id,
    super.title,
    super.image,
    super.city,
    super.price,
  });

  factory HousePreviewModel.fromJson(Map<String, dynamic> json) {
    double _parseDouble(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString().replaceAll(',', '.')) ?? 0;
    }

    return HousePreviewModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      price: _parseDouble(json['price']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'city': city,
        'price': price,
      };

  HousePreviewModel copyWith({
    String? id,
    String? title,
    String? image,
    String? city,
    double? price,
  }) {
    return HousePreviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      city: city ?? this.city,
      price: price ?? this.price,
    );
  }
}
