// lib/models/menu_list_model.dart

import 'dart:convert';

MenuListModel menuListModelFromJson(String str) =>
    MenuListModel.fromJson(json.decode(str));

String menuListModelToJson(MenuListModel data) => json.encode(data.toJson());

class MenuListModel {
  List<Datum>? data;
  Pagination? pagination;

  MenuListModel({
    this.data,
    this.pagination,
  });

  factory MenuListModel.fromJson(Map<String, dynamic> json) => MenuListModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.partnerId,
    this.partnerName,
    this.hotelName,
    this.foodCategoryId,
    this.foodCategoryName,
    this.foodType,
    this.sizeType,
    this.originalPrice,
    this.discountedPrice,
    this.regularOriginalPrice,
    this.regularDiscountedPrice,
    this.mediumOriginalPrice,
    this.mediumDiscountedPrice,
    this.largeOriginalPrice,
    this.largeDiscountedPrice,
    this.extraLargeOriginalPrice,
    this.extraLargeDiscountedPrice,
    this.originalPriceAfterCommission,
    this.discountedPriceAfterCommission,
    this.image,
    this.status,
    this.numberOfOrder,
    this.rating,
    this.uploadedFrom,
    this.createdAt,
    this.updatedAt,
    this.cartQuantity,
    this.cartId,
    this.hotelStatus,
    this.partner,
  });

  int? id;
  String? name;
  String? description;
  int? partnerId;
  String? partnerName;
  String? hotelName;
  int? foodCategoryId;
  String? foodCategoryName;
  String? foodType;
  String? sizeType;
  int? originalPrice;
  int? discountedPrice;
  int? regularOriginalPrice;
  int? regularDiscountedPrice;
  int? mediumOriginalPrice;
  int? mediumDiscountedPrice;
  int? largeOriginalPrice;
  int? largeDiscountedPrice;
  int? extraLargeOriginalPrice;
  int? extraLargeDiscountedPrice;
  int? originalPriceAfterCommission;
  int? discountedPriceAfterCommission;
  String? image;
  String? status;
  int? numberOfOrder;
  double? rating;
  String? uploadedFrom;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? cartQuantity;
  int? cartId;
  String? hotelStatus;
  dynamic partner;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        partnerId: json["partner_id"],
        partnerName: json["partner_name"],
        hotelName: json["hotel_name"],
        foodCategoryId: json["food_category_id"],
        foodCategoryName: json["food_category_name"],
        foodType: json["food_type"],
        sizeType: json["size_type"],
        originalPrice: json["original_price"],
        discountedPrice: json["discounted_price"],
        regularOriginalPrice: json["regular_original_price"],
        regularDiscountedPrice: json["regular_discounted_price"],
        mediumOriginalPrice: json["medium_original_price"],
        mediumDiscountedPrice: json["medium_discounted_price"],
        largeOriginalPrice: json["large_original_price"],
        largeDiscountedPrice: json["large_discounted_price"],
        extraLargeOriginalPrice: json["extra_large_original_price"],
        extraLargeDiscountedPrice: json["extra_large_discounted_price"],
        originalPriceAfterCommission: json["original_price_after_commission"],
        discountedPriceAfterCommission:
            json["discounted_price_after_commission"],
        image: json["image"],
        status: json["status"],
        numberOfOrder: json["number_of_order"],
        rating: json["rating"]?.toDouble(),
        uploadedFrom: json["uploaded_from"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        cartQuantity: json["cart_quantity"],
        cartId: json["cart_id"],
        hotelStatus: json["hotel_status"],
        partner: json["partner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "partner_id": partnerId,
        "partner_name": partnerName,
        "hotel_name": hotelName,
        "food_category_id": foodCategoryId,
        "food_category_name": foodCategoryName,
        "food_type": foodType,
        "size_type": sizeType,
        "original_price": originalPrice,
        "discounted_price": discountedPrice,
        "regular_original_price": regularOriginalPrice,
        "regular_discounted_price": regularDiscountedPrice,
        "medium_original_price": mediumOriginalPrice,
        "medium_discounted_price": mediumDiscountedPrice,
        "large_original_price": largeOriginalPrice,
        "large_discounted_price": largeDiscountedPrice,
        "extra_large_original_price": extraLargeOriginalPrice,
        "extra_large_discounted_price": extraLargeDiscountedPrice,
        "original_price_after_commission": originalPriceAfterCommission,
        "discounted_price_after_commission": discountedPriceAfterCommission,
        "image": image,
        "status": status,
        "number_of_order": numberOfOrder,
        "rating": rating,
        "uploaded_from": uploadedFrom,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "cart_quantity": cartQuantity,
        "cart_id": cartId,
        "hotel_status": hotelStatus,
        "partner": partner,
      };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
      };
}
