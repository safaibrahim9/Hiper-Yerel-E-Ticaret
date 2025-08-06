import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String businessId;
  final String businessName;
  final double price;
  final int quantity;
  final String? image;
  final String? notes;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.businessId,
    required this.businessName,
    required this.price,
    required this.quantity,
    this.image,
    this.notes,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? businessId,
    String? businessName,
    double? price,
    int? quantity,
    String? image,
    String? notes,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      notes: notes ?? this.notes,
    );
  }
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  String? _selectedDeliveryAddress;
  String _selectedPaymentMethod = AppConstants.paymentMethods.first;
  String _deliveryType = AppConstants.deliveryTypeDelivery;
  double _deliveryFee = 0.0;

  // Getters
  Map<String, CartItem> get items => _items;
  List<CartItem> get itemsList => _items.values.toList();
  int get itemCount => _items.length;
  int get totalQuantity => _items.values.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal + _deliveryFee;
  String? get selectedDeliveryAddress => _selectedDeliveryAddress;
  String get selectedPaymentMethod => _selectedPaymentMethod;
  String get deliveryType => _deliveryType;
  double get deliveryFee => _deliveryFee;
  bool get isEmpty => _items.isEmpty;

  // TODO: Add item to cart
  void addItem({
    required String productId,
    required String productName,
    required String businessId,
    required String businessName,
    required double price,
    String? image,
    String? notes,
  }) {
    final existingItem = _items.values.firstWhere(
      (item) => item.productId == productId && item.businessId == businessId,
      orElse: () => CartItem(
        id: '',
        productId: '',
        productName: '',
        businessId: '',
        businessName: '',
        price: 0,
        quantity: 0,
      ),
    );

    if (existingItem.id.isNotEmpty) {
      // Update existing item
      _items[existingItem.id] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      // Add new item
      final newItem = CartItem(
        id: '${productId}_${businessId}_${DateTime.now().millisecondsSinceEpoch}',
        productId: productId,
        productName: productName,
        businessId: businessId,
        businessName: businessName,
        price: price,
        quantity: 1,
        image: image,
        notes: notes,
      );
      _items[newItem.id] = newItem;
    }

    notifyListeners();
  }

  // TODO: Remove item from cart
  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  // TODO: Update item quantity
  void updateItemQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
    } else {
      final item = _items[itemId];
      if (item != null) {
        _items[itemId] = item.copyWith(quantity: quantity);
        notifyListeners();
      }
    }
  }

  // TODO: Update item notes
  void updateItemNotes(String itemId, String notes) {
    final item = _items[itemId];
    if (item != null) {
      _items[itemId] = item.copyWith(notes: notes);
      notifyListeners();
    }
  }

  // TODO: Set delivery address
  void setDeliveryAddress(String address) {
    _selectedDeliveryAddress = address;
    notifyListeners();
  }

  // TODO: Set payment method
  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  // TODO: Set delivery type
  void setDeliveryType(String type) {
    _deliveryType = type;
    // Update delivery fee based on type
    _deliveryFee = type == AppConstants.deliveryTypeDelivery ? 5.0 : 0.0;
    notifyListeners();
  }

  // TODO: Calculate delivery fee
  void calculateDeliveryFee(double distance) {
    if (_deliveryType == AppConstants.deliveryTypeDelivery) {
      // Base fee + distance fee
      _deliveryFee = 5.0 + (distance * 0.5); // 5 TL base + 0.5 TL per km
    } else {
      _deliveryFee = 0.0;
    }
    notifyListeners();
  }

  // TODO: Clear cart
  void clearCart() {
    _items.clear();
    _selectedDeliveryAddress = null;
    _selectedPaymentMethod = AppConstants.paymentMethods.first;
    _deliveryType = AppConstants.deliveryTypeDelivery;
    _deliveryFee = 0.0;
    notifyListeners();
  }

  // TODO: Check if cart is valid for checkout
  bool isCartValidForCheckout() {
    if (_items.isEmpty) return false;
    
    // Check if all items are from the same business
    final businessIds = _items.values.map((item) => item.businessId).toSet();
    if (businessIds.length > 1) return false;
    
    // Check if delivery address is selected for delivery
    if (_deliveryType == AppConstants.deliveryTypeDelivery && 
        _selectedDeliveryAddress == null) {
      return false;
    }
    
    return true;
  }

  // TODO: Get cart summary
  Map<String, dynamic> getCartSummary() {
    return {
      'itemCount': itemCount,
      'totalQuantity': totalQuantity,
      'subtotal': subtotal,
      'deliveryFee': _deliveryFee,
      'total': total,
      'businessName': _items.isNotEmpty ? _items.values.first.businessName : null,
      'deliveryType': _deliveryType,
      'paymentMethod': _selectedPaymentMethod,
    };
  }

  // TODO: Create order from cart
  Map<String, dynamic> createOrder() {
    final order = {
      'items': _items.values.map((item) => {
        'productId': item.productId,
        'productName': item.productName,
        'price': item.price,
        'quantity': item.quantity,
        'notes': item.notes,
      }).toList(),
      'businessId': _items.values.first.businessId,
      'businessName': _items.values.first.businessName,
      'subtotal': subtotal,
      'deliveryFee': _deliveryFee,
      'total': total,
      'deliveryType': _deliveryType,
      'paymentMethod': _selectedPaymentMethod,
      'deliveryAddress': _selectedDeliveryAddress,
      'orderDate': DateTime.now().toIso8601String(),
      'status': AppConstants.orderStatusPending,
    };

    return order;
  }
} 