import 'package:flutter/material.dart';
import 'package:flutter_tennis_court/theme/custom_theme.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/navigation_provider.dart';

//- class for menu buttons
class MenuItem {
  String title;
  IconData icon;
  MenuItem(this.title, this.icon);
}

class CustomNavigation extends StatelessWidget {
  const CustomNavigation({super.key});

  //- list of buttons
  static final List<MenuItem> items = [
    MenuItem('Reservas', Icons.bookmark_outline),
    MenuItem('Canchas', Icons.sports_tennis_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: _decoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => MenuBtn(item: items[index], index: index),
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: const Color(0xFF2A2B2A).withOpacity(0.9),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key, required this.item, required this.index});

  final MenuItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final activePage = index == navigationProvider.getActivePage;
    final activeColor = activePage ? CustomTheme.primaryColor : Colors.white;

    return GestureDetector(
      onTap: () => navigationProvider.setActivePage = index,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, color: activeColor, size: activePage ? 27 : 25),
          Text(
            item.title,
            style: TextStyle(
              fontSize: activePage ? 14 : 12,
              color: activeColor,
            ),
          )
        ],
      ),
    );
  }
}
