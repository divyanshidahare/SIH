import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/easy_mode_state.dart';

/// Large, high-visibility action card designed specifically for artisans
/// Dynamically scales icon size, typography, and hit areas based on Easy Mode state
class PrimaryActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final String? badgeText;
  final Color? iconColor;
  final Color? badgeColor;

  const PrimaryActionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.badgeText,
    this.iconColor,
    this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;
        final iconScale = easyModeController.iconScale;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            splashColor: AppColors.primaryGoldLight,
            highlightColor: AppColors.primaryGoldSurface,
            child: Container(
              padding: EdgeInsets.all(isEasy ? 22.0 : 18.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isEasy ? AppColors.primaryGold : AppColors.borderLight,
                  width: isEasy ? 2.0 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Large Icon Container with Soft Golden Accent
                      Container(
                        padding: EdgeInsets.all(isEasy ? 16.0 : 13.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGoldLight.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryGold.withOpacity(0.6),
                            width: 1.0,
                          ),
                        ),
                        child: Icon(
                          icon,
                          size: (isEasy ? 42.0 : 32.0) * (isEasy ? 1.15 : 1.0),
                          color: iconColor ?? AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Short Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: isEasy ? 19.0 : 16.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Small Simple Description
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: isEasy ? 14.5 : 12.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // Optional Notification / Status Badge
                  if (badgeText != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor ?? AppColors.primaryGold,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          badgeText!,
                          style: TextStyle(
                            fontSize: isEasy ? 13.0 : 11.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
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
}
