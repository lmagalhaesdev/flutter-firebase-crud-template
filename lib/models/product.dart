class Produto {
  final String id;
  final String nome;
  final double preco;

  Produto({required this.id, required this.nome, required this.preco});

  Map<String, dynamic> toMap() => {'nome': nome, 'preco': preco};

  factory Produto.fromMap(String id, Map<String, dynamic> map) {
    return Produto(
      id: id,
      nome: map['nome'] ?? '',
      preco: (map['preco'] as num? ?? 0.0).toDouble(),
    );
  }
}