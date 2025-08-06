import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import 'ai_recommendation_service.dart';
import 'product_detail_screen.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  _AIAssistantScreenState createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addBotMessage('Merhaba! Ben Hiper Yerel AI Asistanınız. Size nasıl yardımcı olabilirim? 🛍️\n\nÖrnek sorular:\n• "iPhone 15 Pro Max fiyatı nedir?"\n• "Ucuz laptop önerisi"\n• "Pizza siparişi verebilir miyim?"\n• "Sağlıklı market ürünleri"');
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
                Icons.smart_toy,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            const Text('AI Asistan'),
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
              Icons.smart_toy,
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

  Widget _buildMessageBubble(ChatMessage message) {
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
                Icons.smart_toy,
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
                  if (message.recommendations != null && message.recommendations!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      '💡 Önerilen Ürünler:',
                      style: TextStyle(
                        color: isUser ? Colors.white70 : Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...message.recommendations!.map((product) => _buildProductCard(product)),
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
                Icons.person,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getCategoryIcon(product['category']),
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product['brand']} • ₺${product['price']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${product['rating']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppTheme.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
            // Show top review if available
            if (product['reviews'] != null && (product['reviews'] as List).isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[600],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        (product['reviews'] as List).first['comment'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                hintText: 'Mesajınızı yazın...',
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
      _messages.add(ChatMessage(text: text, isUser: true));
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
    final recommendations = AIRecommendationService.getRecommendations(userMessage);
    final sentiment = AIRecommendationService.analyzeUserSentiment(userMessage);
    
    String response = _processUserMessage(userMessage);
    
    if (recommendations.isNotEmpty) {
      response += '\n\nSize şu ürünleri öneriyorum:';
      
      // Add review highlights if available
      final topRatedProduct = recommendations.firstWhere(
        (product) => product['rating'] >= 4.5,
        orElse: () => recommendations.first,
      );
      
      if (topRatedProduct['reviews'] != null && (topRatedProduct['reviews'] as List).isNotEmpty) {
        final topReview = (topRatedProduct['reviews'] as List).first;
        response += '\n\n💡 En çok beğenilen ürün: ${topRatedProduct['name']}';
        response += '\n⭐ ${topReview['user']}: "${topReview['comment']}"';
      }
    }
    
    setState(() {
      _isTyping = false;
      _isLoading = false;
      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        recommendations: recommendations,
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
                _addBotMessage('Merhaba! Ben Hiper Yerel AI Asistanınız. Size nasıl yardımcı olabilirim? 🛍️');
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
    
    // Enhanced category search
    if (_containsAny(lowerMessage, ['market', 'süper market', 'gıda'])) {
      return 'Market kategorisinde arama yapıyorsunuz. Size yakındaki marketleri göstereyim mi?';
    }
    
    if (_containsAny(lowerMessage, ['restoran', 'yemek', 'food'])) {
      return 'Restoran kategorisinde arama yapıyorsunuz. Hangi tür yemek arıyorsunuz?';
    }
    
    if (_containsAny(lowerMessage, ['kafe', 'kahve', 'coffee'])) {
      return 'Kafe kategorisinde arama yapıyorsunuz. Size yakındaki kafeleri göstereyim mi?';
    }
    
    if (_containsAny(lowerMessage, ['teknoloji', 'elektronik', 'tech'])) {
      return 'Teknoloji kategorisinde arama yapıyorsunuz. Hangi ürünü arıyorsunuz? (Telefon, bilgisayar, tablet vb.)';
    }
    
    if (_containsAny(lowerMessage, ['giyim', 'kıyafet', 'clothing'])) {
      return 'Giyim kategorisinde arama yapıyorsunuz. Hangi tür kıyafet arıyorsunuz?';
    }
    
    if (_containsAny(lowerMessage, ['kozmetik', 'makyaj', 'beauty'])) {
      return 'Kozmetik kategorisinde arama yapıyorsunuz. Hangi ürünü arıyorsunuz?';
    }
    
    if (_containsAny(lowerMessage, ['eczane', 'ilaç', 'pharmacy'])) {
      return 'Eczane kategorisinde arama yapıyorsunuz. Size yakındaki eczaneleri göstereyim mi?';
    }
    
    // Product search
    if (_containsAny(lowerMessage, ['telefon', 'iphone', 'samsung', 'android', 'mobile'])) {
      return 'Teknoloji mağazalarında telefon arama yapıyorsunuz. Hangi marka tercih ediyorsunuz?';
    }
    
    if (_containsAny(lowerMessage, ['laptop', 'bilgisayar', 'macbook', 'dell', 'computer'])) {
      return 'Teknoloji mağazalarında bilgisayar arama yapıyorsunuz. Hangi özellikleri arıyorsunuz?';
    }
    
    if (_containsAny(lowerMessage, ['süt', 'ekmek', 'peynir', 'milk', 'bread', 'cheese'])) {
      return 'Market ürünleri arıyorsunuz. Size yakındaki marketleri göstereyim mi?';
    }
    
    if (_containsAny(lowerMessage, ['pizza', 'burger', 'kebap', 'sushi'])) {
      return 'Restoran arama yapıyorsunuz. Size yakındaki restoranları göstereyim mi?';
    }
    
    // Price queries
    if (_containsAny(lowerMessage, ['fiyat', 'ucuz', 'pahalı', 'price'])) {
      return 'Fiyat konusunda yardımcı olabilirim. Hangi ürünün fiyatını öğrenmek istiyorsunuz?';
    }
    
    // Delivery queries
    if (_containsAny(lowerMessage, ['teslimat', 'süre', 'ne kadar', 'delivery'])) {
      return 'Teslimat süreleri genellikle 15-45 dakika arasındadır. Hangi mağazadan sipariş vermek istiyorsunuz?';
    }
    
    // General help
    if (_containsAny(lowerMessage, ['yardım', 'nasıl', 'ne yapabilir', 'help'])) {
      return 'Size şu konularda yardımcı olabilirim:\n• Kategori arama\n• Ürün arama\n• Fiyat bilgisi\n• Teslimat süreleri\n• Mağaza önerileri';
    }
    
    // Default response
    return 'Anladığım kadarıyla "$message" hakkında bilgi arıyorsunuz. Size nasıl yardımcı olabilirim? Hangi kategori veya ürün arıyorsunuz?';
  }

  bool _containsAny(String input, List<String> keywords) {
    return keywords.any((keyword) => input.contains(keyword));
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: false));
    });
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.smart_toy, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            const Text('AI Asistan Yardım'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Asistan size şu konularda yardımcı olabilir:'),
            SizedBox(height: 10),
            Text('• Kategori arama (Market, Restoran, Teknoloji vb.)'),
            Text('• Ürün arama (Telefon, Laptop, Yemek vb.)'),
            Text('• Fiyat bilgisi'),
            Text('• Teslimat süreleri'),
            Text('• Mağaza önerileri'),
            SizedBox(height: 10),
            Text('Örnek sorular:'),
            Text('• "Yakındaki marketleri göster"'),
            Text('• "Telefon fiyatları nedir?"'),
            Text('• "Pizza siparişi verebilir miyim?"'),
            Text('• "iPhone 15 Pro Max fiyatı nedir?"'),
            Text('• "En ucuz laptop önerisi"'),
            Text('• "Sağlıklı market ürünleri"'),
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Teknoloji':
        return Icons.phone_android;
      case 'Market':
        return Icons.shopping_basket;
      case 'Restoran':
        return Icons.restaurant;
      default:
        return Icons.shopping_bag;
    }
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final List<Map<String, dynamic>>? recommendations;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.recommendations,
  });
} 