import 'package:book_store/app/utilites/character.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final Character char;
  const CharacterCard({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return  Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    char.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( maxLines: 1, char.name, style:  const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Status: ${char.status}'),
                      Text('Species: ${char.species}'),
                      Text('Gender: ${char.gender}'),
                      Text('Origin: ${char.origin.name}', overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ); 
  }
}
