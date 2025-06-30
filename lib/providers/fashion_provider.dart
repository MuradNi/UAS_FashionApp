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
      stock: 25, // Tambahan stock
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
      stock: 12, // Tambahan stock
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
      stock: 18, // Tambahan stock
    ),
  ];

  List<CartItem> _cartItems = []; // List untuk cart items
  List<String> _categories = ['All', 'Tops', 'Bottoms', 'Outerwear', 'Accessories'];
  String _selectedCategory = 'All';

  // Getters
  List<FashionItem> get items => _items;
  List<CartItem> get cartItems => _cartItems;
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

  // Cart getters
  int get cartItemCount => _cartItems.length;

  double get cartTotalPrice {
    return _cartItems.fold(0.0, (total, item) => total + item.totalPrice);
  }

  // Methods
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

  // Cart methods
  void addToCart(FashionItem fashionItem, String selectedColor, String selectedSize) {
    // Cek apakah item dengan kombinasi yang sama sudah ada di cart
    final existingCartItemIndex = _cartItems.indexWhere((cartItem) =>
    cartItem.fashionItemId == fashionItem.id &&
        cartItem.selectedColor == selectedColor &&
        cartItem.selectedSize == selectedSize);

    if (existingCartItemIndex >= 0) {
      // Jika sudah ada, tambah quantity
      _cartItems[existingCartItemIndex].quantity++;
    } else {
      // Jika belum ada, buat cart item baru
      final cartItem = CartItem(
        id: '${fashionItem.id}_${selectedColor}_${selectedSize}_${DateTime.now().millisecondsSinceEpoch}',
        fashionItemId: fashionItem.id,
        name: fashionItem.name,
        brand: fashionItem.brand,
        price: fashionItem.price,
        imagePath: fashionItem.imagePath,
        selectedColor: selectedColor,
        selectedSize: selectedSize,
      );
      _cartItems.add(cartItem);
    }
    notifyListeners();
  }

  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void updateCartItemQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }

    final cartItemIndex = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (cartItemIndex >= 0) {
      _cartItems[cartItemIndex].quantity = newQuantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Method untuk mengecek apakah item sudah ada di cart
  bool isInCart(String fashionItemId) {
    return _cartItems.any((cartItem) => cartItem.fashionItemId == fashionItemId);
  }
}