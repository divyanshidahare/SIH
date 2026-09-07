import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/dummy_data.dart';
import '../../models/product_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  void _updateStock(Product product, int delta) {
    setState(() {
      final newStock = (product.stock + delta).clamp(0, 999);
      final index = DummyData.initialProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        DummyData.initialProducts[index] = product.copyWith(stock: newStock);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Updated stock for '${product.title}' to ${(product.stock + delta).clamp(0, 999)}"),
        duration: const Duration(milliseconds: 700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        final isEasy = easyModeController.isEasyMode;

        final totalItems = DummyData.initialProducts.fold<int>(0, (sum, p) => sum + p.stock);
        final lowStockItems = DummyData.initialProducts.where((p) => p.stock < 5).length;
        final totalValue = DummyData.initialProducts.fold<double>(0, (sum, p) => sum + (p.stock * p.price));

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: const SimpleAppBar(title: "Craft Inventory"),
          body: SafeArea(
            child: Column(
              children: [
                // Top Summary Cards
                Padding(
                  padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                  child: Row(
                    children: [
                      // Total Units
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(isEasy ? 18 : 14),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGoldLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primaryGold),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Stock", style: TextStyle(fontSize: isEasy ? 14 : 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text("$totalItems Units", style: TextStyle(fontSize: isEasy ? 22 : 18, fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Low Stock Alert Card
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(isEasy ? 18 : 14),
                          decoration: BoxDecoration(
                            color: lowStockItems > 0 ? AppColors.errorRedLight : AppColors.successGreenLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: lowStockItems > 0 ? AppColors.errorRed : AppColors.successGreen),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Low Stock Items",
                                style: TextStyle(
                                  fontSize: isEasy ? 14 : 12,
                                  fontWeight: FontWeight.w600,
                                  color: lowStockItems > 0 ? AppColors.errorRed : AppColors.successGreen,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "$lowStockItems Products",
                                style: TextStyle(
                                  fontSize: isEasy ? 22 : 18,
                                  fontWeight: FontWeight.w900,
                                  color: lowStockItems > 0 ? AppColors.errorRed : AppColors.successGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Total Estimated Inventory Value
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGoldSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryGold.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.currency_rupee_rounded, size: 18, color: AppColors.primaryGoldDark),
                          SizedBox(width: 6),
                          Text("Estimated Stock Value:", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        ],
                      ),
                      Text("₹${totalValue.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Inventory Items List
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
                    itemCount: DummyData.initialProducts.length,
                    separatorBuilder: (_, __) => SizedBox(height: isEasy ? 16 : 12),
                    itemBuilder: (context, index) {
                      final product = DummyData.initialProducts[index];
                      final isLow = product.stock < 5;

                      return Container(
                        padding: EdgeInsets.all(isEasy ? 18.0 : 14.0),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isLow ? AppColors.errorRed.withOpacity(0.5) : AppColors.borderLight,
                            width: isLow ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Product Thumbnail
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(product.imageUrl, width: isEasy ? 64 : 52, height: isEasy ? 64 : 52, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 14),

                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: isEasy ? 16 : 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "₹${product.price.toStringAsFixed(0)} • ${product.category}",
                                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                                  ),
                                  if (isLow) ...[
                                    const SizedBox(height: 4),
                                    const Text("⚠️ Low stock warning", style: TextStyle(color: AppColors.errorRed, fontSize: 11, fontWeight: FontWeight.w700)),
                                  ],
                                ],
                              ),
                            ),

                            // Stock Control Buttons (+ and -)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => _updateStock(product, -1),
                                  icon: Container(
                                    width: isEasy ? 38 : 32,
                                    height: isEasy ? 38 : 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.scaffoldBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.borderLight),
                                    ),
                                    child: const Icon(Icons.remove, size: 16),
                                  ),
                                ),
                                Text(
                                  "${product.stock}",
                                  style: TextStyle(
                                    fontSize: isEasy ? 20 : 16,
                                    fontWeight: FontWeight.w900,
                                    color: isLow ? AppColors.errorRed : AppColors.textPrimary,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _updateStock(product, 1),
                                  icon: Container(
                                    width: isEasy ? 38 : 32,
                                    height: isEasy ? 38 : 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryGoldLight,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.primaryGold),
                                    ),
                                    child: const Icon(Icons.add, size: 16, color: AppColors.textPrimary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
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
}
