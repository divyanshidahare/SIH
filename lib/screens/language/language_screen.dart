import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../auth/login_screen.dart';

class LanguageScreen extends StatefulWidget {
  final bool isFromSettings;

  const LanguageScreen({
    Key? key,
    this.isFromSettings = false,
  }) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'English';

  final List<Map<String, String>> _languages = [
    {
      'code': 'hi',
      'name': 'हिंदी',
      'englishName': 'Hindi',
      'script': 'नमस्ते! अपनी भाषा चुनें',
      'flag': '🇮🇳',
    },
    {
      'code': 'en',
      'name': 'English',
      'englishName': 'English',
      'script': 'Simple & clear artisan assistant',
      'flag': '🌐',
    },
    {
      'code': 'other',
      'name': 'Other Indian Languages',
      'englishName': 'Regional Dialects (Coming Soon)',
      'script': 'বাংলা, தமிழ், తెలుగు, मराठी, ગુજરાતી',
      'flag': '🇮🇳',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selected = easyModeController.selectedLanguage;
  }

  void _handleLanguageSelect(String langName) {
    setState(() {
      _selected = langName;
    });
    easyModeController.setLanguage(langName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Language set to $langName"),
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.textPrimary,
      ),
    );

    // CRITICAL ROUTING LOGIC:
    // If coming from Settings -> Pop back to Settings!
    // If coming from Onboarding/Initial -> Navigate to Login!
    if (widget.isFromSettings) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: widget.isFromSettings
              ? const SimpleAppBar(title: "Change Language")
              : null,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(isEasy ? 24.0 : 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!widget.isFromSettings) const SizedBox(height: 16),

                  // Screen Title
                  Text(
                    "Choose Your Language",
                    style: TextStyle(
                      fontSize: isEasy ? 28 : 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    "You can change this anytime later in Settings",
                    style: TextStyle(
                      fontSize: isEasy ? 16 : 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Large Language Cards
                  Expanded(
                    child: ListView.separated(
                      itemCount: _languages.length,
                      separatorBuilder: (_, __) => SizedBox(height: isEasy ? 18 : 14),
                      itemBuilder: (context, index) {
                        final lang = _languages[index];
                        final isSelected = _selected == lang['name'];

                        return InkWell(
                          onTap: () => _handleLanguageSelect(lang['name']!),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            padding: EdgeInsets.all(isEasy ? 22.0 : 18.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryGoldSurface
                                  : AppColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryGold
                                    : AppColors.borderLight,
                                width: isSelected ? 2.5 : 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(isSelected ? 0.05 : 0.02),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Flag / Badge Container
                                Container(
                                  width: isEasy ? 56 : 48,
                                  height: isEasy ? 56 : 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryGoldLight,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: Text(
                                      lang['flag']!,
                                      style: TextStyle(fontSize: isEasy ? 28 : 24),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Language details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lang['name']!,
                                        style: TextStyle(
                                          fontSize: isEasy ? 21 : 18,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        lang['script']!,
                                        style: TextStyle(
                                          fontSize: isEasy ? 14.5 : 13,
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Checkmark / Radio Indicator
                                Container(
                                  width: isEasy ? 30 : 24,
                                  height: isEasy ? 30 : 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? AppColors.primaryGold
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryGold
                                          : AppColors.borderLight,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check_rounded,
                                          size: isEasy ? 20 : 16,
                                          color: AppColors.textPrimary,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Informational Note
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 20,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "More regional languages coming soon (Tamil, Telugu, Bengali, Marathi, Gujarati)",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Continue Button
                  CustomButton(
                    text: widget.isFromSettings ? "Confirm Language" : "Continue to Login",
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => _handleLanguageSelect(_selected),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
