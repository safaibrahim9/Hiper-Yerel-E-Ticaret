class AppConstants {
  // App Info
  static const String appName = 'Hiper Yerel E-Ticaret';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.hiperyerel.com';
  static const String apiVersion = '/api/v1';
  static const int apiTimeout = 30000; // 30 seconds
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userTypeKey = 'user_type';
  static const String userDataKey = 'user_data';
  static const String locationKey = 'user_location';
  static const String onboardingKey = 'onboarding_completed';
  
  // User Types
  static const String userTypeCustomer = 'customer';
  static const String userTypeBusiness = 'business';
  
  // Order Status
  static const String orderStatusPending = 'pending';
  static const String orderStatusConfirmed = 'confirmed';
  static const String orderStatusPreparing = 'preparing';
  static const String orderStatusReady = 'ready';
  static const String orderStatusOnTheWay = 'on_the_way';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';
  
  // Business Categories
  static const List<String> businessCategories = [
    'Market',
    'Restoran',
    'Kafe',
    'Teknoloji',
    'Giyim',
    'Kozmetik',
    'Eczane',
    'Kırtasiye',
    'Spor',
    'Ev & Yaşam',
    'Diğer',
  ];
  
  // Payment Methods
  static const List<String> paymentMethods = [
    'Kredi Kartı',
    'Nakit',
    'Mobil Ödeme',
    'Havale/EFT',
  ];
  
  // Delivery Types
  static const String deliveryTypeDelivery = 'delivery';
  static const String deliveryTypePickup = 'pickup';
  
  // Notification Types
  static const String notificationTypeOrder = 'order';
  static const String notificationTypePromotion = 'promotion';
  static const String notificationTypeSystem = 'system';
  
  // Map Configuration
  static const double defaultLatitude = 41.0082; // Istanbul
  static const double defaultLongitude = 28.9784;
  static const double defaultZoom = 13.0;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double buttonHeight = 48.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Error Messages
  static const String networkError = 'İnternet bağlantınızı kontrol edin';
  static const String serverError = 'Sunucu hatası oluştu';
  static const String unknownError = 'Bilinmeyen bir hata oluştu';
  static const String locationError = 'Konum alınamadı';
  static const String permissionError = 'Gerekli izinler verilmedi';
  
  // Success Messages
  static const String orderPlacedSuccess = 'Siparişiniz başarıyla oluşturuldu';
  static const String profileUpdatedSuccess = 'Profil bilgileriniz güncellendi';
  static const String addressAddedSuccess = 'Adres başarıyla eklendi';
  
  // Validation Messages
  static const String requiredField = 'Bu alan zorunludur';
  static const String invalidEmail = 'Geçerli bir e-posta adresi girin';
  static const String invalidPhone = 'Geçerli bir telefon numarası girin';
  static const String passwordTooShort = 'Şifre en az 6 karakter olmalıdır';
  static const String passwordsNotMatch = 'Şifreler eşleşmiyor';
} 