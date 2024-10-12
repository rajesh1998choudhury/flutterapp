// lib/models/show_cart_model.dart

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ShowCartModel showCartModelFromJson(String str) =>
    ShowCartModel.fromJson(json.decode(str));

String showCartModelToJson(ShowCartModel data) => json.encode(data.toJson());

class ShowCartModel {
  List<Datum>? data;

  ShowCartModel({
    this.data,
  });

  factory ShowCartModel.fromJson(Map<String, dynamic> json) => ShowCartModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.menuId,
    this.customerId,
    this.partnerId,
    this.quantity,
    this.menuName,
    this.menuImage,
    this.menuPrice,
    this.uploadedFrom,
    this.size,
    this.createdAt,
    this.updatedAt,
    this.hotelName,
  });

  int? id;
  int? menuId;
  String? customerId;
  int? partnerId;
  int? quantity;
  MenuName? menuName;
  MenuImage? menuImage;
  int? menuPrice;
  UploadedFrom? uploadedFrom;
  Size? size;
  DateTime? createdAt;
  DateTime? updatedAt;
  HotelName? hotelName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        menuId: json["menu_id"],
        customerId: json["customer_id"],
        partnerId: json["partner_id"],
        quantity: json["quantity"],
        menuName: menuNameValues.map[json["menu_name"]],
        menuImage: menuImageValues.map[json["menu_image"]],
        menuPrice: json["menu_price"],
        uploadedFrom: uploadedFromValues.map[json["uploaded_from"]],
        size: sizeValues.map[json["size"]],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        hotelName: hotelNameValues.map[json["hotel_name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menu_id": menuId,
        "customer_id": customerId,
        "partner_id": partnerId,
        "quantity": quantity,
        "menu_name": menuNameValues.reverse[menuName],
        "menu_image": menuImageValues.reverse[menuImage],
        "menu_price": menuPrice,
        "uploaded_from": uploadedFromValues.reverse[uploadedFrom],
        "size": sizeValues.reverse[size],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "hotel_name": hotelNameValues.reverse[hotelName],
      };
}

enum HotelName { TESTING_RESTURANT }

final hotelNameValues =
    EnumValues({"Testing resturant": HotelName.TESTING_RESTURANT});

enum MenuImage {
  PUBLIC_STORAGE_IMAGE_MENU_151707715463764,
  PUBLIC_STORAGE_IMAGE_MENU_151718965989831
}

final menuImageValues = EnumValues({
  "/public/storage/image/menu/151707715463764":
      MenuImage.PUBLIC_STORAGE_IMAGE_MENU_151707715463764,
  "/public/storage/image/menu/151718965989831":
      MenuImage.PUBLIC_STORAGE_IMAGE_MENU_151718965989831
});

enum MenuName { CRISPY_WINGS, TESTING_FOOD_1 }

final menuNameValues = EnumValues({
  "Crispy \ud83d\udc14 wings": MenuName.CRISPY_WINGS,
  "Testing food 1": MenuName.TESTING_FOOD_1
});

enum Size { MULTI_SIZE }

final sizeValues = EnumValues({"Multi-size": Size.MULTI_SIZE});

enum UploadedFrom { MOBILE }

final uploadedFromValues = EnumValues({"Mobile": UploadedFrom.MOBILE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
