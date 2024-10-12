// lib/widgets/menu_item_widget.dart

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutterapp/models/menu_list_model.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MenuItemWidget extends StatefulWidget {
  const MenuItemWidget({super.key, required this.menuItem});

  final Datum menuItem;

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  int quantity = 0;
  String size = 'Multi-size';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.18,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.menuItem.image != null &&
                          widget.menuItem.image!.isNotEmpty
                      ? Image.network(
                          widget.menuItem.image.toString(),
                          width: MediaQuery.sizeOf(context).width * 0.30,
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/photo.png',
                              width: MediaQuery.sizeOf(context).width * 0.30,
                              height: MediaQuery.sizeOf(context).height * 0.15,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/images/no_image.png',
                          width: 50,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    widget.menuItem.name ?? 'No Name',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.menuItem.description ?? 'No Description',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const SizedBox(height: 4),
                      // Add food type symbol here
                      widget.menuItem.foodType == 'Veg'
                          ? Image.asset(
                              'assets/veg.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/non-veg.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                      const SizedBox(width: 4),
                      _buildStarRating(widget.menuItem.rating ?? 0),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹${widget.menuItem.regularOriginalPrice ?? 0}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${widget.menuItem.regularDiscountedPrice ?? 0}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (quantity > 0) ...[
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 0) {
                                quantity--;
                              }
                            });
                          },
                        ),
                        Text(quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () async {
                        await cartProvider.addToCart(
                          menuId: widget.menuItem.id ?? 0,
                          partnerId: widget.menuItem.partnerId ?? 0,
                          quantity: quantity,
                          size: size,
                          amount:
                              (widget.menuItem.discountedPrice ?? 0) * quantity,
                        );
                        if (cartProvider.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(cartProvider.error!)),
                          );
                        } else {
                          setState(() {
                            quantity = 1;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStarRating(double rating) {
  List<Widget> stars = [];
  for (int i = 0; i < 5; i++) {
    stars.add(
      Icon(
        i < rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 16,
      ),
    );
  }
  return Row(children: stars);
}
