import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/produto_service.dart';
import 'product_form.dart';

class ProductCard extends StatelessWidget {
  final Produto produto;
  const ProductCard({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => ProductForm.show(context, produto: produto),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory_2, size: 40),
            Text(produto.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => ProdutoService().deleteProduto(produto.id),
            ),
          ],
        ),
      ),
    );
  }
}