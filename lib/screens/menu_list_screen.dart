// lib/screens/menu_list_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:flutterapp/providers/menu_provider.dart';
import 'package:flutterapp/screens/cart_screen.dart';
import 'package:flutterapp/widgets/menu_item_widget.dart';
import 'package:provider/provider.dart';

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({super.key});

  @override
  _MenuListScreenState createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuProvider>(context, listen: false).fetchMenuList();
    Provider.of<CartProvider>(context, listen: false).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
              ),
              if (cartProvider.total > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      cartProvider.total.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: menuProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : menuProvider.error != null
              ? Center(child: Text(menuProvider.error!))
              : ListView.builder(
                  itemCount: menuProvider.menuList?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final menuItem = menuProvider.menuList!.data![index];
                    return MenuItemWidget(menuItem: menuItem);
                  },
                ),
    );
  }
}
