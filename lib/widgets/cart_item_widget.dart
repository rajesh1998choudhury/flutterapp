// lib/widgets/cart_item_widget.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/show_cart_model.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final Datum cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.12,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 1),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartItem.menuName?.name ?? 'No Name',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('₹${cartItem.menuPrice ?? 0}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: () {
                          cartProvider.updateQuantity(
                            cartId: cartItem.id ?? 0,
                            status: 'Remove',
                          );
                        },
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () {
                          cartProvider.updateQuantity(
                            cartId: cartItem.id ?? 0,
                            status: 'Add',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cartItem.menuImage != null
                    ? Image.network(
                        'https://thealaddin.in${cartItem.menuImage.toString()}',
                        width: MediaQuery.sizeOf(context).width * 0.18,
                        height: MediaQuery.sizeOf(context).height * 0.18,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/photo.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/photo.png',
                        width: MediaQuery.sizeOf(context).width * 0.18,
                        height: MediaQuery.sizeOf(context).height * 0.18,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
