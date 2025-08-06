# Hiper Yerel E-Ticaret Mobil Uygulaması

Bu proje, Flutter kullanılarak geliştirilmiş hiper-yerel e-ticaret mobil uygulamasıdır. Uygulama hem müşteriler (kullanıcılar) hem de işletmeler (esnaflar) için ayrı arayüzler sunmaktadır.

## 🚀 Özellikler

### Müşteri (Customer) Uygulaması
- **Ana Sayfa**: Konum bazlı işletme keşfi, kategoriler, popüler ürünler
- **Kategori Filtreleme**: Market, Restoran, Kafe, Teknoloji, Giyim, Kozmetik vb.
- **İşletme Detayları**: Ürün listesi, fiyatlar, yorumlar, harita konumu
- **Sepet Yönetimi**: Ürün ekleme/çıkarma, miktar güncelleme
- **Sipariş Takibi**: Aktif ve geçmiş siparişler
- **Profil Yönetimi**: Kişisel bilgiler, adresler, ayarlar
- **AI Asistan**: Yapay zeka destekli ürün önerileri
- **SSS (FAQ)**: Eğitici mod ile teknik terim açıklamaları

### İşletme (Business) Uygulaması
- **Giriş Sistemi**: Email/şifre ile güvenli giriş
- **Ana Sayfa**: Sipariş yönetimi, hızlı işlemler
- **Ürün Yönetimi**: Ürün ekleme, düzenleme, stok takibi
- **Sipariş Yönetimi**: Bekleyen siparişler, durum güncelleme
- **Raporlar**: Haftalık, aylık, yıllık satış raporları
- **AI Analitik**: İşletme performans analizi ve öneriler
- **Profil Yönetimi**: İşletme bilgileri, ayarlar

## 🛠️ Teknolojiler

### Frontend
- **Flutter**: 3.2.3+ (Dart SDK)
- **Provider**: State management
- **Go Router**: Navigation
- **Cached Network Image**: Görsel yönetimi

### Backend (Simüle Edilmiş)
- **Node.js/Django**: API servisleri
- **PostgreSQL/MongoDB**: Veritabanı
- **Socket.IO**: Gerçek zamanlı iletişim

### Haritalar ve Konum
- **Google Maps API**: Harita entegrasyonu
- **Geolocator**: Konum servisleri
- **Geocoding**: Adres çözümleme

### Bildirimler ve Ödeme
- **Firebase Cloud Messaging**: Push bildirimleri
- **Stripe**: Ödeme entegrasyonu (test ortamı)

## 📱 Ekran Görüntüleri

### Müşteri Uygulaması
- Ana sayfa ile kategori filtreleme
- İşletme detay sayfaları
- Sepet yönetimi
- AI asistan entegrasyonu

### İşletme Uygulaması
- Giriş ekranı
- Ana sayfa dashboard
- Ürün yönetimi
- Raporlar ve analitik

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK 3.2.3+
- Dart SDK
- Android Studio / VS Code
- Git

### Kurulum Adımları

1. **Projeyi klonlayın**
```bash
git clone https://github.com/yourusername/hiper-yerel-ecommerce.git
cd hiper-yerel-ecommerce
```

2. **Bağımlılıkları yükleyin**
```bash
flutter pub get
```

3. **Uygulamayı çalıştırın**
```bash
flutter run
```

### Platform Desteği
- ✅ Android
- ✅ iOS
- ✅ Web (Chrome)
- ✅ Windows (Desktop)

## 📁 Proje Yapısı

```
lib/
├── main.dart                 # Uygulama giriş noktası
├── providers/               # State management
│   ├── cart_provider.dart
│   ├── location_provider.dart
│   └── ...
├── screens/                 # Ekranlar
│   ├── customer/           # Müşteri ekranları
│   │   ├── home_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── orders_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── business_detail_screen.dart
│   │   ├── faq_screen.dart
│   │   └── ...
│   └── business/           # İşletme ekranları
│       ├── login_screen.dart
│       ├── home_screen.dart
│       ├── products_screen.dart
│       ├── reports_screen.dart
│       ├── profile_screen.dart
│       └── ...
├── models/                 # Veri modelleri
├── services/              # Servisler
│   ├── ai_recommendation_service.dart
│   ├── business_ai_analytics_service.dart
│   ├── educational_assistant_service.dart
│   └── ...
├── utils/                 # Yardımcı sınıflar
│   ├── constants.dart
│   ├── theme.dart
│   └── ...
└── widgets/               # Yeniden kullanılabilir widget'lar
```

## 🎯 Özellik Detayları

### AI Asistan (Müşteri)
- Teknoloji ürünleri için öneriler
- Kullanıcı tercihlerine göre kişiselleştirilmiş öneriler
- Ürün detaylarına kolay erişim

### AI Analitik (İşletme)
- Haftalık satış analizi
- Stok seviyesi uyarıları
- Müşteri yorumları analizi
- Kar/zarar raporları
- Gelecek önerileri

### Eğitici FAQ Sistemi
- Teknik terim açıklamaları
- Kategori bazlı sorular
- AI destekli cevaplar

## 🔧 Konfigürasyon

### API Anahtarları
```dart
// lib/utils/constants.dart
class AppConstants {
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
}
```

### Tema Ayarları
```dart
// lib/utils/theme.dart
class AppTheme {
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF1976D2);
  // ...
}
```

## 📊 Veri Yapısı

### Ürün Modeli
```dart
{
  'id': '1',
  'name': 'iPhone 15 Pro Max',
  'businessId': '1',
  'businessName': 'Teknoloji Dünyası',
  'category': 'Teknoloji',
  'price': 65000.0,
  'image': 'https://...',
  'description': '...',
  'stock': 10
}
```

### İşletme Modeli
```dart
{
  'id': '1',
  'name': 'Teknoloji Dünyası',
  'category': 'Teknoloji',
  'rating': 4.8,
  'distance': '0.3 km',
  'isOpen': true,
  'deliveryTime': '20-30 dk',
  'minOrder': '₺100',
  'deliveryFee': '₺8'
}
```

## 🧪 Test

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📦 Build

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/AmazingFeature`)
3. Commit edin (`git commit -m 'Add some AmazingFeature'`)
4. Push edin (`git push origin feature/AmazingFeature`)
5. Pull Request oluşturun

## 📝 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 👥 Geliştirici

FlashDevs takımı
- GitHub: (https://github.com/safaibrahim9)
- Email: ibrahimsafa1903@gmail.com

## 🙏 Teşekkürler

- Flutter ekibi
- Provider paketi geliştiricileri
- Cached Network Image paketi
- Tüm açık kaynak topluluğu

## 📞 İletişim

Proje hakkında sorularınız için:
- Email: ibrahimsafa1903@gmail.com
- GitHub Issues: [Proje Issues](https://github.com/yourusername/hiper-yerel-ecommerce/issues)

---

⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın! 
