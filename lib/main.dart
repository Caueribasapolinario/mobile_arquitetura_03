import 'package:flutter/material.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/repositories/product_repository.dart';
import 'viewmodels/product_viewmodel.dart';
import 'views/home_page.dart';

void main() {
  final remoteDataSource = RemoteDataSource();
  final localDataSource = LocalDataSource();
  
  final repository = ProductRepository(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
  
  final viewModel = ProductViewModel(repository);

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  final ProductViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arquitetura App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(viewModel: viewModel), 
    );
  }
}