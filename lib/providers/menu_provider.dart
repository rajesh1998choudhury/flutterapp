// lib/providers/menu_provider.dart

import 'package:flutter/material.dart';
import 'package:flutterapp/models/menu_list_model.dart';
import 'package:flutterapp/services/api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MenuProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  MenuListModel? _menuList;
  bool _isLoading = false;
  String? _error;

  MenuListModel? get menuList => _menuList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMenuList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString('customer_id') ?? '1115';
      String hotelId = '15';

      _menuList = await _apiService.fetchMenuList(
        customerId: customerId,
        hotelId: hotelId,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
