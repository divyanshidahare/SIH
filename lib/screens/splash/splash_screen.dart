import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

/// Screen 1: Splash Screen
/// Official colors: #FFFFFF and #B45309
/// Minimal artisan-inspired logo with smooth entrance animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    // Auto-advance to Onboarding after splash
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minimal Artisan Emblem (Charkha & Potter Motif)
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGoldLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryGold, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGold.withOpacity(0.25),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.palette_outlined,
                          size: 48,
                          color: AppColors.primaryGoldDark,
                        ),
                        Positioned(
                          top: 18,
                          right: 18,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryGold,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Brand Name
                const Text(
                  "कलाMITRA",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),

                // Tagline
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGoldSurface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.primaryGold.withOpacity(0.4)),
                  ),
                  child: const Text(
                    "Your AI Partner for Every Craft",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Subtle Loading Indicator
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
