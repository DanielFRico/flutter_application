import 'package:namer_app/app/core/data/remote/dto/product_data_model.dart';
import 'package:namer_app/app/home/presentation/model/product_model.dart';

final class ProductEntity {
  final String id;
  final String name;
  final String imageUrl;
  final int price;

  ProductEntity(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price});

  ProductModel toProductModel() {
    return ProductModel(id: id, name: name, imageUrl: imageUrl, price: price);
  }

  ProductDataModel toProductDataModel() {
    return ProductDataModel(
        id: id, name: name, imageUrl: imageUrl, price: price.toString());
  }
}
