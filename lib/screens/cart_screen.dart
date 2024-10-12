// lib/screens/cart_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:flutterapp/style/color.dart';
import 'package:flutterapp/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Your Cart'),
      ),
      body: cartProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartProvider.error != null
              ? Center(child: Text(cartProvider.error!))
              : cartProvider.cart == null ||
                      cartProvider.cart!.data == null ||
                      cartProvider.cart!.data!.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartProvider.cart!.data!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final cartItem = cartProvider.cart!.data![index];
                              return CartItemWidget(cartItem: cartItem);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Selected Address',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                const Text('wefft, Mumbai, Maharashtra, 451234',
                                    style: TextStyle(fontSize: 14)),
                                const Divider(),
                                const Text('1 x testing 1',
                                    style: TextStyle(fontSize: 14)),
                                const SizedBox(height: 10),
                                Text('Sub Total  ₹${cartProvider.subAmount}',
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(height: 5),
                                const Text('Delivery Charges  ₹0',
                                    style: TextStyle(fontSize: 14)),
                                const SizedBox(height: 5),
                                Text('Total Bill  ₹${cartProvider.total}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Divider(),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.note_alt_outlined,
                                      color: Colors.orange),
                                  label: const Text(
                                      'Special cooking instructions',
                                      style: TextStyle(color: Colors.orange)),
                                  style: ElevatedButton.styleFrom(
                                    side:
                                        const BorderSide(color: Colors.orange),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Coupon Code',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(color: Colors.orange),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Cash on delivery',
                                  style: TextStyle(color: kTextColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kTextColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 500),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text(
                        //         'Total:',
                        //         style: TextStyle(
                        //             fontSize: 18, fontWeight: FontWeight.bold),
                        //       ),
                        //       Text(
                        //         '\$${cartProvider.total}',
                        //         style: const TextStyle(
                        //             fontSize: 18, fontWeight: FontWeight.bold),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
    );
  }
}
