import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _activePage = 0;
  final PageController _controller = PageController();

  int get getActivePage => _activePage;

  PageController get getController => _controller;

  set setActivePage(int page) {
    _activePage = page;
    _controller.animateToPage(
      _activePage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }
}
