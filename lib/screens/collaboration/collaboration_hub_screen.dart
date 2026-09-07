import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';

class CollaborationHubScreen extends StatelessWidget {
  const CollaborationHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        final pillars = [
          {
            "icon": Icons.groups_rounded,
            "title": "Master Artisans & Guilds",
            "desc": "Connect with 1,200+ fellow weavers and craftspeople across Varanasi, Kutch, and Jaipur. Share raw materials and bulk loom orders.",
            "action": "Find Fellow Artisans",
            "count": "450 Active Guilds",
          },
          {
            "icon": Icons.design_services_rounded,
            "title": "NIFT Textile Designers",
            "desc": "Collaborate with contemporary product and textile designers to blend traditional GI motifs with modern export silhouettes.",
            "action": "Request Design Mentorship",
            "count": "180 Verified Mentors",
          },
          {
            "icon": Icons.volunteer_activism_rounded,
            "title": "NGOs & Craft Foundations",
            "desc": "Partner with organizations like SEWA, Dastkar, and Craftsvilla Foundation for women artisan tool grants and fair pricing.",
            "action": "Connect with NGOs",
            "count": "85 Partner Orgs",
          },
          {
            "icon": Icons.storefront_rounded,
            "title": "Verified B2B Buyers & Curators",
            "desc": "Direct institutional buyers seeking certified ethical handicrafts, museum stores, and boutique hotels.",
            "action": "Browse Buyer RFQs",
            "count": "320 Verified Buyers",
          },
        ];

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: const SimpleAppBar(title: "Artisan Collaboration Hub"),
          body: SafeArea(
            child: ListView.separated(
              padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
              itemCount: pillars.length,
              separatorBuilder: (_, __) => SizedBox(height: isEasy ? 18 : 14),
              itemBuilder: (context, index) {
                final item = pillars[index];
                return Container(
                  padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderLight, width: 1.2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGoldLight,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(item['icon'] as IconData, size: isEasy ? 30 : 24, color: AppColors.textPrimary),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGoldSurface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item['count'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: AppColors.primaryGoldDark),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        item['title'] as String,
                        style: TextStyle(fontSize: isEasy ? 19 : 16.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['desc'] as String,
                        style: TextStyle(fontSize: isEasy ? 14.5 : 13, color: AppColors.textSecondary, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primaryGold),
                            backgroundColor: AppColors.primaryGoldSurface.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Opened ${item['action']} directory (Demo)")),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.textPrimary),
                          label: Text(
                            item['action'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
