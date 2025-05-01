import 'package:book_store/app/api/morti_api.dart';
import 'package:book_store/app/pages/character_page.dart';
import 'package:book_store/app/providers/selected_providet.dart';
import 'package:book_store/app/routes.dart';
import 'package:book_store/app/utilites/character.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MortyPage extends ConsumerStatefulWidget {
  const MortyPage({super.key});

  @override
  ConsumerState<MortyPage> createState() => _MortyPageState();
}

class _MortyPageState extends ConsumerState<MortyPage> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mortyProvider = ref.read(selectedProvider.notifier);

    void listClick(GlobalKey widgetKey, Character character) async {
      mortyProvider.addPerson(character);
      await runAddToCartAnimation(widgetKey);
      await cartKey.currentState!
          .runCartAnimation((++_cartQuantityItems).toString());
    }

    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Motry'),
          actions: [
            IconButton(
                onPressed: () {
                  mortyProvider.clean();
                  _cartQuantityItems = 0;
                  cartKey.currentState!.runClearCartAnimation();
                },
                icon: const Icon(Icons.cleaning_services)),
            AddToCartIcon(
              key: cartKey,
              icon: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.selected),
                  child: const Icon(
                    Icons.star_border,
                    size: 30,
                  )),
              badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Color.fromARGB(255, 176, 212, 14)),
            ),
            const SizedBox(width: 16)
          ],
        ),
        body: FutureBuilder<List<Character>>(
            future: MortiApi().fetchCharacter(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No data'),
                );
              } else {
                final data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final char = data[index];
                      return CharacterPage(
                          index: index,
                           onClick: listClick,
                            item: char);
                    });
              }
            }),
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.black12,
          selectedIndex: currentIndex,
          onDestinationSelected: (index) =>
              setState(() => currentIndex = index),
          backgroundColor: const Color.fromARGB(255, 176, 212, 14),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: 'Text'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search')
          ],
        ),
      ),
    );
  }
}
