import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final GlobalKey<ProductsPageState> _productsPageKey = GlobalKey<ProductsPageState>();

  final List<Widget> _pages = [
    ProductsPage(),
    CustomerPage(),
    Placeholder(),
    Placeholder(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text(
        'Dashboard',
       ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
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
              leading: const Icon(Icons.receipt),
              title: const Text('Penjualan'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.details),
              title: const Text('Detail Penjualan'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            )
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
                _productsPageKey.currentState?.addProduct(newProduct);
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
 const ProductsPage({Key? key}) : super(key: key);

  @override
  ProductsPageState createState () =>  ProductsPageState();
  
  }

class ProductsPageState extends State<ProductsPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              String? newProduct = await _showProductDialog(context);
              if (newProduct != null && newProduct.isNotEmpty) {
                addProduct(newProduct);
              }
            },
          )
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Belum ada produk', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(products[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteProduct(index),
                ),
                onTap: () async {
                  String? newProduct = await _showProductDialog(context, initialText: products[index]);
                  if (newProduct != null && newProduct.isNotEmpty) editProduct(index, newProduct);
                },
              ),
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
      },
    );
  }
}

  
  class CustomerPage extends StatefulWidget {
    @override
    _CustomerPageState createState() => _CustomerPageState();
  }

  class _CustomerPageState extends State<CustomerPage> {
      List<String>customers = [];

    void addCustomers(String customer) {
      setState(() {
        customers.add(customer) ;
      });
    }

    void deleteCustomers(int index) {
      setState(() {
        customers.removeAt(index);
      });
    }

    void editCustomer(int index, String newCustomer) {
      setState(() {
        customers[index] = newCustomer;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Pelanggan'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                String? newCustomer = await _showCustomerDialog(context);
                if (newCustomer != null && newCustomer.isNotEmpty) {
                  addCustomers(newCustomer);
                }
              },
              )
          ],
        ),
        body: customers.isEmpty
        ? const Center(child: Text('Belum ada pelanggan', style: TextStyle(fontSize: 18)))
        :ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(customers[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteCustomers(index),
              ),
              onTap: () async {
                String? newCustomer = await _showCustomerDialog(context, initialText: customers[index]);
                if (newCustomer != null && newCustomer.isNotEmpty) {
                  editCustomer(index, newCustomer);
                }
              },
          ),
        )
      );
    }
    Future<String?> _showCustomerDialog(BuildContext context, {String? initialText}) async {
      TextEditingController controller = TextEditingController(text: initialText);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(initialText == null ? 'Tambah Pelanggan' : 'Edit Pelanggan'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Nama Pelanggan'),
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
                    ),
              ],
          );
        }
        );
    }
  }

  
  