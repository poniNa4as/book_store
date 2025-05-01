import 'package:book_store/app/providers/cart_provider.dart';
import 'package:book_store/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsync = ref.watch(cartProvider);
    final totalCount = cartItemsAsync.maybeWhen(
      data: (cartItems) =>
          cartItems.fold<int>(0, (acc, curr) => acc + curr.quantity),
      orElse: () => 0,
    );

    return AppBar(
      title: Row(
          children: [
            Image.asset('asset/images/book_font_icon.png', height: 30,),
           const SizedBox(width: 10,),
            Text(
                title,
                style: const TextStyle(
                  fontFamily: '',
                  letterSpacing: 2.0,
                  fontSize: 25,
                ),
              ),
          ],
        ),

      centerTitle: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 238, 244, 247),
              Color.fromARGB(255, 145, 146, 146),
            ],
          ),
        ),
      ),
      actions: [
        if (totalCount > 0)
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
              ),
              Positioned(
                right: 0,
                top: 20,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: Text(
                    '$totalCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
