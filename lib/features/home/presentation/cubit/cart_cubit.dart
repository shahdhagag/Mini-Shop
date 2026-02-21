import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/cart_item.dart';
import '../../data/model/product_model.dart';

class CartCubit extends Cubit<List<CartItem>> {
  /// first state is an empty cart
  CartCubit() : super([]);

  /// Add Product To Cart
  void addToCart(Products product) {
    // Create a copy of the current cart list
    final updatedCart = List<CartItem>.from(state);

    // Check if product already exists in cart
    final index = updatedCart.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      // If found → increase quantity
      updatedCart[index].quantity++;
    } else {
      // If not found → add new CartItem
      updatedCart.add(CartItem(product: product));
    }
    emit(List.from(updatedCart));
  }

  /// Remove Product From Cart

  void removeFromCart(int productId) {
    // Copy current state and remove the item
    final updatedCart = List<CartItem>.from(state)
      ..removeWhere((item) => item.product.id == productId);

    // Emit updated list
    emit(List.from(updatedCart));
  }

  /// increment
  void increment(int productId) {
    final updatedCart = List<CartItem>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      updatedCart[index].quantity++;

      emit(List.from(updatedCart));
    }
  }

  /// decrement
  void decrement(int productId) {
    final updatedCart = List<CartItem>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      if (updatedCart[index].quantity > 1) {
        // law quantity more than 1 →  decrease it
        updatedCart[index].quantity--;
      } else {
        // law quantity becomes 0 → remove item completely
        updatedCart.removeAt(index);
      }

      emit(List.from(updatedCart));
    }
  }

  ///  Total Items Count
  int get totalItems {
    int total = 0;
    for (final item in state) {
      total += item.quantity;
    }
    return total;
  }

  ///  Total Price
  double get totalPrice {
    double total = 0.0;
    for (final item in state) {
      total += (item.product.price ?? 0) * item.quantity;
    }
    return total;
  }

  /// Check If Product In Cart

  bool isInCart(int productId) =>
      state.any((item) => item.product.id == productId);

  /// Get Quantity Of Product

  int quantityOf(int productId) {
    final index = state.indexWhere((item) => item.product.id == productId);

    return index != -1 ? state[index].quantity : 0;
  }
}
