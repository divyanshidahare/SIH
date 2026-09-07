import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/easy_mode_state.dart';

/// Standard AppBar for कलाMITRA secondary screens
/// Provides an unmistakably clear, large, prominent Back button (`< Back`)
/// so low-literacy artisans never get stuck or lost.
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final bool showBackButton;

  const SimpleAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.onBack,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(easyModeController.isEasyMode ? 68.0 : 58.0);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;
        
        return AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          scrolledUnderElevation: 1,
          automaticallyImplyLeading: false,
          leadingWidth: showBackButton ? (isEasy ? 110 : 96) : 0,
          leading: showBackButton
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: InkWell(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGoldLight.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primaryGold.withOpacity(0.5), width: 1.2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: isEasy ? 20 : 16,
                            color: AppColors.textPrimary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: isEasy ? 16 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isEasy ? 20 : 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
