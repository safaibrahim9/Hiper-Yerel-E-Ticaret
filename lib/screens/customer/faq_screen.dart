import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../services/educational_assistant_service.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, dynamic>> _faqData = [
    {
      'question': 'Siparişimi nasıl takip edebilirim?',
      'answer': 'Siparişinizi "Siparişlerim" bölümünden takip edebilirsiniz. Sipariş durumu gerçek zamanlı olarak güncellenir.',
      'category': 'Sipariş',
      'icon': Icons.shopping_cart,
    },
    {
      'question': 'Teslimat süresi ne kadar?',
      'answer': 'Yerel teslimatlar genellikle 30-60 dakika içinde tamamlanır. Mesafe ve trafik durumuna göre değişiklik gösterebilir.',
      'category': 'Teslimat',
      'icon': Icons.delivery_dining,
    },
    {
      'question': 'İade ve değişim koşulları nelerdir?',
      'answer': 'Ürünler 14 gün içinde iade edilebilir. Kullanılmamış ve orijinal ambalajında olması gerekir.',
      'category': 'İade',
      'icon': Icons.swap_horiz,
    },
    {
      'question': 'Hangi ödeme yöntemleri kabul ediliyor?',
      'answer': 'Kredi kartı, banka kartı, mobil ödeme ve nakit ödeme kabul ediyoruz. Güvenli ödeme altyapısı kullanıyoruz.',
      'category': 'Ödeme',
      'icon': Icons.payment,
    },
    {
      'question': 'Kampanya ve indirimler nasıl öğrenebilirim?',
      'answer': 'Ana sayfadaki "Özel İndirimler" bölümünden güncel kampanyaları takip edebilirsiniz.',
      'category': 'Kampanya',
      'icon': Icons.local_offer,
    },
    {
      'question': 'Müşteri hizmetleri ile nasıl iletişim kurabilirim?',
      'answer': 'Profil sayfasından "Destek" bölümüne ulaşabilir veya 0850 XXX XXX numarasını arayabilirsiniz.',
      'category': 'Destek',
      'icon': Icons.support_agent,
    },
    {
      'question': 'Teknik terimler hakkında bilgi alabilir miyim?',
      'answer': 'Evet! Aşağıdaki arama kutusuna teknik terim yazarak detaylı açıklama alabilirsiniz. Örnek: "SSD nedir?", "OLED ekran ne demek?"',
      'category': 'Teknik Destek',
      'icon': Icons.smart_toy,
    },
  ];

  String _selectedCategory = 'Tümü';
  List<Map<String, dynamic>> _filteredFaq = [];
  Map<String, dynamic>? _aiResponse;
  bool _isLoading = false;
  bool _isEducationalMode = false;

  @override
  void initState() {
    super.initState();
    _filteredFaq = _faqData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sıkça Sorulan Sorular'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEducationalMode ? Icons.school : Icons.help),
            onPressed: () {
              setState(() {
                _isEducationalMode = !_isEducationalMode;
                _aiResponse = null;
              });
            },
            tooltip: _isEducationalMode ? 'Normal Mod' : 'Eğitici Mod',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          if (_isEducationalMode) _buildEducationalInfo(),
          _buildCategoryFilter(),
          Expanded(
            child: _aiResponse != null
                ? _buildAIResponse()
                : _buildFAQList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _questionController,
            decoration: InputDecoration(
              hintText: _isEducationalMode 
                  ? 'Teknik terim yazın... (örn: SSD, OLED, 5G)'
                  : 'Sorunuzu yazın...',
              prefixIcon: Icon(_isEducationalMode ? Icons.school : Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _askAI,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onSubmitted: (_) => _askAI(),
          ),
          const SizedBox(height: 8),
          Text(
            _isEducationalMode 
                ? 'Eğitici Tavsiye Asistanı - Teknik terim açıklamaları'
                : 'Yapay zeka destekli soru-cevap sistemi',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationalInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.school,
            color: AppTheme.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Eğitici Mod: Teknik terimler hakkında detaylı bilgi alabilirsiniz',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = _isEducationalMode 
        ? ['Tümü', 'Ekran', 'Depolama', 'İletişim', 'Bağlantı', 'Güvenlik', 'Ses', 'Görüntü', 'Grafik']
        : ['Tümü', 'Sipariş', 'Teslimat', 'İade', 'Ödeme', 'Kampanya', 'Destek', 'Teknik Destek'];
    
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                  if (category == 'Tümü') {
                    _filteredFaq = _faqData;
                  } else {
                    _filteredFaq = _faqData.where((faq) => faq['category'] == category).toList();
                  }
                  _aiResponse = null;
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFAQList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredFaq.length,
      itemBuilder: (context, index) {
        final faq = _filteredFaq[index];
        return _buildFAQCard(faq);
      },
    );
  }

  Widget _buildFAQCard(Map<String, dynamic> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            faq['icon'],
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          faq['question'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          faq['category'],
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer'],
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIResponse() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _isEducationalMode ? Icons.school : Icons.smart_toy,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _isEducationalMode ? 'Eğitici Asistan' : 'AI Asistan',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _aiResponse = null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEducationalMode) ...[
                  Text(
                    'Soru: ${_aiResponse!['question']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _aiResponse!['answer'],
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey[700],
                    ),
                  ),
                ] else ...[
                  Text(
                    'Soru: ${_aiResponse!['question']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Cevap: ${_aiResponse!['answer']}',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey[700],
                    ),
                  ),
                  if (_aiResponse!['relatedQuestions'] != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'İlgili Sorular:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...(_aiResponse!['relatedQuestions'] as List).map((question) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_right,
                            size: 16,
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              question,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sıkça Sorulan Sorular',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          ..._filteredFaq.take(3).map((faq) => _buildFAQCard(faq)),
        ],
      ),
    );
  }

  void _askAI() {
    if (_questionController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate AI processing
    Future.delayed(const Duration(seconds: 1), () {
      final question = _questionController.text.trim();
      
      if (_isEducationalMode) {
        final response = EducationalAssistantService.generateResponse(question);
        setState(() {
          _aiResponse = {
            'question': question,
            'answer': response,
          };
          _isLoading = false;
        });
      } else {
        final response = _generateAIResponse(question);
        setState(() {
          _aiResponse = response;
          _isLoading = false;
        });
      }
    });
  }

  Map<String, dynamic> _generateAIResponse(String question) {
    final lowerQuestion = question.toLowerCase();
    
    // AI response logic based on question content
    if (lowerQuestion.contains('sipariş') || lowerQuestion.contains('takip')) {
      return {
        'question': question,
        'answer': 'Siparişinizi "Siparişlerim" bölümünden takip edebilirsiniz. Sipariş numaranızı kullanarak gerçek zamanlı durum bilgisine ulaşabilirsiniz. Teslimat sürecinin her aşaması size bildirim olarak gönderilir.',
        'relatedQuestions': [
          'Teslimat süresi ne kadar?',
          'Siparişimi iptal edebilir miyim?',
          'Teslimat ücreti ne kadar?'
        ],
      };
    } else if (lowerQuestion.contains('teslimat') || lowerQuestion.contains('süre')) {
      return {
        'question': question,
        'answer': 'Yerel teslimatlarımız genellikle 30-60 dakika içinde tamamlanır. Mesafe, trafik durumu ve sipariş yoğunluğuna göre bu süre değişebilir. Acil siparişler için özel teslimat seçeneklerimiz de mevcuttur.',
        'relatedQuestions': [
          'Teslimat ücreti ne kadar?',
          'Hangi bölgelere teslimat yapıyorsunuz?',
          'Teslimat saatleri nelerdir?'
        ],
      };
    } else if (lowerQuestion.contains('iade') || lowerQuestion.contains('değişim')) {
      return {
        'question': question,
        'answer': 'Ürünlerinizi 14 gün içinde iade edebilirsiniz. İade koşulları: Ürün kullanılmamış olmalı, orijinal ambalajında bulunmalı ve hasar görmemiş olmalıdır. İade işlemi için müşteri hizmetlerimizle iletişime geçebilirsiniz.',
        'relatedQuestions': [
          'İade ücreti ne kadar?',
          'Hangi ürünler iade edilemez?',
          'İade süreci ne kadar sürer?'
        ],
      };
    } else if (lowerQuestion.contains('ödeme') || lowerQuestion.contains('kart')) {
      return {
        'question': question,
        'answer': 'Kredi kartı, banka kartı, mobil ödeme ve nakit ödeme kabul ediyoruz. Tüm ödeme işlemleriniz SSL şifreleme ile korunmaktadır. Kart bilgileriniz güvenli şekilde saklanır ve üçüncü taraflarla paylaşılmaz.',
        'relatedQuestions': [
          'Taksit seçenekleri nelerdir?',
          'Hangi kartlar kabul ediliyor?',
          'Ödeme güvenliği nasıl sağlanıyor?'
        ],
      };
    } else if (lowerQuestion.contains('kampanya') || lowerQuestion.contains('indirim')) {
      return {
        'question': question,
        'answer': 'Güncel kampanya ve indirimlerimizi ana sayfadaki "Özel İndirimler" bölümünden takip edebilirsiniz. Ayrıca push bildirimlerimizi açarak özel fırsatlardan haberdar olabilirsiniz. İlk siparişinizde %10 indirim kazanabilirsiniz.',
        'relatedQuestions': [
          'İlk sipariş indirimi nasıl kullanılır?',
          'Kampanya kodları nereden bulunur?',
          'Özel müşteri indirimleri var mı?'
        ],
      };
    } else {
      return {
        'question': question,
        'answer': 'Sorunuz için müşteri hizmetlerimizle iletişime geçmenizi öneririz. 0850 XXX XXX numarasını arayabilir veya profil sayfasından "Destek" bölümünü kullanabilirsiniz. Size en kısa sürede yardımcı olacağız.',
        'relatedQuestions': [
          'Müşteri hizmetleri çalışma saatleri',
          'Online destek mevcut mu?',
          'Şikayet ve öneriler nereye iletilir?'
        ],
      };
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
} 