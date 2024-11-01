import 'package:flutter/material.dart';
import '../models/product.dart';
import '../components/cart_item.dart';
import '../components/cart_button.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartItems;
  final Map<Product, int> itemCounts;
  final VoidCallback onCheckout;
  final Function(Product) removeFromCart;
  final Function(Product) onIncreaseQuantity;
  final Function(Product) onDecreaseQuantity;

  CartPage({
    required this.cartItems,
    required this.itemCounts,
    required this.onCheckout,
    required this.removeFromCart,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0,
          (sum, item) => sum + (item.price * itemCounts[item]!),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Корзина',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                final quantity = itemCounts[product]!;
                return CartItem(
                  product: product,
                  quantity: quantity,
                  onRemove: () => removeFromCart(product),
                  onIncreaseQuantity: () => onIncreaseQuantity(product),
                  onDecreaseQuantity: () => onDecreaseQuantity(product),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Сумма',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$totalPrice ₽',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CartButton(onPressed: onCheckout, text: 'Перейти к оформлению заказа'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
