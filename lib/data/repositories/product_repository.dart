import '../../models/product.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

class ProductRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ProductRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<Product>> getProducts() async {
    try {
      final products = await remoteDataSource.fetchProducts();
      await localDataSource.cacheProducts(products);
      return products;
    } catch (e) {
      try {
        return await localDataSource.getCachedProducts();
      } catch (cacheError) {
        throw Exception('Sem conexão com a internet e sem dados no cache local.');
      }
    }
  }
}