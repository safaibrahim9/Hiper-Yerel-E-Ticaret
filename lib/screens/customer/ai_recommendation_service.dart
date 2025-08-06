import 'dart:math';

class AIRecommendationService {
  // Enhanced product database with reviews
  static final List<Map<String, dynamic>> _products = [
    // Teknoloji Ürünleri
    {
      'id': 'tech_1',
      'name': 'iPhone 15 Pro Max',
      'category': 'Teknoloji',
      'subcategory': 'Telefon',
      'price': 65000.0,
      'rating': 4.9,
      'brand': 'Apple',
      'features': ['5G', 'A17 Pro Chip', '48MP Kamera', 'Titanium Design'],
      'tags': ['telefon', 'iphone', 'apple', '5g', 'kamera', 'premium'],
      'description': 'En yeni iPhone modeli, A17 Pro chip ile güçlü performans',
      'reviews': [
        {'user': 'Ahmet Y.', 'rating': 5.0, 'comment': 'Harika kamera performansı!'},
        {'user': 'Mehmet K.', 'rating': 5.0, 'comment': 'Çok hızlı ve kaliteli'},
        {'user': 'Ayşe D.', 'rating': 4.5, 'comment': 'Biraz pahalı ama değer'},
      ],
    },
    {
      'id': 'tech_2',
      'name': 'Samsung Galaxy S24 Ultra',
      'category': 'Teknoloji',
      'subcategory': 'Telefon',
      'price': 55000.0,
      'rating': 4.8,
      'brand': 'Samsung',
      'features': ['5G', 'Snapdragon 8 Gen 3', '200MP Kamera', 'S Pen'],
      'tags': ['telefon', 'samsung', 'galaxy', '5g', 'kamera', 'ultra'],
      'description': 'S Pen destekli premium Android telefon',
      'reviews': [
        {'user': 'Ali Ç.', 'rating': 4.5, 'comment': 'S Pen çok kullanışlı'},
        {'user': 'Fatma Ö.', 'rating': 5.0, 'comment': 'Mükemmel kamera'},
        {'user': 'Can Y.', 'rating': 4.0, 'comment': 'İyi telefon ama büyük'},
      ],
    },
    {
      'id': 'tech_3',
      'name': 'MacBook Pro M3',
      'category': 'Teknoloji',
      'subcategory': 'Laptop',
      'price': 85000.0,
      'rating': 4.9,
      'brand': 'Apple',
      'features': ['M3 Chip', '14 inch', '22 Saat Pil', 'Liquid Retina XDR'],
      'tags': ['laptop', 'macbook', 'apple', 'm3', 'bilgisayar', 'pro'],
      'description': 'Profesyonel kullanım için tasarlanmış güçlü laptop',
      'reviews': [
        {'user': 'Ömer K.', 'rating': 5.0, 'comment': 'İnanılmaz performans!'},
        {'user': 'Zeynep A.', 'rating': 4.8, 'comment': 'Pil ömrü çok iyi'},
        {'user': 'Burak S.', 'rating': 5.0, 'comment': 'Tasarım harika'},
      ],
    },
    {
      'id': 'tech_4',
      'name': 'Dell XPS 15',
      'category': 'Teknoloji',
      'subcategory': 'Laptop',
      'price': 72000.0,
      'rating': 4.7,
      'brand': 'Dell',
      'features': ['Intel i9', '15.6 inch', '32GB RAM', 'RTX 4070'],
      'tags': ['laptop', 'dell', 'xps', 'intel', 'bilgisayar', 'gaming'],
      'description': 'Gaming ve profesyonel işler için ideal',
      'reviews': [
        {'user': 'Deniz Y.', 'rating': 4.5, 'comment': 'Gaming performansı mükemmel'},
        {'user': 'Ece K.', 'rating': 4.8, 'comment': 'Çok hızlı ve güçlü'},
        {'user': 'Mert A.', 'rating': 4.0, 'comment': 'İyi ama biraz ağır'},
      ],
    },
    {
      'id': 'tech_5',
      'name': 'iPad Pro 12.9',
      'category': 'Teknoloji',
      'subcategory': 'Tablet',
      'price': 45000.0,
      'rating': 4.8,
      'brand': 'Apple',
      'features': ['M2 Chip', '12.9 inch', '5G', 'Apple Pencil 2'],
      'tags': ['tablet', 'ipad', 'apple', 'm2', '5g', 'pro'],
      'description': 'Profesyonel tablet deneyimi',
      'reviews': [
        {'user': 'Selin K.', 'rating': 5.0, 'comment': 'Çizim için mükemmel'},
        {'user': 'Kemal Ö.', 'rating': 4.7, 'comment': 'Çok kaliteli ekran'},
        {'user': 'Elif Y.', 'rating': 4.5, 'comment': 'İyi ama pahalı'},
      ],
    },
    {
      'id': 'tech_6',
      'name': 'AirPods Pro 2',
      'category': 'Teknoloji',
      'subcategory': 'Kulaklık',
      'price': 8500.0,
      'rating': 4.6,
      'brand': 'Apple',
      'features': ['Aktif Gürültü Engelleme', 'Şeffaf Mod', 'Adaptive Audio'],
      'tags': ['kulaklık', 'airpods', 'apple', 'bluetooth', 'wireless'],
      'description': 'Gelişmiş ses kalitesi ve gürültü engelleme',
      'reviews': [
        {'user': 'Ahmet Y.', 'rating': 4.5, 'comment': 'Ses kalitesi harika'},
        {'user': 'Merve K.', 'rating': 4.8, 'comment': 'Gürültü engelleme çok iyi'},
        {'user': 'Cem Ö.', 'rating': 4.0, 'comment': 'İyi ama biraz pahalı'},
      ],
    },
    
    // Market Ürünleri
    {
      'id': 'market_1',
      'name': 'Sütaş Tam Yağlı Süt 1L',
      'category': 'Market',
      'subcategory': 'Süt Ürünleri',
      'price': 18.0,
      'rating': 4.5,
      'brand': 'Sütaş',
      'features': ['Tam Yağlı', 'Pastörize', 'Doğal'],
      'tags': ['süt', 'sütaş', 'market', 'süt ürünleri', 'organik'],
      'description': 'Doğal ve taze süt',
      'reviews': [
        {'user': 'Ayşe D.', 'rating': 4.5, 'comment': 'Çok taze ve lezzetli'},
        {'user': 'Mehmet K.', 'rating': 4.0, 'comment': 'İyi kalite'},
        {'user': 'Fatma Ö.', 'rating': 5.0, 'comment': 'Her zaman alıyorum'},
      ],
    },
    {
      'id': 'market_2',
      'name': 'Köy Ekmeği Tam Buğday',
      'category': 'Market',
      'subcategory': 'Fırın Ürünleri',
      'price': 12.0,
      'rating': 4.3,
      'brand': 'Köy Ekmeği',
      'features': ['Tam Buğday', 'Katkısız', 'Taze'],
      'tags': ['ekmek', 'tam buğday', 'market', 'fırın', 'sağlıklı'],
      'description': 'Sağlıklı ve besleyici tam buğday ekmeği',
      'reviews': [
        {'user': 'Ali Ç.', 'rating': 4.0, 'comment': 'Sağlıklı ve lezzetli'},
        {'user': 'Zeynep A.', 'rating': 4.5, 'comment': 'Her gün alıyorum'},
        {'user': 'Can Y.', 'rating': 4.0, 'comment': 'İyi kalite'},
      ],
    },
    {
      'id': 'market_3',
      'name': 'Pınar Beyaz Peynir 500g',
      'category': 'Market',
      'subcategory': 'Süt Ürünleri',
      'price': 32.0,
      'rating': 4.6,
      'brand': 'Pınar',
      'features': ['Beyaz Peynir', '500g', 'Doğal'],
      'tags': ['peynir', 'pınar', 'market', 'süt ürünleri', 'protein'],
      'description': 'Geleneksel lezzet, doğal içerik',
      'reviews': [
        {'user': 'Ömer K.', 'rating': 4.5, 'comment': 'Çok lezzetli'},
        {'user': 'Selin K.', 'rating': 4.8, 'comment': 'Kaliteli peynir'},
        {'user': 'Burak S.', 'rating': 4.0, 'comment': 'İyi ama biraz pahalı'},
      ],
    },
    {
      'id': 'market_4',
      'name': 'Domates 1kg',
      'category': 'Market',
      'subcategory': 'Sebze',
      'price': 15.0,
      'rating': 4.2,
      'brand': 'Taze Ürün',
      'features': ['Taze', 'Organik', '1kg'],
      'tags': ['domates', 'sebze', 'market', 'taze', 'organik'],
      'description': 'Taze ve lezzetli domates',
      'reviews': [
        {'user': 'Deniz Y.', 'rating': 4.0, 'comment': 'Taze ve lezzetli'},
        {'user': 'Ece K.', 'rating': 4.5, 'comment': 'Çok güzel domatesler'},
        {'user': 'Mert A.', 'rating': 4.0, 'comment': 'İyi kalite'},
      ],
    },
    
    // Restoran Ürünleri
    {
      'id': 'rest_1',
      'name': 'Margherita Pizza',
      'category': 'Restoran',
      'subcategory': 'Pizza',
      'price': 65.0,
      'rating': 4.7,
      'brand': 'Pizza Köşesi',
      'features': ['Domates Sosu', 'Mozzarella', 'Fesleğen', '30cm'],
      'tags': ['pizza', 'margherita', 'restoran', 'italyan', 'geleneksel'],
      'description': 'Geleneksel İtalyan lezzeti',
      'reviews': [
        {'user': 'Kemal Ö.', 'rating': 4.5, 'comment': 'Harika pizza!'},
        {'user': 'Elif Y.', 'rating': 4.8, 'comment': 'Çok lezzetli'},
        {'user': 'Cem Ö.', 'rating': 4.0, 'comment': 'İyi ama biraz küçük'},
      ],
    },
    {
      'id': 'rest_2',
      'name': 'Cheeseburger Deluxe',
      'category': 'Restoran',
      'subcategory': 'Burger',
      'price': 45.0,
      'rating': 4.5,
      'brand': 'Burger House',
      'features': ['Dana Eti', 'Cheddar', 'Marul', 'Domates'],
      'tags': ['burger', 'cheeseburger', 'restoran', 'fast food', 'dana'],
      'description': 'Özel soslu lezzetli burger',
      'reviews': [
        {'user': 'Merve K.', 'rating': 4.5, 'comment': 'Çok lezzetli burger'},
        {'user': 'Ahmet Y.', 'rating': 4.0, 'comment': 'İyi ama biraz pahalı'},
        {'user': 'Ayşe D.', 'rating': 4.8, 'comment': 'Mükemmel lezzet!'},
      ],
    },
    {
      'id': 'rest_3',
      'name': 'Sushi Set Premium',
      'category': 'Restoran',
      'subcategory': 'Sushi',
      'price': 120.0,
      'rating': 4.9,
      'brand': 'Sushi Bar',
      'features': ['Somon', 'Avokado', 'Wasabi', '12 Parça'],
      'tags': ['sushi', 'japon', 'restoran', 'deniz ürünleri', 'premium'],
      'description': 'Premium kalite sushi seti',
      'reviews': [
        {'user': 'Selin K.', 'rating': 5.0, 'comment': 'Mükemmel sushi!'},
        {'user': 'Ömer K.', 'rating': 4.8, 'comment': 'Çok taze ve lezzetli'},
        {'user': 'Zeynep A.', 'rating': 5.0, 'comment': 'Harika deneyim'},
      ],
    },
    {
      'id': 'rest_4',
      'name': 'Kebap Karışık',
      'category': 'Restoran',
      'subcategory': 'Kebap',
      'price': 85.0,
      'rating': 4.6,
      'brand': 'Kebap Dünyası',
      'features': ['Dana Eti', 'Kuzu Eti', 'Pilav', 'Salata'],
      'tags': ['kebap', 'türk', 'restoran', 'et', 'geleneksel'],
      'description': 'Geleneksel Türk lezzeti',
      'reviews': [
        {'user': 'Can Y.', 'rating': 4.5, 'comment': 'Geleneksel lezzet'},
        {'user': 'Deniz Y.', 'rating': 4.8, 'comment': 'Çok lezzetli kebap'},
        {'user': 'Ece K.', 'rating': 4.0, 'comment': 'İyi ama biraz pahalı'},
      ],
    },
  ];

  // Enhanced AI-powered recommendation based on user input
  static List<Map<String, dynamic>> getRecommendations(String userInput) {
    final lowerInput = userInput.toLowerCase();
    final recommendations = <Map<String, dynamic>>[];
    
    // Price range detection
    final priceRange = _detectPriceRange(lowerInput);
    
    // Analyze user input for intent with enhanced logic
    if (_containsAny(lowerInput, ['telefon', 'iphone', 'samsung', 'android', 'mobile'])) {
      recommendations.addAll(_getProductsByCategory('Teknoloji', 'Telefon'));
    } else if (_containsAny(lowerInput, ['laptop', 'bilgisayar', 'macbook', 'dell', 'computer'])) {
      recommendations.addAll(_getProductsByCategory('Teknoloji', 'Laptop'));
    } else if (_containsAny(lowerInput, ['tablet', 'ipad', 'tablet'])) {
      recommendations.addAll(_getProductsByCategory('Teknoloji', 'Tablet'));
    } else if (_containsAny(lowerInput, ['kulaklık', 'airpods', 'headphone'])) {
      recommendations.addAll(_getProductsByCategory('Teknoloji', 'Kulaklık'));
    } else if (_containsAny(lowerInput, ['süt', 'sütaş', 'milk'])) {
      recommendations.addAll(_getProductsByCategory('Market', 'Süt Ürünleri'));
    } else if (_containsAny(lowerInput, ['ekmek', 'fırın', 'bread'])) {
      recommendations.addAll(_getProductsByCategory('Market', 'Fırın Ürünleri'));
    } else if (_containsAny(lowerInput, ['peynir', 'süt ürünleri', 'cheese'])) {
      recommendations.addAll(_getProductsByCategory('Market', 'Süt Ürünleri'));
    } else if (_containsAny(lowerInput, ['sebze', 'domates', 'vegetable'])) {
      recommendations.addAll(_getProductsByCategory('Market', 'Sebze'));
    } else if (_containsAny(lowerInput, ['pizza', 'italyan', 'pizza'])) {
      recommendations.addAll(_getProductsByCategory('Restoran', 'Pizza'));
    } else if (_containsAny(lowerInput, ['burger', 'fast food', 'hamburger'])) {
      recommendations.addAll(_getProductsByCategory('Restoran', 'Burger'));
    } else if (_containsAny(lowerInput, ['sushi', 'japon', 'sushi'])) {
      recommendations.addAll(_getProductsByCategory('Restoran', 'Sushi'));
    } else if (_containsAny(lowerInput, ['kebap', 'türk', 'kebab'])) {
      recommendations.addAll(_getProductsByCategory('Restoran', 'Kebap'));
    } else {
      // General search based on tags and name
      recommendations.addAll(_searchByTagsAndName(lowerInput));
    }
    
    // Filter by price range if detected
    if (priceRange != null) {
      recommendations.removeWhere((product) => 
        product['price'] < priceRange['min'] || product['price'] > priceRange['max']
      );
    }
    
    // Sort by relevance and rating
    recommendations.sort((a, b) {
      final aRelevance = _calculateRelevance(a, lowerInput);
      final bRelevance = _calculateRelevance(b, lowerInput);
      if (aRelevance != bRelevance) {
        return bRelevance.compareTo(aRelevance);
      }
      return (b['rating'] as double).compareTo(a['rating'] as double);
    });
    
    return recommendations.take(5).toList();
  }

  // Get product with reviews
  static Map<String, dynamic>? getProductWithReviews(String productId) {
    try {
      return _products.firstWhere((product) => product['id'] == productId);
    } catch (e) {
      return null;
    }
  }

  // Get top rated products
  static List<Map<String, dynamic>> getTopRatedProducts({int limit = 5}) {
    final sortedProducts = List<Map<String, dynamic>>.from(_products);
    sortedProducts.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
    return sortedProducts.take(limit).toList();
  }

  // Get products by rating range
  static List<Map<String, dynamic>> getProductsByRating(double minRating) {
    return _products.where((product) => product['rating'] >= minRating).toList();
  }

  // Get products with positive reviews
  static List<Map<String, dynamic>> getProductsWithPositiveReviews() {
    return _products.where((product) {
      final reviews = product['reviews'] as List<dynamic>;
      final avgRating = reviews.fold(0.0, (sum, review) => sum + review['rating']) / reviews.length;
      return avgRating >= 4.5;
    }).toList();
  }

  static Map<String, double>? _detectPriceRange(String input) {
    if (_containsAny(input, ['ucuz', 'ekonomik', 'bütçe', 'düşük fiyat'])) {
      return {'min': 0, 'max': 50};
    } else if (_containsAny(input, ['orta', 'normal', 'standart'])) {
      return {'min': 30, 'max': 200};
    } else if (_containsAny(input, ['pahalı', 'premium', 'yüksek', 'kaliteli'])) {
      return {'min': 150, 'max': 100000};
    }
    return null;
  }

  static List<Map<String, dynamic>> _getProductsByCategory(String category, String subcategory) {
    return _products.where((product) => 
      product['category'] == category && product['subcategory'] == subcategory
    ).toList();
  }

  static List<Map<String, dynamic>> _searchByTagsAndName(String query) {
    return _products.where((product) {
      final tags = product['tags'] as List<String>;
      final name = product['name'] as String;
      final description = product['description'] as String;
      
      return tags.any((tag) => tag.contains(query)) ||
             name.toLowerCase().contains(query) ||
             description.toLowerCase().contains(query);
    }).toList();
  }

  static bool _containsAny(String input, List<String> keywords) {
    return keywords.any((keyword) => input.contains(keyword));
  }

  static double _calculateRelevance(Map<String, dynamic> product, String query) {
    double relevance = 0.0;
    final tags = product['tags'] as List<String>;
    final name = product['name'] as String;
    final brand = product['brand'] as String;
    final description = product['description'] as String;
    
    // Check exact name match
    if (name.toLowerCase().contains(query)) relevance += 5.0;
    
    // Check brand match
    if (brand.toLowerCase().contains(query)) relevance += 3.0;
    
    // Check description match
    if (description.toLowerCase().contains(query)) relevance += 2.0;
    
    // Check tag matches
    for (final tag in tags) {
      if (tag.contains(query)) relevance += 1.5;
    }
    
    // Boost by rating
    relevance += (product['rating'] as double) * 0.8;
    
    return relevance;
  }

  // Get personalized recommendations based on user preferences
  static List<Map<String, dynamic>> getPersonalizedRecommendations({
    List<String>? preferredCategories,
    double? maxPrice,
    List<String>? preferredBrands,
  }) {
    var recommendations = List<Map<String, dynamic>>.from(_products);
    
    // Filter by preferred categories
    if (preferredCategories != null && preferredCategories.isNotEmpty) {
      recommendations = recommendations.where((product) => 
        preferredCategories.contains(product['category'])
      ).toList();
    }
    
    // Filter by max price
    if (maxPrice != null) {
      recommendations = recommendations.where((product) => 
        (product['price'] as double) <= maxPrice
      ).toList();
    }
    
    // Filter by preferred brands
    if (preferredBrands != null && preferredBrands.isNotEmpty) {
      recommendations = recommendations.where((product) => 
        preferredBrands.contains(product['brand'])
      ).toList();
    }
    
    // Sort by rating
    recommendations.sort((a, b) => 
      (b['rating'] as double).compareTo(a['rating'] as double)
    );
    
    return recommendations.take(10).toList();
  }

  // Get trending products
  static List<Map<String, dynamic>> getTrendingProducts() {
    final random = Random();
    final trending = <Map<String, dynamic>>[];
    
    // Simulate trending products with weighted selection
    final popularProducts = [
      _products[0], // iPhone 15 Pro Max
      _products[2], // MacBook Pro M3
      _products[6], // AirPods Pro 2
      _products[8], // Pınar Peynir
      _products[10], // Cheeseburger Deluxe
    ];
    
    for (int i = 0; i < 5; i++) {
      final randomIndex = random.nextInt(popularProducts.length);
      trending.add(popularProducts[randomIndex]);
    }
    
    return trending;
  }

  // Get similar products
  static List<Map<String, dynamic>> getSimilarProducts(String productId) {
    final product = _products.firstWhere((p) => p['id'] == productId);
    final category = product['category'];
    final subcategory = product['subcategory'];
    
    return _products.where((p) => 
      p['category'] == category && 
      p['subcategory'] == subcategory &&
      p['id'] != productId
    ).take(3).toList();
  }

  // Enhanced user sentiment analysis
  static String analyzeUserSentiment(String userInput) {
    final lowerInput = userInput.toLowerCase();
    
    if (_containsAny(lowerInput, ['ucuz', 'ekonomik', 'bütçe', 'düşük fiyat'])) {
      return 'Bütçe dostu seçenekler arıyorsunuz. Size en uygun fiyatlı ürünleri önerebilirim.';
    }
    
    if (_containsAny(lowerInput, ['kaliteli', 'premium', 'en iyi', 'yüksek kalite'])) {
      return 'Kaliteli ürünler arıyorsunuz. Size en yüksek puanlı ve premium seçenekleri gösterebilirim.';
    }
    
    if (_containsAny(lowerInput, ['hızlı', 'acil', 'hemen', 'çabuk'])) {
      return 'Hızlı teslimat arıyorsunuz. Size en yakın ve hızlı teslimat yapan mağazaları önerebilirim.';
    }
    
    if (_containsAny(lowerInput, ['yeni', 'son model', 'güncel', 'latest'])) {
      return 'Yeni ürünler arıyorsunuz. Size en güncel ve yeni çıkan ürünleri gösterebilirim.';
    }
    
    if (_containsAny(lowerInput, ['sağlıklı', 'organik', 'doğal', 'healthy'])) {
      return 'Sağlıklı ürünler arıyorsunuz. Size organik ve doğal seçenekleri gösterebilirim.';
    }
    
    return 'Size nasıl yardımcı olabilirim? Hangi tür ürün arıyorsunuz?';
  }

  // Get product suggestions based on context
  static List<Map<String, dynamic>> getContextualSuggestions(String context) {
    final lowerContext = context.toLowerCase();
    
    if (_containsAny(lowerContext, ['çalışma', 'iş', 'ofis'])) {
      return _getProductsByCategory('Teknoloji', 'Laptop');
    } else if (_containsAny(lowerContext, ['spor', 'fitness', 'egzersiz'])) {
      return _getProductsByCategory('Teknoloji', 'Kulaklık');
    } else if (_containsAny(lowerContext, ['yemek', 'kahvaltı', 'beslenme'])) {
      return _getProductsByCategory('Market', 'Süt Ürünleri');
    } else if (_containsAny(lowerContext, ['eğlence', 'parti', 'sosyal'])) {
      return _getProductsByCategory('Restoran', 'Pizza');
    }
    
    return getTrendingProducts();
  }
} 