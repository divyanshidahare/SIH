enum OrderStatus {
  newOrder,
  pending,
  completed,
  rejected,
}

class CraftOrder {
  final String id;
  final String buyerName;
  final String buyerType; // e.g. "B2B Retailer", "Fair Customer", "Export House"
  final String productName;
  final int quantity;
  final double totalAmount;
  final DateTime orderDate;
  OrderStatus status;
  final String deliveryLocation;
  final String phone;

  CraftOrder({
    required this.id,
    required this.buyerName,
    required this.buyerType,
    required this.productName,
    required this.quantity,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.deliveryLocation,
    required this.phone,
  });
}
