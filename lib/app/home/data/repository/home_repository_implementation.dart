import 'package:flutter/material.dart';
import 'package:namer_app/app/core/data/remote/service/product_serivce.dart';
import 'package:namer_app/app/core/domain/entity/product_entity.dart';
import 'package:namer_app/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final ProductService productService;
  HomeRepositoryImplementation({required this.productService});
  @override
  Future<bool> deleteProduct(String id) async {
    try {
      return await productService.delete(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    List<ProductEntity> products = [];
    try {
      final response = await productService.getAll();
      debugPrint("el responseeeee: $response");
      for (var element in response) {
        products.add(element.toEntity());
      }
    } catch (e) {}

    return products;
  }
}
