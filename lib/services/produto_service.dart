import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/product.dart';

class ProdutoService {
  final CollectionReference _collection =
  FirebaseFirestore.instance.collection('produtos');

  Future<void> addProduto(Produto produto) async {
    try {
      await _collection.add(produto.toMap());
    } catch (e) {
      debugPrint("Erro ao adicionar produto: $e");
      rethrow;
    }
  }

  Stream<List<Produto>> getProdutos() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Produto.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateProduto(Produto produto) async {
    try {
      await _collection.doc(produto.id).update(produto.toMap());
    } catch (e) {
      debugPrint("Erro ao atualizar produto: $e");
      rethrow;
    }
  }

  Future<void> deleteProduto(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      debugPrint("Erro ao excluir produto: $e");
      rethrow;
    }
  }
}