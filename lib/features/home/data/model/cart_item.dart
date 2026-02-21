import '../../data/model/product_model.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

