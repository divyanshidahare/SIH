# कलाMITRA
> **"Your AI Partner for Every Craft"**

*Current Version: Frontend Prototype*

---

## 🌟 Overview
**कलाMITRA** is an AI-powered virtual business assistant designed exclusively for **Artisans, Weavers, Handicraft Makers, and Micro-Entrepreneurs**. 

Physical exhibitions and trade fairs provide only temporary market exposure. कलाMITRA gives marginalized craftspeople year-round digital opportunities without requiring complex tech skills.

---

## 🎯 Important Project Scope
- **Artisan-Only Application**: कलाMITRA is strictly built for craftspeople. There is NO consumer/customer shopping side, NO customer dashboards, and NO shopper navigation.
- **Craft Focus**: The app focuses 100% on helping artisans digitize, manage, improve, and grow their craft business.

---

## 💡 Problem Statement
Many traditional artisans face major hurdles entering the digital economy:
1. **Low Digital Literacy**: Intimidating complex menus, tiny buttons, and confusing terminology.
2. **Language Barriers**: Most platforms require English fluency; artisans speak Hindi or regional languages.
3. **Product Photography**: Unflattering workshop lighting and background clutter reduce sales value.
4. **Cataloging & Descriptions**: Difficulty articulating provenance, GI tagging, and craft history.
5. **Underpricing & Exploitation**: Middlemen exploit craftspeople because artisans lack cost breakdown formulas.
6. **Isolated Markets**: Lack of year-round direct access to verified B2B buyers, NGOs, and Government schemes (PM Vishwakarma, ODOP).

---

## 🛠️ The Solution: कलाMITRA Features

### 1. Simple, High-Contrast Artisan Design
- Official brand colors: Primary White (`#FFFFFF`) with Warm Amber/Gold accent (`#B45309`) and charcoal typography.
- Prominent `< Back` navigation on every secondary screen so low-literacy artisans never get lost.
- **Easy Mode (Accessibility)**: Dynamic global toggle that scales icons by 145%, enlarges font sizes, expands touch areas, and strengthens borders for poor eyesight.

### 2. Streamlined 7-Step AI Product Studio
- **Step 1: Product Photo**: Capture via camera or gallery.
- **Step 2: AI Photo Studio**: Simulated automated background removal and warm studio lighting.
- **Step 3: Describe Product**: Large **Tap and Speak** microphone button for hands-free voice description.
- **Step 4: AI Auto-Cataloging**: Automatically writes bilingual product titles (English + Hindi), rich provenance descriptions, and SEO tags.
- **Step 5: Smart Pricing**: Calculates raw material cost + artisan hours at fair wage rates + 35% margin to prevent underpricing.
- **Step 6: Catalog Preview**: Clean, structured preview ready for institutional buyers.
- **Step 7: Save & Publish**: Real-time addition to the artisan's live digital catalog with instant WhatsApp sharing.

### 3. Four Large Home Dashboard Actions
- 📤 **Upload Product**: Direct entry into the 7-step AI cataloging studio.
- 🛒 **New Orders**: Manage B2B orders with New, In Progress, and Completed states.
- 💬 **Ask Help**: 24/7 AI craft advisor for photography tips, fair pricing, and scheme guidelines.
- 📦 **Inventory**: Quick stock tracker with instant `+` and `-` unit adjustment buttons.

### 4. Supporting Ecosystem Screens
- **My Digital Catalog**: Interactive catalog with category filters, search, and GI-tagging indicators.
- **Government & Market Support**: Curated verified schemes (PM Vishwakarma, ODOP, Surajkund Crafts Mela, SEWA).
- **Artisan Collaboration Hub**: Connect with fellow weavers, NIFT textile mentors, NGOs, and bulk B2B buyers.
- **My Growth**: Visual progress tracker celebrating products digitized, artisan tiers, and next milestones.
- **Profile & Settings**: Artisan details, notification settings, font scaling, and Easy Mode controller.

---

## 🧭 Main User Flow
```
# Splash Screen (Clean White #FFFFFF & Accent #B45309)
    ↓
# Onboarding (4 Inspiring Artisan Screens)
    ↓
# Language Selection (Hindi, English, Regional Dialects)
    *(Comes BEFORE Login during initial setup)*
    ↓
# Login / Sign Up (Verified Artisan Account - No Guest Access)
    ↓
# कलाMITRA Artisan Home Dashboard
```

> **Note on Language Routing Logic:**
> When accessed from Onboarding, selecting a language navigates to Login. When accessed from Profile/Settings, it returns directly to Settings without re-authenticating (`isFromSettings = true`).

---

## 🏗️ Flutter Project Architecture
```
lib/
├── main.dart                      # Flutter app entry point & system UI config
├── app.dart                       # MaterialApp root with theme & accessibility
├── state/
│   └── easy_mode_state.dart       # Global EasyModeController (icons & text scaling)
├── theme/
│   ├── app_colors.dart            # Official #FFFFFF & #B45309 color tokens
│   └── app_theme.dart             # Material 3 ThemeData with high-contrast inputs
├── models/
│   ├── product_model.dart         # Product schema with bilingual titles & cost breakdown
│   ├── order_model.dart           # B2B Order schema with OrderStatus enum
│   └── opportunity_model.dart     # Govt scheme & craft fair opportunity schema
├── data/
│   └── dummy_data.dart            # Realistic Indian handicrafts, orders & schemes
├── widgets/
│   ├── simple_app_bar.dart        # Standardized prominent "< Back" navigation AppBar
│   ├── primary_action_card.dart   # Four large home action cards with dynamic scaling
│   └── custom_button.dart         # High-touch accessible buttons
└── screens/
    ├── splash/                    # Animated minimal artisan logo
    ├── onboarding/                # 4-step artisan onboarding carousel
    ├── language/                  # Large language cards with dual-route logic
    ├── auth/                      # Mobile/Email login without guest option
    ├── home/                      # Dashboard with 4 primary cards & bottom nav
    ├── product/                   # 7-step AI Product Studio workflow
    ├── catalog/                   # Filterable digital catalog with search
    ├── inventory/                 # Stock summary & rapid +/- adjusters
    ├── orders/                    # B2B orders with New/Pending/Completed tabs
    ├── help/                      # AI Advisor chat with quick-prompt pills
    ├── opportunities/             # Government schemes & craft fair applications
    ├── collaboration/             # Artisan guild & NIFT mentor hub
    ├── growth/                    # Milestone tracker & catalog progress
    └── profile/                   # Artisan profile & settings
```

---

## 🚀 How to Run on Flutter
```bash
# Clone the repository
git clone <repo-url>
cd kalamitra

# Get Flutter dependencies
flutter pub get

# Run on connected device or simulator
flutter run
```

---

## 💻 Tech Stack
- **Frontend**: Flutter (Dart 3.x) & React 19 / TypeScript / Vite interactive simulator
- **Design System**: Material 3 adapted with Artisan Accessibility guidelines
- **State Management**: Reactive `ChangeNotifier` / `ValueNotifier` pattern for Easy Mode scaling
- **Icons**: Cupertino & Material Rounded Icons / Lucide React

---

*कलाMITRA — Dedicated to empowering India's traditional craftspeople, weavers, and micro-entrepreneurs.*
