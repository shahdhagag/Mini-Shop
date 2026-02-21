import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_services.dart';
import '../model/product_model.dart';

class HomeRepo {
  Future<List<Products>> getProducts() async {
    try {
      final Response response = await ApiServices.get(
        EndPoints.products,
      );
      final ProductModel model = ProductModel.fromJson(response.data);
      return model.products ?? [];
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}

