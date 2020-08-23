import '../entities/product.dart';

abstract class IManagedProductsRepo {
  Future<List<Product>> getAllManagedProducts();

  int getManagedProductsQtde();

  Future<Product> getManagedProductById(String id);

  Future<void> saveManagedProduct(Product product);

  Future<void> updateManagedProduct(Product product);

  Future<int> deleteManagedProduct(String id);
}
