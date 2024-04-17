import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreenController extends ChangeNotifier {
  Future<List<String>> getRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentSearches') ?? [];
  }

  Future<void> addRecentSearch(String searchQuery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recentSearches = prefs.getStringList('recentSearches') ?? [];
    recentSearches.insert(0, searchQuery);
    // Limit the number of recent searches, for example, keep the latest 5 searches
    recentSearches = recentSearches.take(5).toList();
    prefs.setStringList('recentSearches', recentSearches);
    notifyListeners();
  }

  Future<void> removeRecentSearch(String searchQuery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recentSearches = prefs.getStringList('recentSearches') ?? [];
    recentSearches.remove(searchQuery);
    notifyListeners();
    prefs.setStringList('recentSearches', recentSearches);
    notifyListeners();
  }
}