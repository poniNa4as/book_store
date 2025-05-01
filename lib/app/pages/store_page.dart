import 'package:book_store/app/pages/book_page.dart';
import 'package:book_store/app/pages/carusel.dart';
import 'package:book_store/app/pages/custom_app_bar.dart';
import 'package:book_store/app/pages/custom_card.dart';
import 'package:book_store/app/pages/custom_bottom_appbar.dart';
import 'package:book_store/app/utilites/books.dart';
import 'package:book_store/app/utilites/init_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorePage extends ConsumerStatefulWidget {
  const StorePage({super.key});

  @override
  ConsumerState<StorePage> createState() => _StorePageState();
}

class _StorePageState extends ConsumerState<StorePage> {
  List<Book> books = [];
  List<Book> filtredBooks = [];
  bool isLOading = true;

  void fetchBooks() async {
    final instance = FirebaseFirestore.instance;
    final snapshot = await instance.collection('books').get();
    final loadedBooks =
        snapshot.docs.map((doc) => Book.fromJson(doc.data())).toList();

    setState(() {
      books = loadedBooks;
      filtredBooks = loadedBooks;
      isLOading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
    InitService.loadData();
  }

  void _handleInput(String query) {
    final filtred = books.where((book) {
      final titleLower = book.title.toLowerCase();
      final authorLower = book.author.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      filtredBooks = filtred;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Store'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                Carusel(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search for books...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onChanged: _handleInput,
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filtredBooks.length,
                  itemBuilder: (context, index) {
                    final book = filtredBooks[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookPage(book: book)));
                        },
                        child: CustomCard(book: book));
                  },
                ),
                const SizedBox(height: 65,)
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomAppbar(),
          ),
        ],
      ),
    );
  }
}
