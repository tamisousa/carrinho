import 'package:flutter/material.dart';

void main() {
  runApp(LivrariaApp());
}

class Livro {
  final String titulo;
  final String autor;
  final double preco;
  final String imagemUrl;

  Livro(this.titulo, this.autor, this.preco, this.imagemUrl);
}

class LivrariaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livraria Virtual',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LivrariaHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LivrariaHomePage extends StatefulWidget {
  @override
  _LivrariaHomePageState createState() => _LivrariaHomePageState();
}

class _LivrariaHomePageState extends State<LivrariaHomePage> {
  double total = 0.0;

  List<Livro> livros = [
    Livro(
      'A Toca da Raposa',
      'Nora Sakavic',
      49.90,
      'https://m.media-amazon.com/images/I/81Rt8sM6pvL._SL1500_.jpg',
    ),
    Livro(
      'A Seleção',
      'Kiera Cass',
      34.90,
      'https://m.media-amazon.com/images/I/91gGZ3gYgCL._SL1500_.jpg',
    ),
    Livro(
      '1984',
      'George Orwell',
      39.90,
      'https://m.media-amazon.com/images/I/81rKLqNq4LL._SL1500_.jpg',
    ),
    Livro(
      'Orgulho e Preconceito',
      'Jane Austen',
      29.90,
      'https://m.media-amazon.com/images/I/91HHqVTAJQL.jpg',
    ),
    Livro(
      'O Conto da Aia',
      'Margaret Atwood',
      42.00,
      'https://m.media-amazon.com/images/I/71RGr9tS9BL._SL1500_.jpg',
    ),
  ];

  void adicionarAoCarrinho(double preco) {
    setState(() {
      total += preco;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Livro adicionado ao carrinho!')),
    );
  }

  void limparCarrinho() {
    setState(() {
      total = 0.0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Carrinho esvaziado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Livraria Virtual'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: 'Esvaziar Carrinho',
            onPressed: limparCarrinho,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: livros.length,
                itemBuilder: (context, index) {
                  final livro = livros[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            livro.imagemUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                livro.titulo,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Autor(a): ${livro.autor}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'R\$ ${livro.preco.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        adicionarAoCarrinho(livro.preco),
                                    icon: Icon(Icons.shopping_cart, size: 16),
                                    label: Text('Adicionar'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.deepPurple.shade50,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('R\$ ${total.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
