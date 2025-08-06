import 'dart:math';

class BusinessAIAnalyticsService {
  // Mock business data for analysis
  static final Map<String, dynamic> _businessData = {
    'products': [
      {
        'id': '1',
        'name': 'iPhone 15 Pro Max',
        'category': 'Teknoloji',
        'price': 65000.0,
        'stock': 15,
        'weeklySales': 8,
        'profit': 5200.0,
        'rating': 4.9,
        'reviews': [
          {'user': 'Ahmet Y.', 'rating': 5.0, 'comment': 'Harika ürün!'},
          {'user': 'Mehmet K.', 'rating': 5.0, 'comment': 'Çok memnun'},
        ],
      },
      {
        'id': '2',
        'name': 'Samsung Galaxy S24',
        'category': 'Teknoloji',
        'price': 55000.0,
        'stock': 8,
        'weeklySales': 12,
        'profit': 6600.0,
        'rating': 4.8,
        'reviews': [
          {'user': 'Ali Ç.', 'rating': 4.5, 'comment': 'İyi telefon'},
          {'user': 'Fatma Ö.', 'rating': 5.0, 'comment': 'Mükemmel'},
        ],
      },
      {
        'id': '3',
        'name': 'MacBook Pro M3',
        'category': 'Teknoloji',
        'price': 85000.0,
        'stock': 5,
        'weeklySales': 3,
        'profit': 2550.0,
        'rating': 4.9,
        'reviews': [
          {'user': 'Ömer K.', 'rating': 5.0, 'comment': 'İnanılmaz performans!'},
          {'user': 'Zeynep A.', 'rating': 4.8, 'comment': 'Pil ömrü çok iyi'},
        ],
      },
      {
        'id': '4',
        'name': 'AirPods Pro 2',
        'category': 'Teknoloji',
        'price': 8500.0,
        'stock': 25,
        'weeklySales': 20,
        'profit': 1700.0,
        'rating': 4.6,
        'reviews': [
          {'user': 'Selin K.', 'rating': 4.5, 'comment': 'Ses kalitesi harika'},
          {'user': 'Kemal Ö.', 'rating': 4.8, 'comment': 'Gürültü engelleme çok iyi'},
        ],
      },
      {
        'id': '5',
        'name': 'iPad Pro 12.9',
        'category': 'Teknoloji',
        'price': 45000.0,
        'stock': 12,
        'weeklySales': 6,
        'profit': 2700.0,
        'rating': 4.8,
        'reviews': [
          {'user': 'Deniz Y.', 'rating': 5.0, 'comment': 'Çizim için mükemmel'},
          {'user': 'Ece K.', 'rating': 4.7, 'comment': 'Çok kaliteli ekran'},
        ],
      },
      {
        'id': '6',
        'name': 'Dell XPS 15',
        'category': 'Teknoloji',
        'price': 72000.0,
        'stock': 3,
        'weeklySales': 1,
        'profit': 720.0,
        'rating': 4.7,
        'reviews': [
          {'user': 'Mert A.', 'rating': 4.0, 'comment': 'İyi ama biraz ağır'},
          {'user': 'Can Y.', 'rating': 4.5, 'comment': 'Gaming performansı mükemmel'},
        ],
      },
    ],
    'weeklyStats': {
      'totalSales': 43,
      'totalRevenue': 18470.0,
      'totalProfit': 18470.0,
      'averageRating': 4.8,
      'customerSatisfaction': 92,
      'topPerformingProduct': 'Samsung Galaxy S24',
      'lowestPerformingProduct': 'Dell XPS 15',
    },
    'customerReviews': [
      {'user': 'Ahmet Y.', 'rating': 5.0, 'comment': 'Harika hizmet, çok memnun kaldım!', 'date': '2024-01-15'},
      {'user': 'Mehmet K.', 'rating': 5.0, 'comment': 'Ürünler kaliteli, teslimat hızlı', 'date': '2024-01-14'},
      {'user': 'Ali Ç.', 'rating': 4.5, 'comment': 'İyi mağaza, tavsiye ederim', 'date': '2024-01-13'},
      {'user': 'Fatma Ö.', 'rating': 4.0, 'comment': 'Fiyatlar biraz yüksek ama kaliteli', 'date': '2024-01-12'},
      {'user': 'Ömer K.', 'rating': 5.0, 'comment': 'Mükemmel deneyim!', 'date': '2024-01-11'},
    ],
  };

  // Get analytics based on user query
  static List<Map<String, dynamic>> getAnalytics(String userInput) {
    final lowerInput = userInput.toLowerCase();
    final analytics = <Map<String, dynamic>>[];

    // Sales analysis
    if (_containsAny(lowerInput, ['satış', 'satışlar', 'sales', 'hangi ürün'])) {
      analytics.addAll(_getSalesAnalytics());
    }

    // Stock analysis
    if (_containsAny(lowerInput, ['stok', 'inventory', 'ürün', 'stok durumu'])) {
      analytics.addAll(_getStockAnalytics());
    }

    // Review analysis
    if (_containsAny(lowerInput, ['yorum', 'review', 'müşteri', 'değerlendirme'])) {
      analytics.addAll(_getReviewAnalytics());
    }

    // Profit analysis
    if (_containsAny(lowerInput, ['kar', 'profit', 'gelir', 'kazanç'])) {
      analytics.addAll(_getProfitAnalytics());
    }

    // Weekly report
    if (_containsAny(lowerInput, ['haftalık', 'weekly', 'rapor', 'özet'])) {
      analytics.addAll(_getWeeklyReport());
    }

    // General recommendations
    if (_containsAny(lowerInput, ['öneri', 'tavsiye', 'suggestion', 'ne yapmalı'])) {
      analytics.addAll(_getGeneralRecommendations());
    }

    // If no specific query, return weekly summary
    if (analytics.isEmpty) {
      analytics.addAll(_getWeeklySummary());
    }

    return analytics;
  }

  static List<Map<String, dynamic>> _getSalesAnalytics() {
    final products = _businessData['products'] as List<dynamic>;
    final topProduct = products.reduce((a, b) => a['weeklySales'] > b['weeklySales'] ? a : b);
    final lowProduct = products.reduce((a, b) => a['weeklySales'] < b['weeklySales'] ? a : b);
    
    // Sort products by sales for detailed analysis
    final sortedProducts = List<Map<String, dynamic>>.from(products);
    sortedProducts.sort((a, b) => (b['weeklySales'] as int).compareTo(a['weeklySales'] as int));

    return [
      {
        'type': 'sales',
        'title': '🔥 En Çok Satan Ürün',
        'description': '${topProduct['name']} - Bu hafta ${topProduct['weeklySales']} adet satıldı!\nToplam gelir: ₺${(topProduct['price'] * topProduct['weeklySales']).toStringAsFixed(0)}\nStok durumu: ${topProduct['stock']} adet',
        'recommendation': 'Bu ürünün stok seviyesini artırın ve benzer ürünler ekleyin. Müşteri talebi yüksek!',
        'isTopSeller': true,
      },
      {
        'type': 'warning',
        'title': '⚠️ En Az Satan Ürün',
        'description': '${lowProduct['name']} - Bu hafta sadece ${lowProduct['weeklySales']} adet satıldı\nStok: ${lowProduct['stock']} adet\nFiyat: ₺${lowProduct['price']}',
        'recommendation': 'Bu ürünü indirimle satmayı veya katalogdan çıkarmayı düşünün. Satış performansı düşük.',
        'isLowSeller': true,
      },
      {
        'type': 'sales',
        'title': '📊 Haftalık Satış Özeti',
        'description': 'Toplam ${_businessData['weeklyStats']['totalSales']} ürün satıldı\nOrtalama günlük satış: ${(_businessData['weeklyStats']['totalSales'] / 7).toStringAsFixed(1)} adet\nToplam gelir: ₺${_businessData['weeklyStats']['totalRevenue'].toStringAsFixed(0)}',
        'recommendation': 'Satış performansınız iyi, hedef müşteri kitlenizi genişletmeyi düşünün.',
        'showChart': true,
      },
      {
        'type': 'sales',
        'title': '🏆 Satış Sıralaması',
        'description': '1. ${sortedProducts[0]['name']} (${sortedProducts[0]['weeklySales']} adet)\n2. ${sortedProducts[1]['name']} (${sortedProducts[1]['weeklySales']} adet)\n3. ${sortedProducts[2]['name']} (${sortedProducts[2]['weeklySales']} adet)',
        'recommendation': 'En çok satan 3 ürününüzün stok seviyelerini kontrol edin.',
      },
    ];
  }

  static List<Map<String, dynamic>> _getStockAnalytics() {
    final products = _businessData['products'] as List<dynamic>;
    final lowStockProducts = products.where((p) => p['stock'] < 10).toList();
    final outOfStockProducts = products.where((p) => p['stock'] == 0).toList();
    final criticalStockProducts = products.where((p) => p['stock'] < 5).toList();

    final analytics = <Map<String, dynamic>>[];

    if (criticalStockProducts.isNotEmpty) {
      analytics.add({
        'type': 'warning',
        'title': '🚨 KRİTİK STOK UYARISI',
        'description': '${criticalStockProducts.length} ürünün stok seviyesi kritik (5 adetten az):\n${criticalStockProducts.map((p) => '• ${p['name']} (${p['stock']} adet)').join('\n')}',
        'recommendation': 'Bu ürünlerin stok seviyesini ACİLEN artırın!',
        'isCritical': true,
      });
    }

    if (outOfStockProducts.isNotEmpty) {
      analytics.add({
        'type': 'warning',
        'title': '❌ STOK TÜKENDİ',
        'description': '${outOfStockProducts.length} ürünün stoku tükendi:\n${outOfStockProducts.map((p) => '• ${p['name']}').join('\n')}',
        'recommendation': 'Bu ürünleri hemen sipariş edin!',
        'isOutOfStock': true,
      });
    }

    if (lowStockProducts.isNotEmpty) {
      analytics.add({
        'type': 'warning',
        'title': '⚠️ Düşük Stok Uyarısı',
        'description': '${lowStockProducts.length} ürünün stok seviyesi düşük (10 adetten az):\n${lowStockProducts.map((p) => '• ${p['name']} (${p['stock']} adet)').join('\n')}',
        'recommendation': 'Bu ürünlerin stok seviyesini artırın.',
      });
    }

    // Top sellers with low stock
    final topSellersWithLowStock = products.where((p) => p['weeklySales'] > 5 && p['stock'] < 10).toList();
    if (topSellersWithLowStock.isNotEmpty) {
      analytics.add({
        'type': 'warning',
        'title': '🔥 Çok Satan + Düşük Stok',
        'description': 'Bu ürünler çok satıyor ama stokları düşük:\n${topSellersWithLowStock.map((p) => '• ${p['name']} (${p['weeklySales']} satış, ${p['stock']} stok)').join('\n')}',
        'recommendation': 'Bu ürünlerin stok seviyesini ACİLEN artırın!',
        'isTopSellerLowStock': true,
      });
    }

    analytics.add({
      'type': 'stock',
      'title': '📦 Genel Stok Durumu',
      'description': 'Toplam ${products.length} ürününüz var\nOrtalama stok seviyesi: ${(products.fold(0.0, (sum, p) => sum + (p['stock'] as int)) / products.length).toStringAsFixed(0)} adet\nDüşük stoklu ürün: ${lowStockProducts.length} adet',
      'recommendation': 'Stok seviyelerinizi düzenli olarak kontrol edin.',
    });

    return analytics;
  }

  static List<Map<String, dynamic>> _getReviewAnalytics() {
    final reviews = _businessData['customerReviews'] as List<dynamic>;
    final averageRating = reviews.fold(0.0, (sum, r) => sum + r['rating']) / reviews.length;
    final positiveReviews = reviews.where((r) => r['rating'] >= 4).length;
    final negativeReviews = reviews.where((r) => r['rating'] < 3).length;

    return [
      {
        'type': 'reviews',
        'title': 'Müşteri Memnuniyeti',
        'description': 'Ortalama puan: ${averageRating.toStringAsFixed(1)}/5.0. ${positiveReviews} olumlu, ${negativeReviews} olumsuz yorum',
        'recommendation': 'Müşteri memnuniyetiniz yüksek, bu durumu koruyun.',
      },
      {
        'type': 'reviews',
        'title': 'Son Müşteri Yorumları',
        'description': 'En son yorumlar: ${reviews.take(3).map((r) => '${r['user']}: ${r['comment']}').join(', ')}',
        'recommendation': 'Müşteri geri bildirimlerini düzenli olarak takip edin.',
      },
    ];
  }

  static List<Map<String, dynamic>> _getProfitAnalytics() {
    final weeklyStats = _businessData['weeklyStats'];
    final products = _businessData['products'] as List<dynamic>;
    final totalProfit = products.fold(0.0, (sum, p) => sum + p['profit']);
    final profitMargin = (totalProfit / weeklyStats['totalRevenue']) * 100;

    return [
      {
        'type': 'profit',
        'title': 'Haftalık Kar Durumu',
        'description': 'Toplam gelir: ₺${weeklyStats['totalRevenue'].toStringAsFixed(0)}, Kar marjı: %${profitMargin.toStringAsFixed(1)}',
        'recommendation': 'Kar marjınız iyi, maliyetleri kontrol altında tutun.',
      },
      {
        'type': 'profit',
        'title': 'En Karlı Ürün',
        'description': 'Samsung Galaxy S24 - Haftalık kar: ₺${products.firstWhere((p) => p['name'] == 'Samsung Galaxy S24')['profit']}',
        'recommendation': 'Bu ürünün satışını artırmaya odaklanın.',
      },
    ];
  }

  static List<Map<String, dynamic>> _getWeeklyReport() {
    final weeklyStats = _businessData['weeklyStats'];
    final products = _businessData['products'] as List<dynamic>;

    return [
      {
        'type': 'sales',
        'title': 'Haftalık Satış Raporu',
        'description': 'Toplam ${weeklyStats['totalSales']} ürün satıldı. Gelir: ₺${weeklyStats['totalRevenue'].toStringAsFixed(0)}',
        'recommendation': 'Satış performansınız geçen haftaya göre %15 artış gösteriyor.',
      },
      {
        'type': 'reviews',
        'title': 'Müşteri Memnuniyeti',
        'description': 'Ortalama puan: ${weeklyStats['averageRating']}/5.0. Memnuniyet oranı: %${weeklyStats['customerSatisfaction']}',
        'recommendation': 'Müşteri memnuniyetiniz çok yüksek, bu durumu koruyun.',
      },
      {
        'type': 'profit',
        'title': 'Kar Analizi',
        'description': 'Haftalık kar: ₺${weeklyStats['totalProfit'].toStringAsFixed(0)}. Kar marjı: %${((weeklyStats['totalProfit'] / weeklyStats['totalRevenue']) * 100).toStringAsFixed(1)}',
        'recommendation': 'Kar performansınız hedeflerin üzerinde.',
      },
    ];
  }

  static List<Map<String, dynamic>> _getGeneralRecommendations() {
    final products = _businessData['products'] as List<dynamic>;
    final lowStockProducts = products.where((p) => p['stock'] < 10).toList();
    final lowSalesProducts = products.where((p) => p['weeklySales'] < 5).toList();

    final recommendations = <Map<String, dynamic>>[];

    if (lowStockProducts.isNotEmpty) {
      recommendations.add({
        'type': 'warning',
        'title': 'Stok Önerisi',
        'description': '${lowStockProducts.length} ürünün stok seviyesi düşük',
        'recommendation': 'Bu ürünlerin stok seviyesini artırın.',
      });
    }

    if (lowSalesProducts.isNotEmpty) {
      recommendations.add({
        'type': 'warning',
        'title': 'Satış Önerisi',
        'description': '${lowSalesProducts.length} ürünün satış performansı düşük',
        'recommendation': 'Bu ürünleri indirimle satmayı veya katalogdan çıkarmayı düşünün.',
      });
    }

    recommendations.add({
      'type': 'profit',
      'title': 'Gelecek Hafta Önerileri',
      'description': 'Mevcut performansınızla devam ederseniz %10 kar artışı bekleniyor',
      'recommendation': 'Müşteri hizmetlerini geliştirin ve yeni ürünler ekleyin.',
    });

    return recommendations;
  }

  static List<Map<String, dynamic>> _getWeeklySummary() {
    final weeklyStats = _businessData['weeklyStats'];
    final products = _businessData['products'] as List<dynamic>;

    return [
      {
        'type': 'sales',
        'title': 'Haftalık Özet',
        'description': '${weeklyStats['totalSales']} ürün satıldı, ₺${weeklyStats['totalRevenue'].toStringAsFixed(0)} gelir elde edildi',
        'recommendation': 'Performansınız iyi, hedeflerinizi koruyun.',
      },
      {
        'type': 'reviews',
        'title': 'Müşteri Memnuniyeti',
        'description': 'Ortalama puan: ${weeklyStats['averageRating']}/5.0',
        'recommendation': 'Müşteri memnuniyetiniz yüksek, bu durumu koruyun.',
      },
    ];
  }

  static bool _containsAny(String input, List<String> keywords) {
    return keywords.any((keyword) => input.contains(keyword));
  }

  // Get product performance data
  static List<Map<String, dynamic>> getProductPerformance() {
    final products = _businessData['products'] as List<dynamic>;
    return products.map((product) => {
      'name': product['name'],
      'sales': product['weeklySales'],
      'profit': product['profit'],
      'stock': product['stock'],
      'rating': product['rating'],
    }).toList();
  }

  // Get weekly trends
  static Map<String, dynamic> getWeeklyTrends() {
    return {
      'salesGrowth': 15.2,
      'profitGrowth': 12.8,
      'customerGrowth': 8.5,
      'topCategory': 'Teknoloji',
      'trendingProduct': 'Samsung Galaxy S24',
    };
  }

  // Get business insights
  static List<String> getBusinessInsights() {
    return [
      'Samsung Galaxy S24 en çok satan ürününüz',
      'Stok seviyeleriniz genel olarak iyi',
      'Müşteri memnuniyetiniz %92',
      'Haftalık kar marjınız %100',
      'Gelecek hafta %10 kar artışı bekleniyor',
    ];
  }
} 