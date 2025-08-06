import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../splash_screen.dart';
import 'reports_screen.dart';

class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşletme Profili'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBusinessInfo(context),
            const SizedBox(height: 30),
            _buildBusinessSettings(context),
            const SizedBox(height: 30),
            _buildAnalytics(context),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              child: Icon(Icons.store, size: 60, color: AppTheme.primaryColor),
            ),
            const SizedBox(height: 15),
            const Text(
              'Mehmet\'in Marketi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Market',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const Text('4.5 (120 değerlendirme)'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _showEditProfileDialog(context);
              },
              icon: const Icon(Icons.edit),
              label: const Text('Profili Düzenle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('İşletme Ayarları'),
        _buildProfileMenuItem(context, Icons.schedule, 'Çalışma Saatleri', () {
          _showWorkingHoursDialog(context);
        }),
        _buildProfileMenuItem(context, Icons.location_on, 'Adres Bilgileri', () {
          _showAddressDialog(context);
        }),
        _buildProfileMenuItem(context, Icons.phone, 'İletişim Bilgileri', () {
          _showContactDialog(context);
        }),
        _buildProfileMenuItem(context, Icons.category, 'Kategori Ayarları', () {
          _showCategoryDialog(context);
        }),
        _buildProfileMenuItem(context, Icons.delivery_dining, 'Teslimat Ayarları', () {
          _showDeliveryDialog(context);
        }),
      ],
    );
  }

  Widget _buildAnalytics(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Analitik ve Raporlar'),
        _buildProfileMenuItem(context, Icons.analytics, 'Satış Raporları', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BusinessReportsScreen()),
          );
        }),
        _buildProfileMenuItem(context, Icons.trending_up, 'Performans Analizi', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BusinessReportsScreen()),
          );
        }),
        _buildProfileMenuItem(context, Icons.people, 'Müşteri Analizi', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BusinessReportsScreen()),
          );
        }),
        _buildProfileMenuItem(context, Icons.inventory, 'Stok Raporları', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BusinessReportsScreen()),
          );
        }),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Çıkış Yap'),
              content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('İptal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    // Navigate back to splash screen
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Çıkış Yap'),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Çıkış Yap',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
      ),
    );
  }

  Widget _buildProfileMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profil Düzenle'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('İşletme bilgilerini düzenleme özelliği yakında eklenecek.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showWorkingHoursDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çalışma Saatleri'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pazartesi - Cuma: 08:00 - 22:00'),
            Text('Cumartesi: 08:00 - 22:00'),
            Text('Pazar: 09:00 - 21:00'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adres Bilgileri'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adres: Örnek Mahallesi, Çiçek Sokak No: 5'),
            Text('İlçe: Kadıköy'),
            Text('Şehir: İstanbul'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('İletişim Bilgileri'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Telefon: +90 216 123 4567'),
            Text('E-posta: info@mehmetmarketi.com'),
            Text('Web: www.mehmetmarketi.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategori Ayarları'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mevcut Kategoriler:'),
            Text('• Temel Gıda'),
            Text('• Süt Ürünleri'),
            Text('• Meyve Sebze'),
            Text('• İçecek'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Teslimat Ayarları'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Teslimat Bölgesi: 5 km'),
            Text('Minimum Sipariş: ₺20'),
            Text('Teslimat Ücreti: ₺5'),
            Text('Teslimat Süresi: 30-45 dk'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
} 