import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/opportunity_model.dart';

class DummyData {
  // Artisan Profile Information
  static const String artisanName = "Priya Sharma";
  static const String artisanCraft = "Master Handloom Weaver & Banarasi Artisan";
  static const String artisanLocation = "Varanasi, Uttar Pradesh";
  static const String artisanPhone = "+91 98765 43210";
  static const String artisanExperience = "14 Years";

  // Simulated Craft Products in Artisan's Digital Catalog
  static List<Product> initialProducts = [
    Product(
      id: "prod-001",
      title: "Handwoven Banarasi Katan Silk Saree",
      titleHindi: "हाथ से बुनी बनारसी कातान सिल्क साड़ी",
      category: "Handloom Weaving",
      price: 6850.0,
      estimatedCost: 3200.0,
      stock: 8,
      description: "Authentic hand-loomed pure Katan silk with gold Zari floral motifs (Kadhwa technique). Woven over 18 days by Varanasi artisan.",
      descriptionHindi: "प्रामाणिक कढ़वा तकनीक से शुद्ध कातान सिल्क पर सोने की जरी से हाथ से बुनी गई उत्कृष्ट साड़ी।",
      tags: ["Pure Silk", "Zari Work", "GI Tagged", "Bridal Wear", "Handloom"],
      imageUrl: "https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=600&auto=format&fit=crop&q=80",
      completionPercentage: 100,
      craftType: "Silk Weaving",
    ),
    Product(
      id: "prod-002",
      title: "Handmade Terracotta Decorative Urli",
      titleHindi: "हस्तनिर्मित टेराकोटा पारंपरिक उरली",
      category: "Terracotta Pottery",
      price: 1250.0,
      estimatedCost: 420.0,
      stock: 14,
      description: "Natural riverbed clay handcrafted water vessel with floral petal carvings. Kiln-fired using traditional wood techniques.",
      descriptionHindi: "नदी की शुद्ध मिट्टी से हस्तनिर्मित सजावटी पात्र, फूलों की पंखुड़ियों की नक्काशी के साथ।",
      tags: ["Natural Clay", "Eco-friendly", "Home Decor", "Festive", "Pottery"],
      imageUrl: "https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=600&auto=format&fit=crop&q=80",
      completionPercentage: 95,
      craftType: "Clay Pottery",
    ),
    Product(
      id: "prod-003",
      title: "Channapatna Non-Toxic Wooden Toy Set",
      titleHindi: "चन्नपट्टना प्राकृतिक लकड़ी के खिलौने",
      category: "Woodcraft",
      price: 890.0,
      estimatedCost: 310.0,
      stock: 22,
      description: "Turned Wrightia tinctoria (Ivory wood) finished with organic vegetable dyes. 100% child safe and certified GI craft.",
      descriptionHindi: "प्राकृतिक वनस्पति रंगों और सुरक्षित लाख से तैयार पारंपरिक कन्नड़ लकड़ी के खिलौने।",
      tags: ["GI Tagged", "Child Safe", "Organic Dye", "Wood Turning", "Eco Toy"],
      imageUrl: "https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?w=600&auto=format&fit=crop&q=80",
      completionPercentage: 100,
      craftType: "Lacquered Wood",
    ),
    Product(
      id: "prod-004",
      title: "Jaipur Hand Block Printed Cotton Stole",
      titleHindi: "जयपुर हैंड ब्लॉक प्रिंट कॉटन स्टोल",
      category: "Block Printing",
      price: 950.0,
      estimatedCost: 380.0,
      stock: 3, // Low stock demo!
      description: "Natural indigo and madder root dyes printed with hand-carved teak wood blocks on organic mulmul cotton.",
      descriptionHindi: "जैविक मलमल सूती कपड़े पर प्राकृतिक नील और मजीठ के रंगों से हस्तनिर्मित ठप्पा छपाई।",
      tags: ["Dabu Print", "Natural Indigo", "Mulmul Cotton", "Artisan Block"],
      imageUrl: "https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?w=600&auto=format&fit=crop&q=80",
      completionPercentage: 80,
      craftType: "Hand Block Print",
    ),
    Product(
      id: "prod-005",
      title: "Dhokra Lost-Wax Cast Brass Tribal Figurine",
      titleHindi: "ढोकरा पारंपरिक पीतल आदिवासी प्रतिमा",
      category: "Metal Craft",
      price: 2400.0,
      estimatedCost: 950.0,
      stock: 5,
      description: "Ancient 4000-year-old Harappan lost-wax casting technique executed in non-ferrous brass alloy by Bastar artisans.",
      descriptionHindi: "बस्तर के पारंपरिक कारीगरों द्वारा प्राचीन मोम ढलाई पद्धति से निर्मित धातु शिल्प।",
      tags: ["Lost Wax", "Tribal Craft", "Bastar", "Brass Art", "Ancient Craft"],
      imageUrl: "https://images.unsplash.com/photo-1582562124811-c09040d0a901?w=600&auto=format&fit=crop&q=80",
      completionPercentage: 90,
      craftType: "Dhokra Metal",
    ),
  ];

  // Simulated Craft B2B & Wholesale Orders
  static List<CraftOrder> initialOrders = [
    CraftOrder(
      id: "ORD-9421",
      buyerName: "Hastkala Heritage Emporium",
      buyerType: "B2B Retailer (New Delhi)",
      productName: "Handwoven Banarasi Katan Silk Saree",
      quantity: 4,
      totalAmount: 27400.0,
      orderDate: DateTime.now().subtract(const Duration(hours: 4)),
      status: OrderStatus.newOrder,
      deliveryLocation: "Connaught Place, New Delhi",
      phone: "+91 91234 56789",
    ),
    CraftOrder(
      id: "ORD-9388",
      buyerName: "Sanskriti Handlooms Collective",
      buyerType: "NGO Craft Guild",
      productName: "Jaipur Hand Block Printed Cotton Stole",
      quantity: 12,
      totalAmount: 11400.0,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      status: OrderStatus.pending,
      deliveryLocation: "C-Scheme, Jaipur, Rajasthan",
      phone: "+91 98877 66554",
    ),
    CraftOrder(
      id: "ORD-9210",
      buyerName: "Dastkar Craft Council",
      buyerType: "Exhibition Consignment",
      productName: "Handmade Terracotta Decorative Urli",
      quantity: 8,
      totalAmount: 10000.0,
      orderDate: DateTime.now().subtract(const Duration(days: 5)),
      status: OrderStatus.completed,
      deliveryLocation: "Kisan Haat, Andheria Modh, New Delhi",
      phone: "+91 94433 22110",
    ),
  ];

  // Simulated Government Schemes & Fair Opportunities
  static List<Opportunity> initialOpportunities = [
    Opportunity(
      id: "OPP-01",
      title: "PM Vishwakarma Scheme - Tool Kit & Credit",
      organization: "Ministry of Micro, Small and Medium Enterprises (MSME)",
      type: OpportunityType.governmentScheme,
      deadline: "Open All Year 2026",
      stipendOrGrant: "₹15,000 Tool Incentive + Collateral-Free ₹3 Lakh Loan at 5%",
      description: "End-to-end support for traditional artisans including modern toolkits, digital transaction incentives, and skill training.",
      eligibility: ["Traditional Artisan/Craftsperson", "Age 18+", "Artisan ID or Pehchan Card"],
      applicationStatus: "Open",
    ),
    Opportunity(
      id: "OPP-02",
      title: "Surajkund International Crafts Mela 2026",
      organization: "Haryana Tourism & Ministry of Textiles",
      type: OpportunityType.tradeFair,
      deadline: "November 15, 2026",
      stipendOrGrant: "Free Stall Space + Daily TA/DA Allowance for Master Weavers",
      description: "World's largest craft fair attracting 1.5 million visitors and international buyers. Direct showcase for authentic handmade textiles.",
      eligibility: ["Registered Weavers / National Awardees", "Sample Catalog Submission"],
      applicationStatus: "Closing Soon",
    ),
    Opportunity(
      id: "OPP-03",
      title: "One District One Product (ODOP) Export Drive",
      organization: "Invest India & Ministry of Commerce",
      type: OpportunityType.governmentScheme,
      deadline: "December 31, 2026",
      stipendOrGrant: "Direct Buyer-Seller Meets + Packaging Subsidy",
      description: "Empowers Varanasi Silk artisans to connect directly with luxury boutique buyers across Europe and Japan.",
      eligibility: ["Varanasi Handloom Weavers", "Ready Stock with GI Tag"],
      applicationStatus: "Open",
    ),
    Opportunity(
      id: "OPP-04",
      title: "SEWA Artisan Digital Empowerment Grant",
      organization: "Self-Employed Women's Association (SEWA)",
      type: OpportunityType.ngoGrant,
      deadline: "October 30, 2026",
      stipendOrGrant: "₹25,000 Micro-Grant for Raw Materials & Smartphone",
      description: "Targeted support for female rural artisans to purchase high-quality organic yarn and digital inventory tools.",
      eligibility: ["Women Artisans", "Household income < ₹3 LPA"],
      applicationStatus: "Open",
    ),
  ];
}
