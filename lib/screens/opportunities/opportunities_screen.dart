import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/dummy_data.dart';
import '../../models/opportunity_model.dart';

class OpportunitiesScreen extends StatefulWidget {
  final bool isRootTab;

  const OpportunitiesScreen({
    Key? key,
    this.isRootTab = false,
  }) : super(key: key);

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  OpportunityType? _selectedType;

  void _showApplicationModal(Opportunity opp) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryGoldLight, borderRadius: BorderRadius.circular(10)),
                  child: const Text("Verified Scheme / Fair", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 12),
            Text(opp.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text(opp.organization, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primaryGoldSurface, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.card_giftcard_rounded, color: AppColors.primaryGoldDark, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(opp.stipendOrGrant, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Eligibility Requirements:", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 8),
            ...opp.eligibility.map((el) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: AppColors.successGreen),
                  const SizedBox(width: 8),
                  Text(el, style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary)),
                ],
              ),
            )),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.textPrimary,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Application draft generated with your digitized artisan catalog! (Demo)"),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
              },
              child: const Text("Apply with Digitized Catalog", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        final items = _selectedType == null
            ? DummyData.initialOpportunities
            : DummyData.initialOpportunities.where((o) => o.type == _selectedType).toList();

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: SimpleAppBar(
            title: "Government & Market Support",
            showBackButton: !widget.isRootTab,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Clear Demo Data Disclaimer Notice
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.infoBlueLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.infoBlue.withOpacity(0.4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.verified_outlined, size: 18, color: AppColors.infoBlue),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Sample curated opportunities: MSME, Ministry of Textiles, and UNESCO schemes.",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.infoBlue),
                        ),
                      ),
                    ],
                  ),
                ),

                // Opportunities List
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: isEasy ? 18 : 14),
                    itemBuilder: (context, index) {
                      final opp = items[index];
                      return _buildOpportunityCard(opp, isEasy);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOpportunityCard(Opportunity opp, bool isEasy) {
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
          // Header: Tag & Deadline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryGoldLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  opp.type == OpportunityType.governmentScheme ? "Govt Scheme" : (opp.type == OpportunityType.tradeFair ? "Trade Fair" : "NGO Grant"),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: AppColors.textPrimary),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.schedule_rounded, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(opp.deadline, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title & Org
          Text(
            opp.title,
            style: TextStyle(fontSize: isEasy ? 19 : 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            opp.organization,
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),

          // Financial Benefit / Grant
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryGoldSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryGold.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                const Icon(Icons.currency_rupee, size: 16, color: AppColors.primaryGoldDark),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    opp.stipendOrGrant,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            opp.description,
            style: TextStyle(fontSize: isEasy ? 14 : 13, color: AppColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 16),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _showApplicationModal(opp),
              child: const Text("View Scheme & Apply", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
