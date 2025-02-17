import 'package:flutter/material.dart';

void main () {
  runApp(const MyWidget());
  
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Beranda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;

  final List<Widget> _pages = [
    ProductsPage(),
    CustomersPage(),
    SalesPage(),
    SalesDetailPage(),
  ];

  final GlobalKey<_ProductsPageState> _productsPageKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Produk'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Pelanggan'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Penjualan'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Detail Penjualan'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            activeIcon: Icon(Icons.shopping_bag, color: Colors.green,),
            label: 'Produk',
           ),
            BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pelanggan',
           ),
           BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Penjualan',
           ),
           BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Detail Pelanggan',
           ),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),

      floatingActionButton: _selectIndex == 0
        ?FloatingActionButton(
          onPressed: () async {
            String? newProduct = await _showProductDialog(context);
            if (newProduct != null && newProduct.isNotEmpty) {
              setState(() {
                _productsPageKey.currentState?.addProduct(newProduct);
              });
            }
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
         )
      :null,
    );
  }

  Future<String?> _showProductDialog(BuildContext context, {String? initialText}) async {
    TextEditingController controller = TextEditingController(text: initialText);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(initialText == null ? 'Tambah Produk' : 'Edit Produk'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Nama Produk'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              }, 
              child: const Text('Simpan'),
            )
          ],
        );
      }
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? Key}) : super(key: Key);

  @override
  _ProductsPageState createState () =>  _ProductsPageState();
  }

class _ProductsPageState extends State<ProductsPage> {
  List<String> products = [];

  void addProduct(String product) {
    setState(() {
      products.add(product);
    });
  }

  void editProduct(int index, String newProduct) {
    setState(() {
      products[index] = newProduct;
    });
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

  @override
  Widget  build(BuildContext context) {
    return Scaffold(
      body: products.isEmpty
      ? const Center(
        child: Text(
          'Belum ada produk',
          style: TextStyle(fontSize: 18),
        ),
      )
      : ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red,
            ),
            onPressed: () => deleteProducts(index),
          ),
          onTap: () async {
            String? newProduct = await _showProductDialog(context, initialText: products[index]);
            if (newProduct != null && newProduct.isNotEmpty) {
              editProducts(index, newProduct);
            }
          },
        );
      }
    ),
    );
  }
  
    
    
    
    

Future<String?> _showProductDialog(BuildContext context, {String? initialText}) async {
  TextEditingController controller = TextEditingController(text: initialText);
  return showDialog(
    context: context,
     builder: (context) {
      return AlertDialog(
        title: Text(initialText == null ? 'Tambah Produk' : 'Edit Produk'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nama Produk'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal')
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
            child: const Text('Simpan'),
           )
        ],
      );
     }
  );
}

class CustomersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Halaman Pelanggan',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Halaman Penjualan',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SalesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Halaman Detail Penjualan',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}