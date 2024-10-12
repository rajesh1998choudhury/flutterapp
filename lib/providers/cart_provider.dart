// lib/providers/cart_provider.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterapp/models/show_cart_model.dart';
import 'package:flutterapp/services/api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  ShowCartModel? _cart;
  int _total = 0;
  bool _isLoading = false;
  String? _error;

  ShowCartModel? get cart => _cart;
  int get total => _total;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCart() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString('customer_id') ?? '1115';

      _cart = await _apiService.fetchCart(customerId: customerId);
      _total = await _apiService.fetchCartTotal(customerId: customerId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart({
    required int menuId,
    required int partnerId,
    required int quantity,
    required String size,
    required int amount,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString('customer_id') ?? '1115';

      bool success = await _apiService.addToCart(
        menuId: menuId,
        customerId: customerId,
        partnerId: partnerId,
        quantity: quantity,
        size: size,
        amount: amount,
      );

      if (success) {
        await fetchCart();
      } else {
        _error = 'Failed to add to cart';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateQuantity({
    required int cartId,
    required String status,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await _apiService.updateCartQuantity(
        cartId: cartId,
        status: status,
      );

      if (success) {
        await fetchCart();
      } else {
        _error = 'Failed to update cart quantity';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

//  // Fetch Cart Total
//   Future<dynamic> fetchCartTotal() async {
//     // try {
//       // bool success = await _apiService.fetchCartTotal(
//       //   customerId: customerId,
//       // );

//     //   if (success) {
//     //     await fetchCart();
//     //   } else {
//     //     _error = 'Failed to update cart total';
//     //   }
//     // } catch (e) {
//     //   _error = e.toString();
//     // }

//     // _isLoading = false;
//     // notifyListeners();
//   }
//---------------------------------------------------------
  double _subAmount = 0.0;

  double get subAmount => _subAmount;

  Future<void> fetchCartTotal(String customerId) async {
    const url = 'https://thealaddin.in/mmApi/api/cart/total';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'customer_id': customerId},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['data'] != null) {
          _subAmount = responseData['data']['sub_amount'].toDouble();
          notifyListeners();
        }
      } else {
        throw Exception('Failed to load cart total');
      }
    } catch (error) {
      rethrow;
    }
  }
}
