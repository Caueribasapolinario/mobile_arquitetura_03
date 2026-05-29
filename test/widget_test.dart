import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_arquitetura_02/main.dart';
import 'package:mobile_arquitetura_02/data/datasources/local_data_source.dart';
import 'package:mobile_arquitetura_02/data/datasources/remote_data_source.dart';
import 'package:mobile_arquitetura_02/data/repositories/product_repository.dart';
import 'package:mobile_arquitetura_02/viewmodels/product_viewmodel.dart';

void main() {
  testWidgets('Teste de inicialização da interface de Produtos', (WidgetTester tester) async {
    // Inicializa um mock do SharedPreferences para evitar erros no teste
    SharedPreferences.setMockInitialValues({});

    // 1. Configuração da Injeção de Dependências para o teste
    final remoteDataSource = RemoteDataSource();
    final localDataSource = LocalDataSource();
    
    final repository = ProductRepository(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    
    final viewModel = ProductViewModel(repository);

    // 2. Constrói o aplicativo com o ViewModel injetado
    await tester.pumpWidget(MyApp(viewModel: viewModel));

    // 3. Verifica se a AppBar com o título correto foi renderizada
    expect(find.text('Produtos (Arquitetura)'), findsOneWidget);
    
    // Verifica se o CircularProgressIndicator (estado de loading) aparece
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}