import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import 'business_ai_analytics_service.dart';

class BusinessAIAssistantScreen extends StatefulWidget {
  const BusinessAIAssistantScreen({super.key});

  @override
  _BusinessAIAssistantScreenState createState() => _BusinessAIAssistantScreenState();
}

class _BusinessAIAssistantScreenState extends State<BusinessAIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<BusinessChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addBotMessage('Merhaba! Ben işletmenizin AI Asistanıyım. Size haftalık analizler ve öneriler sunuyorum. 🏪\n\nÖrnek sorular:\n• "Bu hafta satış durumu nasıl?"\n• "Hangi ürünler daha çok satıyor?"\n• "Stok durumu nasıl?"\n• "Müşteri yorumları neler?"');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.analytics,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            const Text('İşletme AI Asistanı'),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              _clearChat();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isTyping) {
          return _buildTypingIndicator();
        }
        return _buildMessageBubble(_messages[index]);
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.analytics,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 200)),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildMessageBubble(BusinessChatMessage message) {
    final isUser = message.isUser;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.analytics,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? AppTheme.primaryColor : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  if (message.analytics != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      '📊 Analiz Raporu:',
                      style: TextStyle(
                        color: isUser ? Colors.white70 : Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...message.analytics!.map((analytics) => _buildAnalyticsCard(analytics)),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.business,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(Map<String, dynamic> analytics) {
    return GestureDetector(
      onTap: () {
        if (analytics['showChart'] == true) {
          _showSalesChart();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getAnalyticsBorderColor(analytics['type'], analytics),
            width: analytics['isCritical'] == true || analytics['isOutOfStock'] == true ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getAnalyticsIcon(analytics['type']),
                  color: _getAnalyticsColor(analytics['type']),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    analytics['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: analytics['isCritical'] == true || analytics['isOutOfStock'] == true 
                          ? Colors.red[700] 
                          : null,
                    ),
                  ),
                ),
                if (analytics['showChart'] == true)
                  Icon(
                    Icons.bar_chart,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              analytics['description'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            if (analytics['recommendation'] != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getRecommendationColor(analytics),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getRecommendationBorderColor(analytics)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getRecommendationIcon(analytics),
                      color: _getRecommendationIconColor(analytics),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        analytics['recommendation'],
                        style: TextStyle(
                          fontSize: 12,
                          color: _getRecommendationTextColor(analytics),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getAnalyticsIcon(String type) {
    switch (type) {
      case 'sales':
        return Icons.trending_up;
      case 'stock':
        return Icons.inventory;
      case 'reviews':
        return Icons.star;
      case 'profit':
        return Icons.attach_money;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.analytics;
    }
  }

  Color _getAnalyticsColor(String type) {
    switch (type) {
      case 'sales':
        return Colors.green;
      case 'stock':
        return Colors.orange;
      case 'reviews':
        return Colors.amber;
      case 'profit':
        return Colors.blue;
      case 'warning':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getAnalyticsBorderColor(String type, Map<String, dynamic> analytics) {
    if (analytics['isCritical'] == true) return Colors.red;
    if (analytics['isOutOfStock'] == true) return Colors.red;
    if (analytics['isTopSellerLowStock'] == true) return Colors.orange;
    
    switch (type) {
      case 'sales':
        return Colors.green.withOpacity(0.3);
      case 'stock':
        return Colors.orange.withOpacity(0.3);
      case 'reviews':
        return Colors.amber.withOpacity(0.3);
      case 'profit':
        return Colors.blue.withOpacity(0.3);
      case 'warning':
        return Colors.red.withOpacity(0.3);
      default:
        return Colors.grey.withOpacity(0.3);
    }
  }

  Color _getRecommendationColor(Map<String, dynamic> analytics) {
    if (analytics['isCritical'] == true) return Colors.red[50]!;
    if (analytics['isOutOfStock'] == true) return Colors.red[50]!;
    if (analytics['isTopSellerLowStock'] == true) return Colors.orange[50]!;
    
    return Colors.blue[50]!;
  }

  Color _getRecommendationBorderColor(Map<String, dynamic> analytics) {
    if (analytics['isCritical'] == true) return Colors.red[200]!;
    if (analytics['isOutOfStock'] == true) return Colors.red[200]!;
    if (analytics['isTopSellerLowStock'] == true) return Colors.orange[200]!;
    
    return Colors.blue[200]!;
  }

  IconData _getRecommendationIcon(Map<String, dynamic> analytics) {
    if (analytics['isCritical'] == true) return Icons.warning;
    if (analytics['isOutOfStock'] == true) return Icons.error;
    if (analytics['isTopSellerLowStock'] == true) return Icons.trending_up;
    
    return Icons.lightbulb;
  }

  Color _getRecommendationIconColor(Map<String, dynamic> analytics) {
    if (analytics['isCritical'] == true) return Colors.red[600]!;
    if (analytics['isOutOfStock'] == true) return Colors.red[600]!;
    if (analytics['isTopSellerLowStock'] == true) return Colors.orange[600]!;
    
    return Colors.blue[600]!;
  }

  Color _getRecommendationTextColor(Map<String, dynamic> analytics) {
    if (analytics['isCritical'] == true) return Colors.red[700]!;
    if (analytics['isOutOfStock'] == true) return Colors.red[700]!;
    if (analytics['isTopSellerLowStock'] == true) return Colors.orange[700]!;
    
    return Colors.blue[700]!;
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Soru sorun veya analiz isteyin...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                suffixIcon: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty && !_isLoading) {
                  _sendMessage(text);
                }
              },
              enabled: !_isLoading,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_messageController.text.isNotEmpty) {
                        _sendMessage(_messageController.text);
                      }
                    },
              icon: Icon(
                Icons.send,
                color: _isLoading ? Colors.grey : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(BusinessChatMessage(text: text, isUser: true));
      _messageController.clear();
      _isTyping = true;
      _isLoading = true;
    });

    _scrollToBottom();

    // Simulate AI response with typing indicator
    Future.delayed(const Duration(seconds: 1), () {
      _generateAIResponse(text);
    });
  }

  void _generateAIResponse(String userMessage) {
    final analytics = BusinessAIAnalyticsService.getAnalytics(userMessage);
    String response = _processUserMessage(userMessage);
    
    setState(() {
      _isTyping = false;
      _isLoading = false;
      _messages.add(BusinessChatMessage(
        text: response,
        isUser: false,
        analytics: analytics,
      ));
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sohbeti Temizle'),
        content: const Text('Tüm mesajları silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _messages.clear();
                _addBotMessage('Merhaba! Ben işletmenizin AI Asistanıyım. Size haftalık analizler ve öneriler sunuyorum. 🏪');
              });
              Navigator.pop(context);
            },
            child: const Text('Temizle'),
          ),
        ],
      ),
    );
  }

  String _processUserMessage(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (_containsAny(lowerMessage, ['satış', 'satışlar', 'sales'])) {
      return 'Bu hafta satış analizinizi hazırlıyorum...';
    }
    
    if (_containsAny(lowerMessage, ['stok', 'inventory', 'ürün'])) {
      return 'Stok durumunuzu analiz ediyorum...';
    }
    
    if (_containsAny(lowerMessage, ['yorum', 'review', 'müşteri'])) {
      return 'Müşteri yorumlarınızı inceliyorum...';
    }
    
    if (_containsAny(lowerMessage, ['kar', 'profit', 'gelir'])) {
      return 'Kar/zarar durumunuzu hesaplıyorum...';
    }
    
    if (_containsAny(lowerMessage, ['haftalık', 'weekly', 'rapor'])) {
      return 'Haftalık raporunuzu hazırlıyorum...';
    }
    
    if (_containsAny(lowerMessage, ['öneri', 'tavsiye', 'suggestion'])) {
      return 'Size özel önerilerimi hazırlıyorum...';
    }
    
    return 'Anladığım kadarıyla "$message" hakkında bilgi arıyorsunuz. Size nasıl yardımcı olabilirim?';
  }

  bool _containsAny(String input, List<String> keywords) {
    return keywords.any((keyword) => input.contains(keyword));
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(BusinessChatMessage(text: text, isUser: false));
    });
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.analytics, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            const Text('İşletme AI Asistanı'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Asistan size şu konularda yardımcı olabilir:'),
            SizedBox(height: 10),
            Text('• Haftalık satış analizi'),
            Text('• Stok durumu ve öneriler'),
            Text('• Müşteri yorumları analizi'),
            Text('• Kar/zarar raporu'),
            Text('• Performans önerileri'),
            SizedBox(height: 10),
            Text('Örnek sorular:'),
            Text('• "Bu hafta satış durumu nasıl?"'),
            Text('• "Hangi ürünler daha çok satıyor?"'),
            Text('• "Stok durumu nasıl?"'),
            Text('• "Müşteri yorumları neler?"'),
            Text('• "Bu hafta kar durumu?"'),
            Text('• "Gelecek hafta önerilerin neler?"'),
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

  void _showSalesChart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.bar_chart, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            const Text('Haftalık Satış Grafiği'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: _buildSalesChart(),
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

  Widget _buildSalesChart() {
    final products = [
      {'name': 'Samsung Galaxy S24', 'sales': 12, 'color': Colors.blue},
      {'name': 'AirPods Pro 2', 'sales': 20, 'color': Colors.green},
      {'name': 'iPhone 15 Pro Max', 'sales': 8, 'color': Colors.purple},
      {'name': 'iPad Pro 12.9', 'sales': 6, 'color': Colors.orange},
      {'name': 'MacBook Pro M3', 'sales': 3, 'color': Colors.red},
      {'name': 'Dell XPS 15', 'sales': 1, 'color': Colors.grey},
    ];

    final maxSales = products.fold<int>(0, (max, p) => (p['sales'] as int) > max ? (p['sales'] as int) : max);

    return Column(
      children: [
        const Text(
          'Bu Hafta Satış Performansı',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: products.map((product) {
              final height = ((product['sales'] as int) / maxSales) * 200;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                    height: height,
                    decoration: BoxDecoration(
                      color: product['color'] as Color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${product['sales']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 40,
                    child: Text(
                      (product['name'] as String).split(' ').first,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Toplam: 50 ürün satıldı\nOrtalama: 8.3 ürün/gün',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class BusinessChatMessage {
  final String text;
  final bool isUser;
  final List<Map<String, dynamic>>? analytics;

  BusinessChatMessage({
    required this.text,
    required this.isUser,
    this.analytics,
  });
} 