// Autor: André Lucas Conceição Magalhães
// GitHub: https://github.com/NemRela1
// LinkedIn: https://www.linkedin.com/in/lucas-magalh%C3%A3es-348936222/
// Data: 22/03/2026

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_crud_template/widgets/product_form.dart';
import 'firebase_options.dart';
import 'models/product.dart';
import 'services/produto_service.dart';
import 'widgets/product_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ProdutoService();

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de produtos')),
      body: StreamBuilder<List<Produto>>(
        stream: service.getProdutos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final produtos = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: produtos.length,
            itemBuilder: (context, i) => ProductCard(produto: produtos[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ProductForm.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }

}
