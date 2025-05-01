import 'package:book_store/app/pages/add_book_page.dart';
import 'package:book_store/app/pages/cart_page.dart';
import 'package:book_store/app/pages/morty_page.dart';
import 'package:book_store/app/pages/selected_page.dart';
import 'package:book_store/app/pages/store_page.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const addBook = '/addBook';
  static const morty = '/morty';
  static const store = '/store';
  static const cart = '/cart';
  static const selected = '/selected';

  static final routes = <String, WidgetBuilder>{
    addBook: (_) => const AddBookPage(),
    morty: (_) => const MortyPage(),
    store: (_) => const StorePage(),
    cart: (_) => const CartPage(),
    selected: (_) => const SelectedPage(),
  };

}