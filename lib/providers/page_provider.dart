import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageProvider with ChangeNotifier {
  int _actualPage = 0;
  static const _kPage = 'page_actual';
  int get actualPage => _actualPage;

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _actualPage = prefs.getInt(_kPage) ?? 0;
    notifyListeners();
  }

  void goToPage(int page) {
    _actualPage = page;
    SharedPreferences.getInstance().then((p) => p.setInt(_kPage, page));
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
