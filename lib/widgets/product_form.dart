import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/produto_service.dart';

class ProductForm {
  static void show(BuildContext context, {Produto? produto}) {
    final service = ProdutoService();
    final nomeCtrl = TextEditingController(text: produto?.nome);
    final precoCtrl = TextEditingController(text: produto?.preco.toString() ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(produto == null ? 'Novo Produto' : 'Editar Produto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomeCtrl, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(
              controller: precoCtrl,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final preco = double.tryParse(precoCtrl.text) ?? 0;
              if (nomeCtrl.text.isNotEmpty && preco > 0) {
                final p = Produto(
                  id: produto?.id ?? '',
                  nome: nomeCtrl.text,
                  preco: preco,
                );

                produto == null ? service.addProduto(p) : service.updateProduto(p);
                Navigator.pop(ctx);
              }
            },
            child: Text(produto == null ? 'Salvar' : 'Atualizar'),
          )
        ],
      ),
    );
  }
}