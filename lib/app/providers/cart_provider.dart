import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_store/app/utilites/books.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartNotifier extends AsyncNotifier<List<Book>> {
  @override
  Future<List<Book>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getStringList('cart');
    if (cartJson != null) {
      final loadedCart = cartJson.map((bookString) {
        final bookMap = jsonDecode(bookString);
        return Book.fromJson(bookMap);
      }).toList();
      return loadedCart;
    }
    return [];
  }

  Future<void> addToCart(Book book) async {
    final currentCart = state.value ?? [];

    final index = currentCart.indexWhere((item) => item.id == book.id);
    List<Book> updatedCart;
    if (index != -1) {
      updatedCart = [
        for (final item in currentCart)
          if (item.id == book.id)
            item.copyWith(quantity: item.quantity + 1)
          else
            item,
      ];
    } else {
      updatedCart = [...currentCart, book];
    }

    state = AsyncValue.data(updatedCart);
    await _saveCart(updatedCart);
  }

  Future<void> removeFromCart(Book book) async {
    final currentCart = state.value ?? [];

    final updatedCart = currentCart
        .map((item) {
          if (item.id == book.id) {
            if (item.quantity > 1) {
              return item.copyWith(quantity: item.quantity - 1);
            } else {
              return null;
            }
          }
          return item;
        })
        .whereType<Book>()
        .toList();

    state = AsyncValue.data(updatedCart);
    await _saveCart(updatedCart);
  }

  Future<void> clearCart() async {
    state = const AsyncValue.data([]);
    await _saveCart([]);
  }

  Future<void> _saveCart(List<Book> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cart.map((book) => jsonEncode(book.toJson())).toList();
    await prefs.setStringList('cart', cartJson);
  }
}

final cartProvider =
    AsyncNotifierProvider<CartNotifier, List<Book>>(() => CartNotifier());
