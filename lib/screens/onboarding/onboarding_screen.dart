import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../language/language_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      "icon": Icons.auto_awesome_rounded,
      "title": "Your Craft Deserves to Grow",
      "desc": "Turn your handmade products into a professional digital business.",
      "craftBadge": "🏺 Handcrafted with Pride",
    },
    {
      "icon": Icons.camera_enhance_rounded,
      "title": "AI Makes Things Easier",
      "desc": "Improve photos, create catalogs, and get smart suggestions in your own language.",
      "craftBadge": "✨ Smart Artisan Studio",
    },
    {
      "icon": Icons.inventory_2_rounded,
      "title": "Manage Your Craft Business",
      "desc": "Track products, inventory, orders, and opportunities in one place without paperwork.",
      "craftBadge": "📦 Simple Craft Books",
    },
    {
      "icon": Icons.handshake_rounded,
      "title": "Your Digital Craft Partner",
      "desc": "कलाMITRA helps you take the next step with confidence, fair pricing, and direct B2B access.",
      "craftBadge": "🤝 Artisan Community",
    },
  ];

  void _onFinish() {
    // Initial Setup: Language Selection MUST come BEFORE Login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const LanguageScreen(isFromSettings: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!isLastPage)
            TextButton(
              onPressed: _onFinish,
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Large Artisan Illustration Container
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGoldLight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryGold,
                              width: 2.0,
                            ),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 64,
                            color: AppColors.primaryGoldDark,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Craft Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGoldSurface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primaryGold.withOpacity(0.5)),
                          ),
                          child: Text(
                            item['craftBadge'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title
                        Text(
                          item['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            item['desc'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Page Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.primaryGold : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bottom Action Button
              CustomButton(
                text: isLastPage ? "Get Started" : "Next",
                icon: isLastPage ? Icons.arrow_forward_rounded : null,
                onPressed: () {
                  if (isLastPage) {
                    _onFinish();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
