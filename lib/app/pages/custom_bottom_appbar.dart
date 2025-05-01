// custom_bottom_appbar.dart
import 'package:book_store/app/routes.dart';
import 'package:flutter/material.dart';

class CustomBottomAppbar extends StatelessWidget {
  const CustomBottomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 238, 244, 247), 
            Color.fromARGB(255, 145, 146, 146),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottonBarItem(Icons.menu_book, () {
              Navigator.pushNamed(context, AppRoutes.addBook);
            }, 'New Book'),
            _bottonBarItem(Icons.person, () {
              Navigator.pushNamed(context, AppRoutes.morty);
            }, 'Morty'),
          ],
        ),
      ),
    );
  }

  Widget _bottonBarItem(IconData icon, VoidCallback fn, String label) {
    return InkWell(
      onTap: fn,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22.0, color: const Color.fromARGB(255, 90, 162, 221)),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
