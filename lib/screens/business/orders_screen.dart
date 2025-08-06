import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class BusinessOrdersScreen extends StatefulWidget {
  const BusinessOrdersScreen({super.key});

  @override
  _BusinessOrdersScreenState createState() => _BusinessOrdersScreenState();
}

class _BusinessOrdersScreenState extends State<BusinessOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> pendingOrders = [
    {
      'id': 'ORD001',
      'customer': 'Ahmet Yılmaz',
      'total': 25.50,
      'status': 'Bekliyor',
      'items': [
        {'name': 'Ekmek', 'quantity': 2, 'price': 2.50},
        {'name': 'Süt (1L)', 'quantity': 1, 'price': 8.00},
        {'name': 'Yumurta', 'quantity': 1, 'price': 12.50},
      ],
      'address': 'Örnek Mah. Çiçek Sk. No: 5, D:2',
      'phone': '0532 123 45 67',
    },
    {
      'id': 'ORD002',
      'customer': 'Fatma Demir',
      'total': 18.00,
      'status': 'Hazırlanıyor',
      'items': [
        {'name': 'Peynir', 'quantity': 1, 'price': 15.00},
        {'name': 'Zeytin', 'quantity': 1, 'price': 3.00},
      ],
      'address': 'Ticaret Cd. Plaza İş Merkezi Kat:3',
      'phone': '0533 234 56 78',
    },
  ];

  final List<Map<String, dynamic>> completedOrders = [
    {
      'id': 'ORD000',
      'customer': 'Mehmet Kaya',
      'total': 32.75,
      'status': 'Tamamlandı',
      'items': [
        {'name': 'Ekmek', 'quantity': 3, 'price': 2.50},
        {'name': 'Süt (1L)', 'quantity': 2, 'price': 8.00},
        {'name': 'Peynir', 'quantity': 1, 'price': 15.00},
      ],
      'address': 'Sağlık Mah. İlaç Sok. No: 12',
      'phone': '0534 345 67 89',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Yönetimi'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Bekleyen Siparişler'),
            Tab(text: 'Tamamlanan Siparişler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingOrdersList(),
          _buildCompletedOrdersList(),
        ],
      ),
    );
  }

  Widget _buildPendingOrdersList() {
    if (pendingOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green[400],
            ),
            const SizedBox(height: 20),
            Text(
              'Bekleyen siparişiniz bulunmamaktadır.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: pendingOrders.length,
      itemBuilder: (context, index) {
        final order = pendingOrders[index];
        return _buildOrderCard(order, true);
      },
    );
  }

  Widget _buildCompletedOrdersList() {
    if (completedOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'Tamamlanan siparişiniz bulunmamaktadır.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: completedOrders.length,
      itemBuilder: (context, index) {
        final order = completedOrders[index];
        return _buildOrderCard(order, false);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, bool isPending) {
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
      child: ExpansionTile(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: isPending ? Colors.orange : Colors.green,
              child: Text(
                order['id'].substring(3),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order['customer'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sipariş ID: ${order['id']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${order['total']} ₺',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPending ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    order['status'],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sipariş Detayları',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ...order['items'].map<Widget>((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['name']} x${item['quantity']}'),
                      Text('${item['price']} ₺'),
                    ],
                  ),
                )).toList(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Toplam:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${order['total']} ₺', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        order['address'],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      order['phone'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                if (isPending) ...[
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _updateOrderStatus(order['id'], 'Hazırlanıyor');
                          },
                          child: const Text('Hazırlanıyor'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _updateOrderStatus(order['id'], 'Tamamlandı');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Tamamla'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateOrderStatus(String orderId, String newStatus) {
    setState(() {
      // Update order status logic would go here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$orderId siparişi $newStatus olarak güncellendi')),
      );
    });
  }
} 