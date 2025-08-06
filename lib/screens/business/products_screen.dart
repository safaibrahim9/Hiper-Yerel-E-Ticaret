import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class BusinessProductsScreen extends StatefulWidget {
  const BusinessProductsScreen({super.key});

  @override
  _BusinessProductsScreenState createState() => _BusinessProductsScreenState();
}

class _BusinessProductsScreenState extends State<BusinessProductsScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'iPhone 15 Pro Max',
      'category': 'Telefon',
      'price': 65000.0,
      'stock': 15,
      'status': 'active',
      'rating': 4.9,
      'sales': 8,
    },
    {
      'id': '2',
      'name': 'Samsung Galaxy S24 Ultra',
      'category': 'Telefon',
      'price': 55000.0,
      'stock': 8,
      'status': 'active',
      'rating': 4.8,
      'sales': 12,
    },
    {
      'id': '3',
      'name': 'MacBook Pro M3',
      'category': 'Laptop',
      'price': 85000.0,
      'stock': 5,
      'status': 'active',
      'rating': 4.9,
      'sales': 3,
    },
    {
      'id': '4',
      'name': 'AirPods Pro 2',
      'category': 'Kulaklık',
      'price': 8500.0,
      'stock': 25,
      'status': 'active',
      'rating': 4.6,
      'sales': 20,
    },
    {
      'id': '5',
      'name': 'iPad Pro 12.9',
      'category': 'Tablet',
      'price': 45000.0,
      'stock': 12,
      'status': 'active',
      'rating': 4.8,
      'sales': 6,
    },
    {
      'id': '6',
      'name': 'Dell XPS 15',
      'category': 'Laptop',
      'price': 72000.0,
      'stock': 3,
      'status': 'active',
      'rating': 4.7,
      'sales': 1,
    },
    {
      'id': '7',
      'name': 'Apple Watch Series 9',
      'category': 'Akıllı Saat',
      'price': 12000.0,
      'stock': 18,
      'status': 'active',
      'rating': 4.7,
      'sales': 10,
    },
    {
      'id': '8',
      'name': 'Sony WH-1000XM5',
      'category': 'Kulaklık',
      'price': 9500.0,
      'stock': 22,
      'status': 'active',
      'rating': 4.8,
      'sales': 15,
    },
    {
      'id': '9',
      'name': 'Microsoft Surface Pro 9',
      'category': 'Tablet',
      'price': 38000.0,
      'stock': 7,
      'status': 'active',
      'rating': 4.6,
      'sales': 4,
    },
    {
      'id': '10',
      'name': 'Google Pixel 8 Pro',
      'category': 'Telefon',
      'price': 42000.0,
      'stock': 10,
      'status': 'active',
      'rating': 4.7,
      'sales': 7,
    },
    {
      'id': '11',
      'name': 'ASUS ROG Strix G16',
      'category': 'Gaming Laptop',
      'price': 68000.0,
      'stock': 4,
      'status': 'active',
      'rating': 4.8,
      'sales': 2,
    },
    {
      'id': '12',
      'name': 'Samsung Galaxy Tab S9',
      'category': 'Tablet',
      'price': 28000.0,
      'stock': 15,
      'status': 'active',
      'rating': 4.6,
      'sales': 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Yönetimi'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddProductDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCard(),
          Expanded(
            child: _buildProductsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    final activeProducts = products.where((p) => p['status'] == 'active').length;
    final totalProducts = products.length;
    final lowStockProducts = products.where((p) => p['stock'] < 10).length;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem('Toplam Ürün', totalProducts.toString(), Icons.inventory),
          ),
          Expanded(
            child: _buildStatItem('Aktif Ürün', activeProducts.toString(), Icons.check_circle),
          ),
          Expanded(
            child: _buildStatItem('Düşük Stok', lowStockProducts.toString(), Icons.warning),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.shopping_bag,
            color: Colors.grey,
            size: 30,
          ),
        ),
        title: Text(
          product['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product['category']),
            Text(
              '${product['price']} ₺ • Stok: ${product['stock']}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            _handleProductAction(value, product);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 16),
                  SizedBox(width: 8),
                  Text('Düzenle'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'stock',
              child: Row(
                children: [
                  Icon(Icons.inventory, size: 16),
                  SizedBox(width: 8),
                  Text('Stok Güncelle'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'toggle',
              child: Row(
                children: [
                  Icon(product['status'] == 'active' ? Icons.visibility_off : Icons.visibility, size: 16),
                  const SizedBox(width: 8),
                  Text(product['status'] == 'active' ? 'Pasif Yap' : 'Aktif Yap'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 16, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Sil', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          _showProductDetailsDialog(context, product);
        },
      ),
    );
  }

  void _handleProductAction(String action, Map<String, dynamic> product) {
    switch (action) {
      case 'edit':
        _showEditProductDialog(context, product);
        break;
      case 'stock':
        _showStockUpdateDialog(context, product);
        break;
      case 'toggle':
        setState(() {
          product['status'] = product['status'] == 'active' ? 'inactive' : 'active';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product['name']} durumu ${product['status'] == 'active' ? 'pasif' : 'aktif'} yapıldı')),
        );
        break;
      case 'delete':
        _showDeleteConfirmationDialog(context, product);
        break;
    }
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = 'Telefon';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yeni Ürün Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Ürün Adı'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Fiyat'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(labelText: 'Kategori'),
              items: ['Telefon', 'Laptop', 'Tablet', 'Kulaklık', 'Gaming Laptop'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedCategory = newValue!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && 
                  priceController.text.isNotEmpty && 
                  stockController.text.isNotEmpty) {
                setState(() {
                  products.add({
                    'id': 'p${products.length + 1}',
                    'name': nameController.text,
                    'description': descriptionController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'stock': int.tryParse(stockController.text) ?? 0,
                    'category': selectedCategory,
                    'icon': Icons.shopping_bag,
                    'color': Colors.green,
                    'status': 'active',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Yeni ürün eklendi')),
                );
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  void _showEditProductDialog(BuildContext context, Map<String, dynamic> product) {
    final nameController = TextEditingController(text: product['name']);
    final priceController = TextEditingController(text: product['price'].toString());
    final stockController = TextEditingController(text: product['stock'].toString());
    final descriptionController = TextEditingController(text: product['description']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ürün Düzenle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Ürün Adı'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Fiyat'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                product['name'] = nameController.text;
                product['price'] = double.tryParse(priceController.text) ?? product['price'];
                product['stock'] = int.tryParse(stockController.text) ?? product['stock'];
                product['description'] = descriptionController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product['name']} güncellendi')),
              );
            },
            child: const Text('Güncelle'),
          ),
        ],
      ),
    );
  }

  void _showStockUpdateDialog(BuildContext context, Map<String, dynamic> product) {
    final stockController = TextEditingController(text: product['stock'].toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stok Güncelle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${product['name']} için stok miktarını güncelleyin'),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Yeni Stok Miktarı'),
              keyboardType: TextInputType.number,
              controller: stockController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                product['stock'] = int.tryParse(stockController.text) ?? product['stock'];
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product['name']} stoku güncellendi')),
              );
            },
            child: const Text('Güncelle'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ürünü Sil'),
        content: Text('${product['name']} ürününü silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                products.remove(product);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product['name']} silindi')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  void _showProductDetailsDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kategori: ${product['category']}'),
            Text('Fiyat: ${product['price']} ₺'),
            Text('Stok: ${product['stock']}'),
            Text('Durum: ${product['status']}'),
            const SizedBox(height: 10),
            const Text('Açıklama:'),
            Text(product['description']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }
} 