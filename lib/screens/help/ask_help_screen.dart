import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';

class AskHelpScreen extends StatefulWidget {
  const AskHelpScreen({Key? key}) : super(key: key);

  @override
  State<AskHelpScreen> createState() => _AskHelpScreenState();
}

class _AskHelpScreenState extends State<AskHelpScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "isAi": true,
      "text": "Namaste Priya ji! I am कलाMITRA AI Sarthi, your virtual craft advisor. How can I help your artisan business today?",
      "time": "Just now",
    },
  ];

  final List<Map<String, dynamic>> _quickHelpCategories = [
    {
      "icon": Icons.camera_alt_outlined,
      "title": "Photography Tips",
      "prompt": "How do I take sharp photos of my handloom sarees with low natural light?",
      "response": "Use morning window light placed at a 45° angle. Avoid flashlight, which causes glare on zari. कलाMITRA AI Studio will automatically clean the background!",
    },
    {
      "icon": Icons.calculate_outlined,
      "title": "Pricing Calculation",
      "prompt": "How do I price my craft so I don't lose money on raw silk?",
      "response": "Formula: (Raw Material Cost + Packaging) + (Crafting Hours × ₹60/hr minimum) + 35% artisan profit margin. For your Banarasi silk, suggested selling price is ₹4,850 - ₹6,850.",
    },
    {
      "icon": Icons.account_balance_outlined,
      "title": "Govt Schemes & Grants",
      "prompt": "How can I get the ₹15,000 tool incentive under PM Vishwakarma?",
      "response": "Step 1: Visit your nearest Common Service Center (CSC) with Aadhaar and Artisan Pehchan card. Step 2: Choose 'Weaver/Potter' trade. Step 3: Complete 5-day basic training to receive digital toolkit voucher.",
    },
    {
      "icon": Icons.handshake_outlined,
      "title": "B2B Buyers & Fairs",
      "prompt": "How do I connect with craft emporiums for bulk orders?",
      "response": "Export your digitized catalog as a PDF directly from the Catalog screen. Verified institutional buyers on कलाMITRA require minimum 5 products digitized with GI tagging.",
    },
  ];

  void _sendMessage(String userText) {
    if (userText.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "isAi": false,
        "text": userText,
        "time": "Now",
      });
      _chatController.clear();
    });

    // Simulated AI response
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        String aiReply = "Thank you for asking! For traditional artisan crafts, maintaining authentic handloom provenance and pricing your labour at fair market rates guarantees long-term sustainability. Would you like me to guide you through cataloging or government scheme application?";
        
        for (var cat in _quickHelpCategories) {
          if (cat['prompt'] == userText) {
            aiReply = cat['response'] as String;
            break;
          }
        }

        setState(() {
          _messages.add({
            "isAi": true,
            "text": aiReply,
            "time": "Now",
          });
        });

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: SimpleAppBar(
            title: "Ask कलाMITRA AI",
            actions: [
              IconButton(
                icon: const Icon(Icons.volume_up_outlined, color: AppColors.textPrimary),
                tooltip: "Listen in Hindi",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Voice read-aloud active (Hindi / English audio demo)")),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Category Pills for Quick Help
                Container(
                  height: isEasy ? 56 : 46,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  color: AppColors.scaffoldBackground,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _quickHelpCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final item = _quickHelpCategories[index];
                      return ActionChip(
                        avatar: Icon(item['icon'] as IconData, size: 16, color: AppColors.textPrimary),
                        label: Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: isEasy ? 14 : 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        backgroundColor: AppColors.backgroundWhite,
                        side: const BorderSide(color: AppColors.borderLight),
                        onPressed: () => _sendMessage(item['prompt'] as String),
                      );
                    },
                  ),
                ),

                // Chat Messages List
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                    itemCount: _messages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isAi = msg['isAi'] as bool;

                      return Align(
                        alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
                          padding: EdgeInsets.all(isEasy ? 18.0 : 14.0),
                          decoration: BoxDecoration(
                            color: isAi ? AppColors.primaryGoldSurface : AppColors.textPrimary,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isAi ? 4 : 16),
                              bottomRight: Radius.circular(isAi ? 16 : 4),
                            ),
                            border: Border.all(
                              color: isAi ? AppColors.primaryGold.withOpacity(0.5) : Colors.transparent,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isAi) ...[
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.auto_awesome, size: 14, color: AppColors.primaryGoldDark),
                                    SizedBox(width: 4),
                                    Text(
                                      "कलाMITRA AI Advisor",
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryGoldDark),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                              ],
                              Text(
                                msg['text'] as String,
                                style: TextStyle(
                                  fontSize: isEasy ? 16 : 14,
                                  fontWeight: FontWeight.w500,
                                  color: isAi ? AppColors.textPrimary : Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Input Bar with Voice & Send
                Container(
                  padding: EdgeInsets.all(isEasy ? 16.0 : 12.0),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundWhite,
                    border: Border(top: BorderSide(color: AppColors.borderLight)),
                  ),
                  child: Row(
                    children: [
                      // Voice Tap button
                      IconButton(
                        onPressed: () {
                          _sendMessage("How do I take sharp photos of my handloom sarees with low natural light?");
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: AppColors.primaryGoldLight, shape: BoxShape.circle),
                          child: const Icon(Icons.mic, color: AppColors.textPrimary, size: 20),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Text Field
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          onSubmitted: _sendMessage,
                          decoration: const InputDecoration(
                            hintText: "Ask anything in Hindi or English...",
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Send Button
                      IconButton(
                        onPressed: () => _sendMessage(_chatController.text),
                        icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: AppColors.primaryGold, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_upward_rounded, color: AppColors.textPrimary, size: 20),
                        ),
                      ),
                    ],
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
