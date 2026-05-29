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
      // 1. Tenta buscar da API
      final products = await remoteDataSource.fetchProducts();
      // 2. Se der sucesso, salva no cache
      await localDataSource.cacheProducts(products);
      return products;
    } catch (e) {
      // 3. Se falhar (ex: sem internet), tenta buscar do cache
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return cachedProducts;
      } catch (cacheError) {
        // 4. Se não tiver cache, lança o erro para a interface
        throw Exception('Sem conexão com a internet e sem dados no cache local.');
      }
    }
  }
}