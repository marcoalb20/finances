import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _actualPage = 0;
  int get actualPage => _actualPage;

  // Color skyBlue = Color(0xFFCBDCEB);
  // Color blue = Color(0xFF6D94C5);
  // Color whiteCream = Color(0xFFF5EFE6);
  // Color cream = Color(0xFFE8DFCA);
  // Color white = Colors.white;
  // Color black = Colors.black;

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  void goToPage(int page) {
    _actualPage = page;
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
