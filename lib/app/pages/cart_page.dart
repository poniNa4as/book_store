import 'package:book_store/app/pages/single_shopping_book.dart';
import 'package:book_store/app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsync = ref.watch(cartProvider);
    final cartProviderNotifier  = ref.read(cartProvider.notifier);
    final totalPrice = cartItemsAsync.maybeWhen(
      data: (cartItems) => cartItems.fold<double>(0,(acc, curr) => acc + (curr.price * curr.quantity)).toDouble(),
      orElse: () => 0,
      );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => cartProviderNotifier.clearCart(), icon: const Icon(Icons.remove_shopping_cart_rounded))
        ],
        backgroundColor: Colors.transparent,
        title: const Text('Shopping cart', style: TextStyle(fontFamily: 'Tagesschrift'),),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/images/bgbook1.avif',),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Список товаров
         cartItemsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error'),),
          data: (cartItems) => ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (_, index) {
              final item = cartItems[index];
              return SingleShoppingBook(book: item);
            }
            )
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 107, 238, 166),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Без скруглений
                  ),
                ),
                onPressed: () {
                  // Логика для оформления покупки
                },
                child: Text(
                  'Buy $totalPrice \$',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
