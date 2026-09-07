import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/dummy_data.dart';
import '../product/upload_product_flow_screen.dart';

class MyGrowthScreen extends StatelessWidget {
  const MyGrowthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;
        final productCount = DummyData.initialProducts.length;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: const SimpleAppBar(title: "My Craft Growth"),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isEasy ? 22.0 : 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Growth Hero Card
                  Container(
                    padding: EdgeInsets.all(isEasy ? 22.0 : 18.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGoldSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryGold),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Catalog Progress",
                              style: TextStyle(fontSize: isEasy ? 18 : 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text("Level: Silver Artisan", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(
                              "$productCount",
                              style: TextStyle(fontSize: isEasy ? 36 : 30, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                            ),
                            const Text(" / 10 Products Digitized", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Linear progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: productCount / 10.0,
                            minHeight: 10,
                            backgroundColor: AppColors.backgroundWhite,
                            valueColor: const AlwaysStoppedAnimation(AppColors.primaryGoldDark),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Add 2 more products to qualify for National Handloom Export Directory.",
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Key Metrics Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(isEasy ? 18 : 14),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.remove_red_eye_outlined, color: AppColors.primaryGoldDark, size: 22),
                              const SizedBox(height: 8),
                              Text("Catalog Views", style: TextStyle(fontSize: isEasy ? 13 : 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text("342 Views", style: TextStyle(fontSize: isEasy ? 20 : 17, fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(isEasy ? 18 : 14),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.monetization_on_outlined, color: AppColors.successGreen, size: 22),
                              const SizedBox(height: 8),
                              Text("Gross Revenue", style: TextStyle(fontSize: isEasy ? 13 : 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text("₹48,800", style: TextStyle(fontSize: isEasy ? 20 : 17, fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Next Milestones Section
                  Text(
                    "Next Artisan Milestones",
                    style: TextStyle(fontSize: isEasy ? 20 : 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 14),

                  _buildMilestoneTile(
                    "Digital GI Tag Verification",
                    "Upload artisan Pehchan card to get official GI verified badge on your Banarasi sarees.",
                    isDone: true,
                    isEasy: isEasy,
                  ),
                  const SizedBox(height: 10),
                  _buildMilestoneTile(
                    "5 Products Catalog Digitization",
                    "Unlocked! Your products are now visible in the कलाMITRA wholesale directory.",
                    isDone: true,
                    isEasy: isEasy,
                  ),
                  const SizedBox(height: 10),
                  _buildMilestoneTile(
                    "PM Vishwakarma Tool Voucher",
                    "Complete 5-day training verification to receive ₹15,000 modern tool subsidy.",
                    isDone: false,
                    isEasy: isEasy,
                  ),
                  const SizedBox(height: 24),

                  // Action: Add Next Product
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const UploadProductFlowScreen()),
                        );
                      },
                      icon: const Icon(Icons.add_a_photo_outlined, size: 20),
                      label: const Text("Digitize Another Craft Product", style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMilestoneTile(String title, String desc, {required bool isDone, required bool isEasy}) {
    return Container(
      padding: EdgeInsets.all(isEasy ? 16 : 14),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? AppColors.successGreen : AppColors.textTertiary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isEasy ? 16 : 14.5,
                    fontWeight: FontWeight.w700,
                    decoration: isDone ? TextDecoration.none : null,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: TextStyle(fontSize: isEasy ? 13.5 : 12, color: AppColors.textSecondary, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
