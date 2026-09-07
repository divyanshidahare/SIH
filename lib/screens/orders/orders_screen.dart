import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/easy_mode_state.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/dummy_data.dart';
import '../../models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _acceptOrder(CraftOrder order) {
    setState(() {
      order.status = OrderStatus.pending;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Order ${order.id} accepted! Ready for artisan dispatch packaging."),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  void _markCompleted(CraftOrder order) {
    setState(() {
      order.status = OrderStatus.completed;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Order ${order.id} marked as delivered & payment released!"),
        backgroundColor: AppColors.textPrimary,
      ),
    );
  }

  void _rejectOrder(CraftOrder order) {
    setState(() {
      order.status = OrderStatus.rejected;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Order ${order.id} declined."),
        backgroundColor: AppColors.errorRed,
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
            title: "Artisan Orders & B2B",
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline_rounded, color: AppColors.textPrimary),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Direct B2B orders connect verified craft buyers directly to your workshop.")),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Tabs Bar
                Container(
                  color: AppColors.backgroundWhite,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primaryGold,
                    indicatorWeight: 3,
                    labelColor: AppColors.textPrimary,
                    unselectedLabelColor: AppColors.textTertiary,
                    labelStyle: TextStyle(
                      fontSize: isEasy ? 16 : 14,
                      fontWeight: FontWeight.w800,
                    ),
                    tabs: const [
                      Tab(text: "New Orders"),
                      Tab(text: "In Progress"),
                      Tab(text: "Completed"),
                    ],
                  ),
                ),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrdersList(OrderStatus.newOrder, isEasy),
                      _buildOrdersList(OrderStatus.pending, isEasy),
                      _buildOrdersList(OrderStatus.completed, isEasy),
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

  Widget _buildOrdersList(OrderStatus statusFilter, bool isEasy) {
    final filtered = DummyData.initialOrders.where((o) => o.status == statusFilter).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: isEasy ? 60 : 48, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text(
              "No orders in this section",
              style: TextStyle(fontSize: isEasy ? 17 : 15, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(isEasy ? 20.0 : 16.0),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => SizedBox(height: isEasy ? 18 : 14),
      itemBuilder: (context, index) {
        final order = filtered[index];
        return _buildOrderCard(order, isEasy);
      },
    );
  }

  Widget _buildOrderCard(CraftOrder order, bool isEasy) {
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
          // Order ID & Status Badge
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
                  order.id,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.textPrimary),
                ),
              ),
              Text(
                "₹${order.totalAmount.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: isEasy ? 22 : 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Product & Quantity
          Text(
            order.productName,
            style: TextStyle(fontSize: isEasy ? 18 : 15.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            "Quantity: ${order.quantity} units (${order.buyerType})",
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          // Buyer & Delivery
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Text(order.buyerName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(order.deliveryLocation, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Action Buttons based on status
          if (order.status == OrderStatus.newOrder) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.errorRed,
                      side: const BorderSide(color: AppColors.errorRed),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _rejectOrder(order),
                    child: const Text("Decline", style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGold,
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _acceptOrder(order),
                    child: const Text("Accept Order", style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ] else if (order.status == OrderStatus.pending) ...[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.textPrimary,
                minimumSize: const Size(double.infinity, 46),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _markCompleted(order),
              icon: const Icon(Icons.local_shipping_outlined, size: 18),
              label: const Text("Mark as Dispatched & Delivered", style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ] else ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.successGreenLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 16, color: AppColors.successGreen),
                  SizedBox(width: 6),
                  Text("Completed & Paid to Artisan", style: TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.w800, fontSize: 12)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
