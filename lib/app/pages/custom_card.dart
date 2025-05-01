import 'package:book_store/app/utilites/books.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Book book;

  const CustomCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Hero(
            tag: 'bookImage-${book.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                book.image,
                width: 100, 
                height: 160, 
                fit: BoxFit.cover, 
              ),
            ),
          ),
          const SizedBox(width: 10), 
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 1, 
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Author: ${book.author}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Price: \$${book.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        '${book.rate}/5',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '${book.pages} pages',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    book.description,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
