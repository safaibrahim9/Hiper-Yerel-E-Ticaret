class EducationalAssistantService {
  static final List<Map<String, dynamic>> _technicalTerms = [
    {
      "term": "Gürültü engelleme",
      "aliases": ["Noise cancelling", "ANC", "Aktif gürültü engelleme"],
      "category": "Kulaklık",
      "definition": "Kulaklığın dış ortamdaki sesleri algılayıp bastırarak sessiz bir deneyim sunmasıdır.",
      "example": "Sony WH-1000XM5 modeli aktif gürültü engelleyici özelliğe sahiptir.",
      "benefits": ["Sessiz müzik dinleme", "Odaklanma artışı", "Yolculukta konfor"],
    },
    {
      "term": "IPS ekran",
      "aliases": ["In-Plane Switching", "geniş görüş açılı ekran"],
      "category": "Ekran",
      "definition": "Geniş görüş açısı ve renk doğruluğu sunan ekran teknolojisidir.",
      "example": "Bu ürün IPS ekran özelliği ile öne çıkar.",
      "benefits": ["Geniş görüş açısı", "Renk doğruluğu", "Profesyonel kullanım"],
    },
    {
      "term": "OLED ekran",
      "aliases": ["AMOLED", "organik LED", "OLED display"],
      "category": "Ekran",
      "definition": "Her pikselin kendinden ışık yaydığı, kontrastı yüksek ekran türüdür.",
      "example": "Bu ürün OLED ekran özelliği ile öne çıkar.",
      "benefits": ["Yüksek kontrast", "Enerji tasarrufu", "Gerçek siyahlar"],
    },
    {
      "term": "SSD",
      "aliases": ["Solid State Drive", "katı hal diski", "hızlı disk"],
      "category": "Depolama",
      "definition": "Hareketli parça içermeyen hızlı veri depolama birimi.",
      "example": "Bu ürün SSD özelliği ile öne çıkar.",
      "benefits": ["Hızlı açılış", "Düşük güç tüketimi", "Dayanıklılık"],
    },
    {
      "term": "Retina ekran",
      "aliases": ["yüksek çözünürlük", "Apple ekran"],
      "category": "Ekran",
      "definition": "Apple'ın yüksek çözünürlüklü ekran teknolojisi.",
      "example": "Bu ürün Retina ekran özelliği ile öne çıkar.",
      "benefits": ["Keskin görüntü", "Renk doğruluğu", "Profesyonel kullanım"],
    },
    {
      "term": "120Hz ekran",
      "aliases": ["yüksek yenileme hızı", "akıcı ekran", "120Hz panel"],
      "category": "Ekran",
      "definition": "Daha akıcı görüntü için saniyede 120 kare yenileme hızı sağlar.",
      "example": "Bu ürün 120Hz ekran özelliği ile öne çıkar.",
      "benefits": ["Akıcı oyun deneyimi", "Daha az göz yorgunluğu", "Profesyonel kullanım"],
    },
    {
      "term": "M.2 NVMe",
      "aliases": ["NVMe SSD", "yüksek hızlı SSD"],
      "category": "Depolama",
      "definition": "Yüksek hızlı yeni nesil SSD türü.",
      "example": "Bu ürün M.2 NVMe özelliği ile öne çıkar.",
      "benefits": ["Ultra hızlı veri transferi", "Oyun performansı", "Profesyonel kullanım"],
    },
    {
      "term": "eMMC",
      "aliases": ["gömülü bellek", "mobil bellek"],
      "category": "Depolama",
      "definition": "Mobil cihazlarda kullanılan gömülü bellek teknolojisi.",
      "example": "Bu ürün eMMC özelliği ile öne çıkar.",
      "benefits": ["Uygun fiyat", "Düşük güç tüketimi", "Kompakt boyut"],
    },
    {
      "term": "5G",
      "aliases": ["beşinci nesil", "yüksek hız"],
      "category": "İletişim",
      "definition": "Beşinci nesil mobil iletişim teknolojisi, ultra hızlı internet sağlar.",
      "example": "Bu ürün 5G özelliği ile öne çıkar.",
      "benefits": ["Ultra hızlı internet", "Düşük gecikme", "Yüksek kapasite"],
    },
    {
      "term": "Wi-Fi 6",
      "aliases": ["802.11ax", "yeni nesil wifi"],
      "category": "İletişim",
      "definition": "Yeni nesil kablosuz ağ teknolojisi, daha hızlı ve stabil bağlantı sağlar.",
      "example": "Bu ürün Wi-Fi 6 özelliği ile öne çıkar.",
      "benefits": ["Yüksek hız", "Düşük gecikme", "Çoklu cihaz desteği"],
    },
    {
      "term": "Bluetooth 5.0",
      "aliases": ["bluetooth", "kablosuz bağlantı"],
      "category": "İletişim",
      "definition": "Gelişmiş kablosuz bağlantı teknolojisi, daha hızlı ve uzun mesafeli iletişim.",
      "example": "Bu ürün Bluetooth 5.0 özelliği ile öne çıkar.",
      "benefits": ["Hızlı veri transferi", "Uzun mesafe", "Düşük güç tüketimi"],
    },
    {
      "term": "USB-C",
      "aliases": ["type-c", "yeni usb"],
      "category": "Bağlantı",
      "definition": "Çift yönlü, hızlı veri transferi ve şarj özelliği olan bağlantı standardı.",
      "example": "Bu ürün USB-C özelliği ile öne çıkar.",
      "benefits": ["Hızlı şarj", "Hızlı veri transferi", "Çift yönlü kullanım"],
    },
    {
      "term": "Thunderbolt",
      "aliases": ["hızlı bağlantı", "profesyonel port"],
      "category": "Bağlantı",
      "definition": "Ultra hızlı veri transferi ve güç aktarımı sağlayan bağlantı standardı.",
      "example": "Bu ürün Thunderbolt özelliği ile öne çıkar.",
      "benefits": ["Ultra hızlı transfer", "Güç aktarımı", "Profesyonel kullanım"],
    },
    {
      "term": "Face ID",
      "aliases": ["yüz tanıma", "biyometrik güvenlik"],
      "category": "Güvenlik",
      "definition": "Yüz tanıma teknolojisi ile güvenli kimlik doğrulama sistemi.",
      "example": "Bu ürün Face ID özelliği ile öne çıkar.",
      "benefits": ["Güvenli erişim", "Hızlı açılış", "Kullanım kolaylığı"],
    },
    {
      "term": "Touch ID",
      "aliases": ["parmak izi", "biyometrik"],
      "category": "Güvenlik",
      "definition": "Parmak izi tanıma teknolojisi ile güvenli kimlik doğrulama.",
      "example": "Bu ürün Touch ID özelliği ile öne çıkar.",
      "benefits": ["Güvenli erişim", "Hızlı açılış", "Kullanım kolaylığı"],
    },
    {
      "term": "Dolby Atmos",
      "aliases": ["3d ses", "çevresel ses"],
      "category": "Ses",
      "definition": "Üç boyutlu çevresel ses deneyimi sunan ses teknolojisi.",
      "example": "Bu ürün Dolby Atmos özelliği ile öne çıkar.",
      "benefits": ["3D ses deneyimi", "Gerçekçi ses", "Sinema deneyimi"],
    },
    {
      "term": "HDR",
      "aliases": ["yüksek dinamik aralık", "geniş renk paleti"],
      "category": "Görüntü",
      "definition": "Yüksek dinamik aralık, daha geniş renk paleti ve kontrast sağlar.",
      "example": "Bu ürün HDR özelliği ile öne çıkar.",
      "benefits": ["Gerçekçi renkler", "Yüksek kontrast", "Sinema deneyimi"],
    },
    {
      "term": "4K",
      "aliases": ["ultra hd", "yüksek çözünürlük"],
      "category": "Görüntü",
      "definition": "3840x2160 piksel çözünürlük, ultra yüksek kaliteli görüntü.",
      "example": "Bu ürün 4K özelliği ile öne çıkar.",
      "benefits": ["Keskin görüntü", "Detaylı görüntü", "Profesyonel kullanım"],
    },
    {
      "term": "8K",
      "aliases": ["ultra yüksek çözünürlük", "gelecek teknoloji"],
      "category": "Görüntü",
      "definition": "7680x4320 piksel çözünürlük, ultra yüksek kaliteli görüntü.",
      "example": "Bu ürün 8K özelliği ile öne çıkar.",
      "benefits": ["Ultra keskin görüntü", "Gelecek teknoloji", "Profesyonel kullanım"],
    },
    {
      "term": "Ray Tracing",
      "aliases": ["ışın takibi", "gerçekçi grafik"],
      "category": "Grafik",
      "definition": "Gerçekçi ışık yansımaları ve gölgeler oluşturan grafik teknolojisi.",
      "example": "Bu ürün Ray Tracing özelliği ile öne çıkar.",
      "benefits": ["Gerçekçi grafikler", "Gelişmiş oyun deneyimi", "Profesyonel kullanım"],
    },
    {
      "term": "DLSS",
      "aliases": ["yapay zeka grafik", "nvidia teknoloji"],
      "category": "Grafik",
      "definition": "Yapay zeka destekli grafik teknolojisi, performansı artırır.",
      "example": "Bu ürün DLSS özelliği ile öne çıkar.",
      "benefits": ["Yüksek performans", "Düşük güç tüketimi", "Gelişmiş oyun deneyimi"],
    },
  ];

  static Map<String, dynamic>? extractTermFromText(String text) {
    final textLower = text.toLowerCase();
    
    for (final termData in _technicalTerms) {
      final allKeywords = [termData["term"].toLowerCase()] + 
          (termData["aliases"] as List).map((alias) => alias.toLowerCase()).toList();
      
      if (allKeywords.any((keyword) => textLower.contains(keyword))) {
        return termData;
      }
    }
    
    return null;
  }

  static String generateExplanation(Map<String, dynamic> termData) {
    final benefits = (termData["benefits"] as List).join(", ");
    
    return '''
🧠 **${termData["term"]}** (${termData["category"]})

📖 **Açıklama:** ${termData["definition"]}

💡 **Örnek:** ${termData["example"]}

✅ **Avantajlar:** $benefits

🔍 **Alternatif İsimler:** ${(termData["aliases"] as List).join(", ")}
''';
  }

  static String generateResponse(String userQuestion) {
    final termData = extractTermFromText(userQuestion);
    
    if (termData != null) {
      return generateExplanation(termData);
    } else {
      return '''
🤔 Bu terimi henüz bilmiyorum. 

💡 Size yardımcı olabileceğim konular:
• Teknik terim açıklamaları
• Ürün özellikleri hakkında bilgi
• Teknoloji terimleri

🔍 Hangi terim hakkında bilgi almak istiyorsunuz?
''';
    }
  }

  static List<String> getRelatedTerms(String category) {
    return _technicalTerms
        .where((term) => term["category"] == category)
        .map((term) => term["term"] as String)
        .toList();
  }

  static List<Map<String, dynamic>> getTermsByCategory(String category) {
    return _technicalTerms
        .where((term) => term["category"] == category)
        .toList();
  }

  static List<String> getAllCategories() {
    return _technicalTerms
        .map((term) => term["category"] as String)
        .toSet()
        .toList();
  }
} 