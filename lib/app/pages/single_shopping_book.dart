import 'package:book_store/app/providers/cart_provider.dart';
import 'package:book_store/app/utilites/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleShoppingBook extends ConsumerWidget {
  final Book book;
  const SingleShoppingBook({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsProvider = ref.watch(cartProvider.notifier);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.image,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text('Count: ${book.quantity}'),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '${book.price * book.quantity} \$ ',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 113, 93, 32)),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    cartItemsProvider.removeFromCart(book);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
