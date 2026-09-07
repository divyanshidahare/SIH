import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/dummy_data.dart';
import '../catalog/digital_catalog_screen.dart';
import '../inventory/inventory_screen.dart';
import '../orders/orders_screen.dart';
import '../growth/my_growth_screen.dart';
import '../collaboration/collaboration_hub_screen.dart';
import 'settings_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final bool isRootTab;

  const ProfileScreen({
    Key? key,
    this.isRootTab = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: SimpleAppBar(
            title: "Artisan Profile",
            showBackButton: !isRootTab,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(isEasy ? 22.0 : 18.0),
              children: [
                // Quick Navigation Hub
                Text(
                  "Manage Your Business",
                  style: TextStyle(
                    fontSize: isEasy ? 18 : 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                _buildMenuRow(
                  icon: Icons.shopping_bag_outlined,
                  title: "Orders & Shipments",
                  subtitle: "Manage wholesale B2B and trade fair inquiries",
                  isEasy: isEasy,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrdersScreen())),
                ),
                const SizedBox(height: 10),

                _buildMenuRow(
                  icon: Icons.trending_up_rounded,
                  title: "My Growth & Analytics",
                  subtitle: "Track views, revenue, and verified craft metrics",
                  isEasy: isEasy,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyGrowthScreen())),
                ),
                const SizedBox(height: 10),

                _buildMenuRow(
                  icon: Icons.diversity_3_outlined,
                  title: "Artisan Collaboration Hub",
                  subtitle: "Connect with fellow weavers, NIFT designers & NGOs",
                  isEasy: isEasy,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CollaborationHubScreen())),
                ),
                const SizedBox(height: 10),

                _buildMenuRow(
                  icon: Icons.settings_suggest_outlined,
                  title: "Settings & Preferences",
                  subtitle: "Language, voice assist and notifications",
                  isEasy: isEasy,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
                ),
                const SizedBox(height: 28),

                // Logout
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.errorRed,
                      side: const BorderSide(color: AppColors.errorRed),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text("Log Out of कलाMITRA", style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuRow({
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryGoldLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: isEasy ? 24 : 20, color: AppColors.textPrimary),
            ),
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
