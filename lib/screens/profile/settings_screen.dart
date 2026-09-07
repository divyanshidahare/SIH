import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../language/language_screen.dart';
import '../help/ask_help_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  double _textSize = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: const SimpleAppBar(title: "Settings & Accessibility"),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(isEasy ? 22.0 : 18.0),
              children: [
                // ACCESSIBILITY SPOTLIGHT: EASY MODE
                Container(
                  padding: EdgeInsets.all(isEasy ? 22 : 18),
                  decoration: BoxDecoration(
                    color: isEasy ? AppColors.primaryGoldSurface : AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isEasy ? AppColors.primaryGold : AppColors.borderLight,
                      width: isEasy ? 2.5 : 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGold.withOpacity(isEasy ? 0.15 : 0.03),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryGoldLight,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.accessibility_new_rounded,
                                  color: AppColors.primaryGoldDark,
                                  size: isEasy ? 32 : 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Easy Mode (सरल मोड)",
                                    style: TextStyle(
                                      fontSize: isEasy ? 20 : 17,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isEasy ? "Active • Maximum touch area & large icons" : "Off • Standard layout",
                                    style: TextStyle(
                                      fontSize: isEasy ? 14 : 12,
                                      color: isEasy ? AppColors.primaryGoldDark : AppColors.textSecondary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Switch(
                            value: isEasy,
                            activeColor: AppColors.primaryGoldDark,
                            activeTrackColor: AppColors.primaryGoldLight,
                            onChanged: (val) {
                              easyModeController.setEasyMode(val);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Specially crafted for artisans with low digital literacy or vision challenges. Globally enlarges all icons, text, spacing, and buttons.",
                        style: TextStyle(
                          fontSize: isEasy ? 15 : 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // General Preferences Section
                Text(
                  "Preferences",
                  style: TextStyle(
                    fontSize: isEasy ? 18 : 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Language Option -> Navigates with isFromSettings = true!
                _buildSettingsTile(
                  icon: Icons.language_rounded,
                  title: "App Language",
                  subtitle: "Current: ${easyModeController.selectedLanguage}",
                  isEasy: isEasy,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LanguageScreen(isFromSettings: true),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),

                // Notifications Toggle
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: isEasy ? 12 : 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications_active_outlined, size: isEasy ? 26 : 22, color: AppColors.textPrimary),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order & Govt Alerts",
                                style: TextStyle(
                                  fontSize: isEasy ? 16 : 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                "SMS and App notifications",
                                style: TextStyle(fontSize: isEasy ? 13 : 12, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: _notifications,
                        activeColor: AppColors.primaryGoldDark,
                        activeTrackColor: AppColors.primaryGoldLight,
                        onChanged: (v) => setState(() => _notifications = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Text Size Adjuster
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.format_size_rounded, size: isEasy ? 26 : 22, color: AppColors.textPrimary),
                              const SizedBox(width: 14),
                              Text("Font Scaling", style: TextStyle(fontSize: isEasy ? 16 : 14.5, fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Text(
                            _textSize > 1.1 ? "Large" : (_textSize < 0.9 ? "Compact" : "Standard"),
                            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryGoldDark),
                          ),
                        ],
                      ),
                      Slider(
                        value: _textSize,
                        min: 0.85,
                        max: 1.3,
                        divisions: 3,
                        activeColor: AppColors.primaryGoldDark,
                        inactiveColor: AppColors.primaryGoldLight,
                        onChanged: (val) => setState(() => _textSize = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Support & Privacy
                Text(
                  "Support & Legal",
                  style: TextStyle(
                    fontSize: isEasy ? 18 : 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                _buildSettingsTile(
                  icon: Icons.support_agent_rounded,
                  title: "Help & Helpline",
                  subtitle: "Direct artisan toll-free support line 1800-ARTISAN",
                  isEasy: isEasy,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AskHelpScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),

                _buildSettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Artisan Data Privacy",
                  subtitle: "Your craft designs and client details remain 100% yours",
                  isEasy: isEasy,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Artisan IP protection & Data sovereignty verified.")),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isEasy,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(isEasy ? 18.0 : 14.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Icon(icon, size: isEasy ? 26 : 22, color: AppColors.textPrimary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isEasy ? 16 : 14.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: isEasy ? 13 : 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
