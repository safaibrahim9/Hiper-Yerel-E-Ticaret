import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _logoController = AnimationController(
      duration: AppConstants.mediumAnimation,
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: AppConstants.longAnimation,
      vsync: this,
    );
    
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    // Start logo animation
    await _logoController.forward();
    
    // Start fade animation
    await _fadeController.forward();
    
    // Initialize auth and navigate
    await _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // Initialize auth state
    await authProvider.initializeAuth();
    
    // Wait a bit for smooth transition
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Navigate based on auth state
    if (mounted) {
      if (authProvider.isAuthenticated) {
        // User is logged in, navigate to appropriate main screen
        if (authProvider.userType == AppConstants.userTypeCustomer) {
          context.go('/customer');
        } else if (authProvider.userType == AppConstants.userTypeBusiness) {
          context.go('/business');
        } else {
          context.go('/user-selection');
        }
      } else {
        // User is not logged in, show user selection
        context.go('/user-selection');
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Animation
            ScaleTransition(
              scale: _logoAnimation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.store,
                  size: 60,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // App Name Animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Tagline Animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Yerel Esnaf, Global Teknoloji',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            
            const SizedBox(height: 64),
            
            // Loading Indicator
            FadeTransition(
              opacity: _fadeAnimation,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 