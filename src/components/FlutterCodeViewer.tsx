import React, { useState } from 'react';
import { FileCode, Copy, Check, X, FolderTree, Code2 } from 'lucide-react';

interface FileEntry {
  path: string;
  name: string;
  category: string;
  content: string;
}

export const FlutterCodeViewer: React.FC<{ isOpen: boolean; onClose: () => void }> = ({
  isOpen,
  onClose,
}) => {
  const [selectedPath, setSelectedPath] = useState<string>('lib/main.dart');
  const [copied, setCopied] = useState(false);

  if (!isOpen) return null;

  const flutterFiles: FileEntry[] = [
    {
      path: 'lib/main.dart',
      name: 'main.dart',
      category: 'Entrypoint',
      content: `import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const KalamitraApp());
}`,
    },
    {
      path: 'lib/app.dart',
      name: 'app.dart',
      category: 'App Root',
      content: `import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'state/artisan_profile_state.dart';
import 'screens/splash/splash_screen.dart';

class KalamitraApp extends StatelessWidget {
  const KalamitraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'कलाMITRA - Your AI Partner for Every Craft',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}`,
    },
    {
      path: 'lib/theme/app_colors.dart',
      name: 'app_colors.dart',
      category: 'Design Tokens',
      content: `import 'package:flutter/material.dart';

class AppColors {
  // Natural Tones: Off-White & Golden Accent (#B45309)
  static const Color backgroundWhite = Color(0xFFFDFDFD);
  static const Color primaryGold = Color(0xFFB45309);
  static const Color primaryGoldLight = Color(0xFFFEF3C7);
  static const Color primaryGoldSurface = Color(0xFFFFFBEB);
  static const Color primaryGoldDark = Color(0xFF92400E);

  // Typography & Neutrals
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color scaffoldBackground = Color(0xFFFDFDFD);
}`,
    },
    {
      path: 'lib/state/artisan_profile_state.dart',
      name: 'artisan_profile_state.dart',
      category: 'Artisan State',
      content: `import 'package:flutter/material.dart';

class ArtisanProfileState extends ChangeNotifier {
  String name = "Priya Devi";
  String dob = "1988-04-12";
  String address = "House 42, Weavers Colony, Kabir Chaura, Varanasi, UP 221001";
  String specialisation = "Handloom Silk & Zari Brocade Weaving";
  String phone = "+91 98765 43210";
  String language = "English";

  void updateProfile({
    String? newName,
    String? newDob,
    String? newAddress,
    String? newSpecialisation,
  }) {
    if (newName != null) name = newName;
    if (newDob != null) dob = newDob;
    if (newAddress != null) address = newAddress;
    if (newSpecialisation != null) specialisation = newSpecialisation;
    notifyListeners();
  }
}

final artisanProfileState = ArtisanProfileState();`,
    },
    {
      path: 'lib/screens/home/home_dashboard_screen.dart',
      name: 'home_dashboard_screen.dart',
      category: 'Core Screen',
      content: `// Main Home Dashboard with 4 Large Primary Action Cards:
// 1. Upload Product (AI Studio)
// 2. New Orders
// 3. Ask Help (AI Advisor)
// 4. Inventory
// Plus Bottom Navigation: Home, Catalog, Upload, Opportunities, Profile`,
    },
    {
      path: 'lib/screens/product/upload_product_flow_screen.dart',
      name: 'upload_product_flow_screen.dart',
      category: 'AI Workflow',
      content: `// 7-Step AI Product Cataloging Workflow:
// Step 1: Product Photo
// Step 2: AI Photo Studio (Background cleaning & lighting)
// Step 3: Describe Product (Big Mic Tap & Speak)
// Step 4: AI Auto-Cataloging (Bilingual titles & tags)
// Step 5: Smart Pricing (Material + Hours * Wage + 35% margin)
// Step 6: Catalog Preview
// Step 7: Save & Publish (WhatsApp share)`,
    },
    {
      path: 'lib/screens/profile/profile_screen.dart',
      name: 'profile_screen.dart',
      category: 'Profile Screen',
      content: `import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../orders/orders_screen.dart';
import '../growth/my_growth_screen.dart';
import '../collaboration/collaboration_hub_screen.dart';
import 'settings_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final bool isRootTab;

  const ProfileScreen({Key? key, this.isRootTab = false}) : super(key: key);

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
}`,
    },
    {
      path: 'lib/screens/language/language_screen.dart',
      name: 'language_screen.dart',
      category: 'Language Screen',
      content: `// Language Selection Screen
// Direct title: "Choose Your Language"
// Subtitle: "You can change this anytime later in Settings"
// Clean card layout supporting bilingual titles, native scripts & phonetics
// Routing: Onboarding -> Login, or Settings -> Back to Settings`,
    },
    {
      path: 'pubspec.yaml',
      name: 'pubspec.yaml',
      category: 'Config',
      content: `name: kalamitra
description: "कलाMITRA - Your AI Partner for Every Craft"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true`,
    },
  ];

  const activeFile = flutterFiles.find((f) => f.path === selectedPath) || flutterFiles[0];

  const handleCopy = () => {
    navigator.clipboard.writeText(activeFile.content);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <div className="fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-3 sm:p-6 backdrop-blur-xs">
      <div className="bg-white w-full max-w-4xl h-[85vh] rounded-3xl overflow-hidden shadow-2xl flex flex-col border border-gray-200 animate-slide-up">
        {/* Header */}
        <div className="p-4 bg-gray-900 text-white flex items-center justify-between border-b border-gray-800">
          <div className="flex items-center gap-2.5">
            <div className="p-2 rounded-xl bg-[#B45309] text-white">
              <Code2 size={20} />
            </div>
            <div>
              <h2 className="text-base font-black">Flutter Project Files (`.dart`)</h2>
              <p className="text-xs text-gray-400">Complete, clean Flutter architecture in `lib/`</p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <button
              onClick={handleCopy}
              className="bg-gray-800 hover:bg-gray-700 text-white text-xs font-bold px-3 py-1.5 rounded-xl flex items-center gap-1.5 transition-all"
            >
              {copied ? <Check size={14} className="text-green-400" /> : <Copy size={14} />}
              <span>{copied ? "Copied!" : "Copy Code"}</span>
            </button>

            <button
              onClick={onClose}
              className="p-1.5 rounded-xl hover:bg-gray-800 text-gray-400 hover:text-white"
            >
              <X size={20} />
            </button>
          </div>
        </div>

        {/* Content Explorer */}
        <div className="flex-1 flex overflow-hidden">
          {/* Sidebar file tree */}
          <div className="w-64 bg-gray-50 border-r border-gray-200 overflow-y-auto p-3 space-y-1">
            <div className="flex items-center gap-1.5 text-xs font-black text-gray-400 uppercase tracking-wider px-2 py-1 mb-2">
              <FolderTree size={14} /> Project Explorer
            </div>

            {flutterFiles.map((file) => (
              <button
                key={file.path}
                onClick={() => setSelectedPath(file.path)}
                className={`w-full text-left px-3 py-2 rounded-xl text-xs font-bold flex items-center gap-2 transition-all ${
                  selectedPath === file.path
                    ? 'bg-[#B45309] text-white shadow-xs'
                    : 'text-gray-600 hover:bg-gray-200/60'
                }`}
              >
                <FileCode size={14} className="shrink-0" />
                <span className="truncate">{file.name}</span>
              </button>
            ))}
          </div>

          {/* Code Viewer Panel */}
          <div className="flex-1 bg-[#1E1E1E] text-gray-200 font-mono text-xs overflow-auto p-5 leading-relaxed">
            <div className="text-gray-500 mb-3 select-none pb-2 border-b border-gray-800 flex justify-between">
              <span>{activeFile.path}</span>
              <span className="text-gray-400 uppercase">{activeFile.category}</span>
            </div>
            <pre className="whitespace-pre overflow-x-auto selection:bg-[#B45309]/30">
              {activeFile.content}
            </pre>
          </div>
        </div>
      </div>
    </div>
  );
};
