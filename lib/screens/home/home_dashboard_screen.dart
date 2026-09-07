import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/primary_action_card.dart';
import '../../data/dummy_data.dart';
import '../product/upload_product_flow_screen.dart';
import '../orders/orders_screen.dart';
import '../help/ask_help_screen.dart';
import '../inventory/inventory_screen.dart';
import '../catalog/digital_catalog_screen.dart';
import '../opportunities/opportunities_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/settings_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        // Bottom Navigation pages
        final pages = [
          _buildHomeDashboardView(isEasy),
          const DigitalCatalogScreen(isRootTab: true),
          const SizedBox(), // Placeholder for Upload action in bottom nav
          const OpportunitiesScreen(isRootTab: true),
          const ProfileScreen(isRootTab: true),
        ];

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: pages[_currentNavIndex == 2 ? 0 : _currentNavIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundWhite,
              border: Border(top: BorderSide(color: AppColors.borderLight, width: 1)),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentNavIndex,
              onTap: (index) {
                if (index == 2) {
                  // Middle "+" Upload action opens AI Cataloging Studio directly!
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const UploadProductFlowScreen()),
                  );
                } else {
                  setState(() => _currentNavIndex = index);
                }
              },
              backgroundColor: AppColors.backgroundWhite,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.textPrimary,
              unselectedItemColor: AppColors.textTertiary,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: isEasy ? 14 : 12,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isEasy ? 13 : 11,
              ),
              iconSize: isEasy ? 30 : 24,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: "Catalog",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add_rounded, color: AppColors.textPrimary, size: 22),
                  ),
                  label: "Upload",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.handshake_rounded),
                  label: "Opportunities",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: "Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHomeDashboardView(bool isEasy) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isEasy ? 22.0 : 18.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP SECTION: Artisan Greeting & Header Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Greeting and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Namaste, Priya 👋",
                        style: TextStyle(
                          fontSize: isEasy ? 28 : 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Let's grow your craft today.",
                        style: TextStyle(
                          fontSize: isEasy ? 16 : 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Notification & Profile Avatar
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("New notification: B2B Retailer requested 4 Banarasi sarees")),
                        );
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Stack(
                          children: [
                            const Icon(Icons.notifications_outlined, size: 20, color: AppColors.textPrimary),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryGoldDark,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        setState(() => _currentNavIndex = 4); // Switch to Profile tab
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: isEasy ? 46 : 40,
                        height: isEasy ? 46 : 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryGold, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&auto=format&fit=crop&q=80"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Accessibility Easy Mode Banner (Quick Toggle)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isEasy ? AppColors.primaryGoldSurface : AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isEasy ? AppColors.primaryGold : AppColors.borderLight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.accessibility_new_rounded,
                        color: AppColors.primaryGoldDark,
                        size: isEasy ? 24 : 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isEasy ? "Easy Mode: Active (सरल मोड)" : "Easy Mode (Large Icons & Text)",
                        style: TextStyle(
                          fontSize: isEasy ? 14 : 12.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
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
            ),
            const SizedBox(height: 28),

            // MAIN SECTION TITLE: "What would you like to do?"
            Text(
              "What would you like to do?",
              style: TextStyle(
                fontSize: isEasy ? 22 : 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),

            // FOUR LARGE PRIMARY ACTION CARDS (2x2 Grid)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: isEasy ? 16 : 12,
              mainAxisSpacing: isEasy ? 16 : 12,
              childAspectRatio: isEasy ? 0.78 : 0.88,
              children: [
                // PRIMARY ACTION 1: 📤 UPLOAD PRODUCT
                PrimaryActionCard(
                  icon: Icons.drive_folder_upload_rounded,
                  title: "Upload Product",
                  description: "Photo studio, voice info & AI pricing",
                  badgeText: "AI Studio",
                  badgeColor: AppColors.primaryGold,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const UploadProductFlowScreen()),
                    );
                  },
                ),

                // PRIMARY ACTION 2: 🛒 NEW ORDERS
                PrimaryActionCard(
                  icon: Icons.shopping_bag_rounded,
                  title: "New Orders",
                  description: "View buyer requests & track delivery",
                  badgeText: "3 Pending",
                  badgeColor: AppColors.primaryGoldLight,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const OrdersScreen()),
                    );
                  },
                ),

                // PRIMARY ACTION 3: 💬 ASK HELP
                PrimaryActionCard(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: "Ask Help",
                  description: "AI Advisor for photography & govt schemes",
                  badgeText: "24/7 AI",
                  badgeColor: AppColors.primaryGoldLight,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AskHelpScreen()),
                    );
                  },
                ),

                // PRIMARY ACTION 4: 📦 INVENTORY
                PrimaryActionCard(
                  icon: Icons.inventory_2_rounded,
                  title: "Inventory",
                  description: "Manage craft stocks & low stock alerts",
                  badgeText: "5 Items",
                  badgeColor: AppColors.primaryGoldLight,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const InventoryScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Active Artisan Business Summary Card
            Container(
              padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Craft Status Overview",
                        style: TextStyle(
                          fontSize: isEasy ? 17 : 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => _currentNavIndex = 1),
                        child: const Text("View All", style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const Divider(height: 12),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniMetric("5 Products", "Digitized", Icons.auto_awesome, AppColors.primaryGoldDark, isEasy),
                      _buildMiniMetric("₹48.8k", "Monthly Sales", Icons.trending_up, AppColors.successGreen, isEasy),
                      _buildMiniMetric("Silver", "Artisan Tier", Icons.workspace_premium, AppColors.primaryGold, isEasy),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniMetric(String value, String label, IconData icon, Color iconColor, bool isEasy) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: isEasy ? 24 : 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: isEasy ? 16 : 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        Text(
          label,
          style: TextStyle(fontSize: isEasy ? 12.5 : 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
