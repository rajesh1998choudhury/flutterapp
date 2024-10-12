// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/models/menu_list_model.dart';
import 'package:flutterapp/models/show_cart_model.dart';

class ApiService {
  static const String baseUrl = 'https://thealaddin.in/mmApi/api';

  // Fetch Menu List
  Future<MenuListModel> fetchMenuList({
    required String customerId,
    required String hotelId,
  }) async {
    final Uri url = Uri.parse(
        '$baseUrl/show/menu-list?customer_id=$customerId&hotel_id=$hotelId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return menuListModelFromJson(response.body);
    } else {
      throw Exception('Failed to load menu list');
    }
  }

  // Add to Cart
  Future<bool> addToCart({
    required int menuId,
    required String customerId,
    required int partnerId,
    required int quantity,
    required String size,
    required int amount,
  }) async {
    final Uri url = Uri.parse('$baseUrl/add/cart');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "menu_id": menuId,
        "customer_id": customerId,
        "partner_id": partnerId,
        "quantity": quantity,
        "size": size,
        "amount": amount,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  // Add or Remove Quantity
  Future<bool> updateCartQuantity({
    required int cartId,
    required String status,
  }) async {
    final Uri url = Uri.parse('$baseUrl/add-remove/quantity/cart');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "cart_id": cartId,
        "status": status,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update cart quantity');
    }
  }

  // Show Cart
  Future<ShowCartModel> fetchCart({
    required String customerId,
  }) async {
    final Uri url = Uri.parse('$baseUrl/show/cart?customer_id=$customerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return showCartModelFromJson(response.body);
    } else {
      throw Exception('Failed to load cart');
    }
  }

  // Cart Total
  Future<int> fetchCartTotal({
    required String customerId,
  }) async {
    final Uri url = Uri.parse('$baseUrl/cart/total');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "customer_id": customerId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total'] ?? 0;
    } else {
      throw Exception('Failed to fetch cart total');
    }
  }
}
