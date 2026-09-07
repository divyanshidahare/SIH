import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/easy_mode_state.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;
        final height = isEasy ? 64.0 : 54.0;
        final fontSize = isEasy ? 18.0 : 16.0;
        final iconSize = isEasy ? 24.0 : 20.0;

        return SizedBox(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? AppColors.primaryGold : AppColors.backgroundWhite,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              shadowColor: Colors.transparent,
              side: BorderSide(
                color: isPrimary ? AppColors.primaryGoldDark : AppColors.borderLight,
                width: isEasy ? 2.0 : 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: iconSize, color: AppColors.textPrimary),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
