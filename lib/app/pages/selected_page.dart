import 'package:book_store/app/pages/character_card.dart';
import 'package:book_store/app/providers/selected_providet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedPage extends ConsumerWidget {
  const SelectedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 91, 231, 184),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withValues(alpha: 0.8),
        title: const Text('Favorite characters'),
        ),
      body: selectedCharacter.when( 
        error: (error, track) => Center(child: Text('Error: $error'),), 
        loading: () => const Center(child: CircularProgressIndicator(),), 
        data: (data) {
          return GridView.builder(
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,  
              crossAxisSpacing: 10,  
              childAspectRatio: 0.7, 
            ), 
            itemBuilder: (context, i) {
              final item = data[i];
              return CharacterCard(char: item);
            },
          );
        },
      ),
    );
  }
}