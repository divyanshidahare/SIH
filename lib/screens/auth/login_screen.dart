import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/custom_button.dart';
import '../home/home_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController(text: "9876543210");
  final TextEditingController _passwordController = TextEditingController(text: "artisan123");
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleLogin() {
    setState(() => _isLoading = true);

    // Simulated quick frontend authentication
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeDashboardScreen()),
        );
      }
    });
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Reset Password"),
        content: const Text(
          "We will send an OTP via SMS to your registered mobile number (+91 98765 43210) to reset your password.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("SMS OTP sent to your phone (Demo)")),
              );
            },
            child: const Text("Send OTP", style: TextStyle(color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }

  void _showCreateAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Create Artisan Account"),
        content: const Text(
          "New artisan onboarding requires your Name, Craft Category, and Mobile Number. For this demo, clicking 'Continue' logs you in directly as Master Artisan Priya.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold),
            onPressed: () {
              Navigator.pop(context);
              _handleLogin();
            },
            child: const Text("Create & Continue", style: TextStyle(color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isEasy ? 26.0 : 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Brand Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGoldLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryGold.withOpacity(0.5)),
                    ),
                    child: const Text(
                      "कलाMITRA ARTISAN PORTAL",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    "Welcome to कलाMITRA",
                    style: TextStyle(
                      fontSize: isEasy ? 30 : 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    "Sign in to manage your handmade craft business and explore new B2B orders.",
                    style: TextStyle(
                      fontSize: isEasy ? 16 : 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Mobile Number or Email
                  Text(
                    "Mobile Number or Email",
                    style: TextStyle(
                      fontSize: isEasy ? 16 : 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _identifierController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: isEasy ? 18 : 16),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_iphone_rounded, color: AppColors.textSecondary),
                      hintText: "Enter 10-digit mobile or email",
                      filled: true,
                      fillColor: AppColors.scaffoldBackground,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: isEasy ? 16 : 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(fontSize: isEasy ? 18 : 16),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      hintText: "Enter your password",
                      filled: true,
                      fillColor: AppColors.scaffoldBackground,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: isEasy ? 15 : 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  CustomButton(
                    text: "Login",
                    isLoading: _isLoading,
                    icon: Icons.login_rounded,
                    onPressed: _handleLogin,
                  ),
                  const SizedBox(height: 16),

                  // Create Account Button (Secondary)
                  CustomButton(
                    text: "Create Account",
                    isPrimary: false,
                    icon: Icons.person_add_outlined,
                    onPressed: _showCreateAccountDialog,
                  ),
                  const SizedBox(height: 32),

                  // Strictly No Guest Login banner notice
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGoldSurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primaryGold.withOpacity(0.4)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.shield_outlined, size: 20, color: AppColors.primaryGoldDark),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Verified artisan accounts ensure direct payments and government scheme benefits.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
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
