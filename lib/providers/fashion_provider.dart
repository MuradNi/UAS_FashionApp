import 'package:flutter/material.dart';
import '../models/fashion_model.dart';

class FashionProvider with ChangeNotifier {
  List<FashionItem> _items = [
    FashionItem(
      id: '1',
      name: 'Minimalist White Tee',
      brand: 'ESSENTIALS',
      price: 200000,
      imagePath: 'assets/images/placeholder.png',
      category: 'Tops',
      colors: ['White', 'Black', 'Grey'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      description: 'Clean, minimalist design with premium cotton blend.',
    ),
    FashionItem(
      id: '2',
      name: 'Tailored Blazer',
      brand: 'MODERN',
      price: 750000,
      imagePath: 'assets/images/placeholder.png',
      category: 'Outerwear',
      colors: ['Navy', 'Black', 'Charcoal'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      description: 'Structured blazer with clean lines and perfect fit.',
    ),
    FashionItem(
      id: '3',
      name: 'High-Waist Trousers',
      brand: 'REFINED',
      price: 450000,
      imagePath: 'assets/images/placeholder.png',
      category: 'Bottoms',
      colors: ['Black', 'Navy', 'Beige'],
      sizes: ['24', '26', '28', '30', '32'],
      description: 'Elegant high-waist design with streamlined silhouette.',
    ),
  ];

  List<String> _categories = ['All', 'Tops', 'Bottoms', 'Outerwear', 'Accessories'];
  String _selectedCategory = 'All';

  List<FashionItem> get items => _items;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;

  List<FashionItem> get filteredItems {
    if (_selectedCategory == 'All') {
      return _items;
    }
    return _items.where((item) => item.category == _selectedCategory).toList();
  }

  List<FashionItem> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  void toggleFavorite(String id) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex >= 0) {
      _items[itemIndex].isFavorite = !_items[itemIndex].isFavorite;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}