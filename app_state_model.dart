// This is merely changed files from the shrine template from flutter repositiory on git, this is to showcase the task assigned by my proffessor in our ability to edit and change files to include what we need. 


import 'package:flutter/material.dart';
import 'package:gallery/studies/shrine/model/product.dart';
import 'package:gallery/studies/shrine/model/products_repository.dart';
import 'package:scoped_model/scoped_model.dart';

double _salesTaxRate = 0.06;
double _shippingCostPerItem = 7;

class AppStateModel extends Model {
  // All the available products.
  List<Product> _availableProducts = [];

  // The currently selected category and subcategory of products.
  Category _selectedCategory = categoryAll;
  SubCategory? _selectedSubCategory;

  // The IDs and quantities of products currently in the cart.
  final Map<int, int> _productsInCart = <int, int>{};

  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  // Total number of items in the cart.
  int get totalCartQuantity => _productsInCart.values.fold(0, (v, e) => v + e);

  Category get selectedCategory => _selectedCategory;
  SubCategory? get selectedSubCategory => _selectedSubCategory;

  // Totaled prices of the items in the cart.
  double get subtotalCost {
    return _productsInCart.keys
        .map((id) => _availableProducts[id].price * _productsInCart[id]!)
        .fold(0.0, (sum, e) => sum + e);
  }

  // Total shipping cost for the items in the cart.
  double get shippingCost {
    return _shippingCostPerItem *
        _productsInCart.values.fold(0.0, (sum, e) => sum + e);
  }

  // Sales tax for the items in the cart
  double get tax => subtotalCost * _salesTaxRate;

  // Total cost to order everything in the cart.
  double get totalCost => subtotalCost + shippingCost + tax;

  // Returns a copy of the list of available products, filtered by category and subcategory.
  List<Product> getProducts() {
    if (_selectedCategory == categoryAll) {
      return List<Product>.from(_availableProducts);
    } else if (_selectedSubCategory == null) {
      return _availableProducts
          .where((p) => p.category == _selectedCategory)
          .toList();
    } else {
      return _availableProducts
          .where((p) =>
              p.category == _selectedCategory &&
              p.subCategory == _selectedSubCategory)
          .toList();
    }
  }

  // Adds a product to the cart.
  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + 1;
    }

    notifyListeners();
  }

  // Adds products to the cart by a certain amount.
  // quantity must be non-null positive value.
  void addMultipleProductsToCart(int productId, int quantity) {
    assert(quantity > 0);
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = quantity;
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + quantity;
    }

    notifyListeners();
  }

  // Removes an item from the cart.
  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId] = _productsInCart[productId]! - 1;
      }
    }

    notifyListeners();
  }

  // Returns the Product instance matching the provided id.
  Product getProductById(int id) {
    return _availableProducts.firstWhere((p) => p.id == id);
  }

  // Removes everything from the cart.
  void clearCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  // Loads the list of available products from the repo.
  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(categoryAll);
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    _selectedSubCategory = null;
    notifyListeners();
  }

  void setSubCategory(SubCategory newSubCategory) {
    _selectedSubCategory = newSubCategory;
    notifyListeners();
  }

  // Search products by name
  List<Product> searchProducts(String query, BuildContext context) {
    return _availableProducts
        .where((product) =>
            product.name(context).toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  String toString() {
    return 'AppStateModel(totalCost: $totalCost)';
  }
}
