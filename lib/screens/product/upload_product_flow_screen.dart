import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../models/product_model.dart';
import '../../data/dummy_data.dart';

class UploadProductFlowScreen extends StatefulWidget {
  const UploadProductFlowScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductFlowScreen> createState() => _UploadProductFlowScreenState();
}

class _UploadProductFlowScreenState extends State<UploadProductFlowScreen> {
  int _currentStep = 1; // 1 to 7

  // Simulated AI studio states
  String _selectedImage = "https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=600&auto=format&fit=crop&q=80";
  bool _bgRemoved = true;
  bool _lightingEnhanced = true;
  bool _isSpeaking = false;
  String _spokenText = "It is a handwoven Banarasi pure silk saree with real zari kadhwa weave, floral jaal, lightweight and soft.";
  
  // Simulated AI Auto-catalog generated output
  final TextEditingController _titleController = TextEditingController(text: "Handwoven Royal Banarasi Zari Silk Saree");
  final TextEditingController _titleHindiController = TextEditingController(text: "शाही बनारसी हस्तनिर्मित जरी सिल्क साड़ी");
  final TextEditingController _descController = TextEditingController(text: "Exquisite handwoven Banarasi pure Katan silk saree woven by master artisans over 14 days. Features traditional Kadhwa floral jaal in genuine gold-tone zari.");
  final TextEditingController _descHindiController = TextEditingController(text: "पारंपरिक कढ़वा तकनीक से तैयार शुद्ध रेशमी बनारसी साड़ी, 14 दिनों में हस्तनिर्मित।");
  String _category = "Handloom Weaving";
  List<String> _tags = ["Pure Silk", "Banarasi Zari", "GI Tagged", "Bridal", "Handloom"];

  // Step 5: Smart Pricing breakdown
  double _materialCost = 1450.0;
  double _labourHours = 36.0;
  double _hourlyRate = 60.0; // ₹2,160 labour
  double _suggestedPrice = 4850.0;
  double _finalPrice = 4850.0;

  bool _isAiProcessing = false;

  void _nextStep() {
    if (_currentStep == 3) {
      // Transition from Voice Describe to AI Auto-Cataloging with simulation
      setState(() {
        _currentStep = 4;
        _isAiProcessing = true;
      });
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) {
          setState(() => _isAiProcessing = false);
        }
      });
      return;
    }

    if (_currentStep == 6) {
      // Step 7: Save Product
      _saveProduct();
      return;
    }

    if (_currentStep < 6) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _saveProduct() {
    final newProduct = Product(
      id: "prod-${DateTime.now().millisecondsSinceEpoch}",
      title: _titleController.text,
      titleHindi: _titleHindiController.text,
      category: _category,
      price: _finalPrice,
      estimatedCost: _materialCost + (_labourHours * _hourlyRate),
      stock: 5,
      description: _descController.text,
      descriptionHindi: _descHindiController.text,
      tags: _tags,
      imageUrl: _selectedImage,
      completionPercentage: 100,
      craftType: _category,
    );

    DummyData.initialProducts.insert(0, newProduct);

    // Show Step 7: Save Success Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.successGreenLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: AppColors.successGreen, size: 48),
            ),
            const SizedBox(height: 18),
            const Text(
              "Product Published Successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your '${_titleController.text}' is now digitized and live in your craft catalog. B2B buyers can view verified details.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "View in My Catalog",
              icon: Icons.inventory_outlined,
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(true); // Return to home/catalog
              },
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Catalog PDF & WhatsApp link generated (Demo)")),
                );
                Navigator.of(context).pop(true);
              },
              icon: const Icon(Icons.share_outlined, size: 18, color: AppColors.textPrimary),
              label: const Text("Share on WhatsApp", style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
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

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: SimpleAppBar(
            title: "AI Product Studio (Step $_currentStep/6)",
            onBack: _prevStep,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Step Progress Indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  color: AppColors.scaffoldBackground,
                  child: Row(
                    children: List.generate(6, (index) {
                      final stepNum = index + 1;
                      final isCompleted = _currentStep > stepNum;
                      final isCurrent = _currentStep == stepNum;

                      return Expanded(
                        child: Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? AppColors.primaryGold
                                : (isCompleted ? AppColors.primaryGoldDark : AppColors.borderLight),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Step Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isEasy ? 24.0 : 20.0),
                    child: _buildCurrentStep(isEasy),
                  ),
                ),

                // Sticky Bottom Navigation Bar
                Container(
                  padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundWhite,
                    border: Border(top: BorderSide(color: AppColors.borderLight)),
                  ),
                  child: Row(
                    children: [
                      if (_currentStep > 1) ...[
                        Expanded(
                          flex: 2,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: isEasy ? 18 : 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              side: const BorderSide(color: AppColors.borderLight),
                            ),
                            onPressed: _prevStep,
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontSize: isEasy ? 16 : 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        flex: 3,
                        child: CustomButton(
                          text: _currentStep == 6 ? "Save & Publish" : "Next Step",
                          icon: _currentStep == 6 ? Icons.check_circle_outline : Icons.arrow_forward_rounded,
                          onPressed: _nextStep,
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

  Widget _buildCurrentStep(bool isEasy) {
    switch (_currentStep) {
      case 1:
        return _buildStep1Photo(isEasy);
      case 2:
        return _buildStep2AiStudio(isEasy);
      case 3:
        return _buildStep3Describe(isEasy);
      case 4:
        return _buildStep4AutoCatalog(isEasy);
      case 5:
        return _buildStep5SmartPricing(isEasy);
      case 6:
        return _buildStep6CatalogPreview(isEasy);
      default:
        return const SizedBox();
    }
  }

  // STEP 1: Product Photo
  Widget _buildStep1Photo(bool isEasy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 1: Product Photo",
          style: TextStyle(fontSize: isEasy ? 24 : 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Text(
          "Take a picture of your craft or pick from gallery. Don't worry about lighting; AI will enhance it.",
          style: TextStyle(fontSize: isEasy ? 15 : 13.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        // Photo Preview Card
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Image.network(_selectedImage, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20),

        // Action options
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Camera opened: Photo captured!")),
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: isEasy ? 18 : 14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGoldLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primaryGold),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, size: isEasy ? 24 : 20, color: AppColors.textPrimary),
                      const SizedBox(width: 8),
                      Text("Camera", style: TextStyle(fontWeight: FontWeight.w700, fontSize: isEasy ? 16 : 14)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gallery photo selected!")),
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: isEasy ? 18 : 14),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_library_outlined, size: isEasy ? 24 : 20, color: AppColors.textPrimary),
                      const SizedBox(width: 8),
                      Text("Gallery", style: TextStyle(fontWeight: FontWeight.w700, fontSize: isEasy ? 16 : 14)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 2: AI Product Studio
  Widget _buildStep2AiStudio(bool isEasy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 2: AI Photo Studio",
          style: TextStyle(fontSize: isEasy ? 24 : 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Text(
          "AI automatically removed messy background shadows and balanced studio illumination.",
          style: TextStyle(fontSize: isEasy ? 15 : 13.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),

        // Before & After comparison card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.primaryGold),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    Image.network(_selectedImage, height: 220, width: double.infinity, fit: BoxFit.cover),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.successGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text("AI Enhanced Studio Quality", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // AI Enhancements toggles
              CheckboxListTile(
                title: const Text("Clean Pure White Background", style: TextStyle(fontWeight: FontWeight.w600)),
                value: _bgRemoved,
                activeColor: AppColors.primaryGoldDark,
                onChanged: (val) => setState(() => _bgRemoved = val ?? true),
              ),
              CheckboxListTile(
                title: const Text("Artisan Studio Warm Light", style: TextStyle(fontWeight: FontWeight.w600)),
                value: _lightingEnhanced,
                activeColor: AppColors.primaryGoldDark,
                onChanged: (val) => setState(() => _lightingEnhanced = val ?? true),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 3: Describe Product (Large Mic Button)
  Widget _buildStep3Describe(bool isEasy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 3: Describe Your Craft",
          style: TextStyle(fontSize: isEasy ? 24 : 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Text(
          "Speak in Hindi, English, or your dialect. Tap the microphone and explain how you made it.",
          style: TextStyle(fontSize: isEasy ? 15 : 13.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),

        // LARGE TAP AND SPEAK MICROPHONE BUTTON
        Center(
          child: InkWell(
            onTap: () {
              setState(() => _isSpeaking = !_isSpeaking);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isSpeaking ? "Listening to your voice... Speak now!" : "Voice recorded! Transcribed."),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            borderRadius: BorderRadius.circular(60),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isEasy ? 130 : 110,
              height: isEasy ? 130 : 110,
              decoration: BoxDecoration(
                color: _isSpeaking ? AppColors.errorRed : AppColors.primaryGold,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (_isSpeaking ? AppColors.errorRed : AppColors.primaryGold).withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _isSpeaking ? Icons.mic : Icons.mic_none_rounded,
                  size: isEasy ? 60 : 48,
                  color: _isSpeaking ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            _isSpeaking ? "🔴 Listening... Tap to Finish" : "Tap and Speak (बोलकर बताएं)",
            style: TextStyle(
              fontSize: isEasy ? 18 : 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 28),

        // Transcribed voice text container
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.record_voice_over_outlined, size: 18, color: AppColors.textSecondary),
                  SizedBox(width: 8),
                  Text("What you said (Auto-transcribed):", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _spokenText,
                style: const TextStyle(fontSize: 14.5, fontStyle: FontStyle.italic, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 4: AI Auto-Cataloging
  Widget _buildStep4AutoCatalog(bool isEasy) {
    if (_isAiProcessing) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: Column(
            children: [
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.primaryGoldDark)),
              const SizedBox(height: 24),
              const Text("AI is writing catalog details...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text("Generating English + Hindi descriptions and tags", style: TextStyle(color: AppColors.textSecondary, fontSize: isEasy ? 15 : 13)),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.primaryGoldLight, borderRadius: BorderRadius.circular(12)),
              child: const Text("AI Generated", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(width: 8),
            Text("Step 4: Catalog Details", style: TextStyle(fontSize: isEasy ? 22 : 18, fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: 18),

        // English Title
        const Text("Product Title (English)", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
        const SizedBox(height: 6),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(filled: true, fillColor: AppColors.scaffoldBackground),
        ),
        const SizedBox(height: 16),

        // Hindi Title
        const Text("Product Title (हिंदी)", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
        const SizedBox(height: 6),
        TextField(
          controller: _titleHindiController,
          decoration: const InputDecoration(filled: true, fillColor: AppColors.scaffoldBackground),
        ),
        const SizedBox(height: 16),

        // English Description
        const Text("Description (English)", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
        const SizedBox(height: 6),
        TextField(
          controller: _descController,
          maxLines: 3,
          decoration: const InputDecoration(filled: true, fillColor: AppColors.scaffoldBackground),
        ),
        const SizedBox(height: 16),

        // Tags
        const Text("AI Suggested Tags", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _tags.map((tag) => Chip(
            backgroundColor: AppColors.primaryGoldSurface,
            side: const BorderSide(color: AppColors.primaryGold),
            label: Text(tag, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          )).toList(),
        ),
      ],
    );
  }

  // STEP 5: Smart Pricing
  Widget _buildStep5SmartPricing(bool isEasy) {
    final totalCost = _materialCost + (_labourHours * _hourlyRate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 5: Smart Pricing Suggestion",
          style: TextStyle(fontSize: isEasy ? 24 : 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Text(
          "कलाMITRA calculates fair compensation so you never sell below artisan value.",
          style: TextStyle(fontSize: isEasy ? 15 : 13.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),

        // Pricing Card Breakdown
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryGoldSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.primaryGold),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Raw Material Cost (Silk, Zari)", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("₹${_materialCost.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Artisan Labour (${_labourHours.toInt()} hrs @ ₹${_hourlyRate.toInt()}/hr)", style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text("₹${(_labourHours * _hourlyRate).toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Production Cost", style: TextStyle(fontWeight: FontWeight.w700)),
                  Text("₹${totalCost.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryGoldDark),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Suggested Fair Selling Price", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                        Text("35% Artisan Margin", style: TextStyle(fontSize: 11, color: AppColors.successGreen, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Text(
                      "₹${_suggestedPrice.toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 6: Catalog Preview
  Widget _buildStep6CatalogPreview(bool isEasy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 6: Digital Catalog Preview",
          style: TextStyle(fontSize: isEasy ? 24 : 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Text("This is how domestic and international B2B buyers will see your craft.", style: TextStyle(fontSize: isEasy ? 15 : 13.5, color: AppColors.textSecondary)),
        const SizedBox(height: 20),

        // Complete Digital Catalog Card Preview
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(_selectedImage, height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.primaryGoldLight, borderRadius: BorderRadius.circular(12)),
                          child: Text(_category, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                        ),
                        Text("₹${_finalPrice.toStringAsFixed(0)}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(_titleController.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(_titleHindiController.text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    const SizedBox(height: 12),
                    Text(_descController.text, style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, height: 1.4)),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 6,
                      children: _tags.map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.scaffoldBackground, borderRadius: BorderRadius.circular(8)),
                        child: Text("#$t", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
