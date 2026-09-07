import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/dummy_data.dart';
import '../../models/product_model.dart';
import '../product/upload_product_flow_screen.dart';

class DigitalCatalogScreen extends StatefulWidget {
  final bool isRootTab;

  const DigitalCatalogScreen({
    Key? key,
    this.isRootTab = false,
  }) : super(key: key);

  @override
  State<DigitalCatalogScreen> createState() => _DigitalCatalogScreenState();
}

class _DigitalCatalogScreenState extends State<DigitalCatalogScreen> {
  String _selectedCategory = "All";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    "All",
    "Handloom Weaving",
    "Terracotta Pottery",
    "Woodcraft",
    "Block Printing",
    "Metal Craft"
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        // Filter products
        final filteredProducts = DummyData.initialProducts.where((p) {
          final matchesCategory = _selectedCategory == "All" || p.category == _selectedCategory;
          final matchesSearch = _searchQuery.isEmpty ||
              p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              p.titleHindi.contains(_searchQuery);
          return matchesCategory && matchesSearch;
        }).toList();

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: SimpleAppBar(
            title: "My Digital Catalog",
            showBackButton: !widget.isRootTab,
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.textPrimary),
                tooltip: "Add Product",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const UploadProductFlowScreen()),
                  ).then((_) => setState(() {}));
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Search Input Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isEasy ? 20.0 : 16.0, vertical: 8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: "Search products in English or हिंदी...",
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = "");
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.scaffoldBackground,
                    ),
                  ),
                ),

                // Category Filter Chips
                SizedBox(
                  height: isEasy ? 50 : 42,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat;

                      return ChoiceChip(
                        label: Text(
                          cat,
                          style: TextStyle(
                            fontSize: isEasy ? 15 : 13,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.primaryGold,
                        backgroundColor: AppColors.scaffoldBackground,
                        side: BorderSide(
                          color: isSelected ? AppColors.primaryGoldDark : AppColors.borderLight,
                        ),
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Product Count Summary Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${filteredProducts.length} Artisan Products Live",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textSecondary),
                      ),
                      Text(
                        "All Digitized via AI Studio",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryGoldDark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Product Cards List
                Expanded(
                  child: filteredProducts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.inventory_2_outlined, size: 54, color: AppColors.textTertiary),
                              const SizedBox(height: 12),
                              const Text("No craft products match your query", style: TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => setState(() {
                                  _selectedCategory = "All";
                                  _searchQuery = "";
                                  _searchController.clear();
                                }),
                                child: const Text("Reset Filters"),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                          itemCount: filteredProducts.length,
                          separatorBuilder: (_, __) => SizedBox(height: isEasy ? 18 : 14),
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return _buildCatalogCard(product, isEasy);
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

  Widget _buildCatalogCard(Product product, bool isEasy) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Completion Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(
                  product.imageUrl,
                  height: isEasy ? 180 : 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 12, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        "${product.completionPercentage}% AI Digitized",
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: product.stock < 5 ? AppColors.errorRedLight : AppColors.primaryGoldLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: product.stock < 5 ? AppColors.errorRed : AppColors.primaryGold,
                    ),
                  ),
                  child: Text(
                    product.stock < 5 ? "Low Stock: ${product.stock}" : "Stock: ${product.stock}",
                    style: TextStyle(
                      color: product.stock < 5 ? AppColors.errorRed : AppColors.textPrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Details Section
          Padding(
            padding: EdgeInsets.all(isEasy ? 18.0 : 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      "₹${product.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: isEasy ? 22 : 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: isEasy ? 18 : 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.titleHindi,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),

                // Tags
                Wrap(
                  spacing: 6,
                  children: product.tags.take(3).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGoldSurface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "#$tag",
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // Actions: Share Catalog & Edit
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("B2B link for '${product.title}' copied to clipboard!")),
                          );
                        },
                        icon: const Icon(Icons.share_outlined, size: 16),
                        label: const Text("Share Card", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGold,
                          foregroundColor: AppColors.textPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Product details opened in AI Editor")),
                          );
                        },
                        icon: const Icon(Icons.edit_note_rounded, size: 18),
                        label: const Text("Quick Edit", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
