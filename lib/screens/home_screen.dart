import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/providers.dart';

import 'package:flutter_tennis_court/screens/screens.dart';

import 'package:flutter_tennis_court/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_Pages(), _Navigation()]),
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: navigationProvider.getController,
      children: const [BookingScreen(), CourtsScreen()],
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: const CustomNavigation(),
      ),
    );
  }
}
