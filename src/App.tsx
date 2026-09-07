/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import React, { useState } from 'react';
import { AppProvider, useApp } from './context/AppContext';
import { SplashScreen } from './components/screens/SplashScreen';
import { OnboardingScreen } from './components/screens/OnboardingScreen';
import { LanguageScreen } from './components/screens/LanguageScreen';
import { LoginScreen } from './components/screens/LoginScreen';
import { HomeScreen } from './components/screens/HomeScreen';
import { UploadProductFlowScreen } from './components/screens/UploadProductFlowScreen';
import { CatalogScreen } from './components/screens/CatalogScreen';
import { InventoryScreen } from './components/screens/InventoryScreen';
import { OrdersScreen } from './components/screens/OrdersScreen';
import { HelpScreen } from './components/screens/HelpScreen';
import { OpportunitiesScreen } from './components/screens/OpportunitiesScreen';
import { CollaborationScreen } from './components/screens/CollaborationScreen';
import { GrowthScreen } from './components/screens/GrowthScreen';
import { ProfileScreen } from './components/screens/ProfileScreen';
import { ProfileSetupScreen } from './components/screens/ProfileSetupScreen';
import { SettingsScreen } from './components/screens/SettingsScreen';
import { FlutterCodeViewer } from './components/FlutterCodeViewer';
import { Code2, Smartphone, Sparkles } from 'lucide-react';
import { ScreenName } from './types';

const MainNavigator: React.FC = () => {
  const { currentScreen, toastMessage } = useApp();

  const renderScreen = () => {
    switch (currentScreen) {
      case 'splash':
        return <SplashScreen />;
      case 'onboarding':
        return <OnboardingScreen />;
      case 'language':
        return <LanguageScreen />;
      case 'login':
        return <LoginScreen />;
      case 'profile_setup':
        return <ProfileSetupScreen />;
      case 'home':
        return <HomeScreen />;
      case 'upload_product':
        return <UploadProductFlowScreen />;
      case 'catalog':
        return <CatalogScreen isRootTab={false} />;
      case 'inventory':
        return <InventoryScreen />;
      case 'orders':
        return <OrdersScreen />;
      case 'help':
        return <HelpScreen />;
      case 'opportunities':
        return <OpportunitiesScreen isRootTab={false} />;
      case 'collaboration':
        return <CollaborationScreen />;
      case 'growth':
        return <GrowthScreen />;
      case 'profile':
        return <ProfileScreen isRootTab={false} />;
      case 'settings':
        return <SettingsScreen />;
      default:
        return <HomeScreen />;
    }
  };

  return (
    <div className="relative w-full h-full flex flex-col">
      {/* Active Screen */}
      <div className="flex-1 w-full overflow-x-hidden">{renderScreen()}</div>

      {/* Floating Global SnackBar / Toast */}
      {toastMessage && (
        <div className="fixed bottom-20 left-1/2 -translate-x-1/2 z-50 bg-[#1F2937] text-white text-xs font-bold px-4 py-2.5 rounded-full shadow-xl flex items-center gap-2 border border-gray-700 animate-bounce">
          <Sparkles size={14} className="text-[#B45309]" />
          <span>{toastMessage}</span>
        </div>
      )}
    </div>
  );
};

export default function App() {
  const [showCodeModal, setShowCodeModal] = useState(false);

  return (
    <AppProvider>
      <AppShell
        showCodeModal={showCodeModal}
        setShowCodeModal={setShowCodeModal}
      />
    </AppProvider>
  );
}

const AppShell: React.FC<{
  showCodeModal: boolean;
  setShowCodeModal: (val: boolean) => void;
}> = ({ showCodeModal, setShowCodeModal }) => {
  const { currentScreen, navigateTo } = useApp();

  const screenOptions: Array<{ id: ScreenName; label: string }> = [
    { id: 'splash', label: '1. Splash Screen' },
    { id: 'onboarding', label: '2. Onboarding (4 Steps)' },
    { id: 'language', label: '3. Language Selection (23 Langs)' },
    { id: 'login', label: '4. Login / Sign In' },
    { id: 'profile_setup', label: '4b. Profile Details Setup' },
    { id: 'home', label: '5. Home Dashboard (4 Cards)' },
    { id: 'upload_product', label: '6. AI Upload Product (Auto Studio)' },
    { id: 'catalog', label: '7. Digital Catalog' },
    { id: 'inventory', label: '8. Inventory & Stock' },
    { id: 'orders', label: '9. B2B Orders' },
    { id: 'help', label: '10. Ask Help (AI Advisor)' },
    { id: 'opportunities', label: '11. Government Schemes' },
    { id: 'collaboration', label: '12. Collaboration Hub' },
    { id: 'growth', label: '13. My Growth & Analytics' },
    { id: 'profile', label: '14. Profile' },
    { id: 'settings', label: '15. Settings & Preferences' },
  ];

  return (
    <div className="min-h-screen bg-[#F5F5F3] flex flex-col items-center justify-start text-gray-900 font-sans">
      {/* Top Prototype Controls Bar */}
      <nav className="w-full bg-[#1F2937] text-white px-4 py-2.5 flex flex-wrap items-center justify-between gap-3 shadow-md z-40">
        <div className="flex items-center gap-2.5">
          <div className="w-7 h-7 rounded-lg bg-[#B45309] flex items-center justify-center font-black text-white text-xs">
            KM
          </div>
          <div>
            <span className="font-black text-sm tracking-wider">कलाMITRA</span>
            <span className="text-[10px] text-gray-300 ml-2 hidden sm:inline font-semibold">
              Flutter Artisan Frontend Prototype
            </span>
          </div>
        </div>

        <div className="flex items-center gap-2">
          {/* Direct Screen Selector for Testing */}
          <div className="relative">
            <select
              value={currentScreen}
              onChange={(e) => navigateTo(e.target.value as ScreenName)}
              className="bg-gray-800 text-white text-xs font-bold rounded-xl px-3 py-1.5 border border-gray-700 focus:border-[#B45309] outline-none cursor-pointer"
            >
              {screenOptions.map((opt) => (
                <option key={opt.id} value={opt.id}>
                  {opt.label}
                </option>
              ))}
            </select>
          </div>

          {/* View Flutter Source Code Button */}
          <button
            onClick={() => setShowCodeModal(true)}
            className="bg-[#FEF3C7] hover:bg-[#B45309] hover:text-white text-[#B45309] text-xs font-black px-3 py-1.5 rounded-xl flex items-center gap-1.5 transition-all shadow-sm"
          >
            <Code2 size={15} />
            <span>Flutter Code</span>
          </button>
        </div>
      </nav>

      {/* Mobile Device Canvas Simulator */}
      <main className="w-full flex-1 flex items-center justify-center sm:p-6 p-0">
        <div className="w-full max-w-md sm:rounded-[36px] overflow-hidden bg-white shadow-2xl border-0 sm:border-8 sm:border-gray-900 min-h-screen sm:min-h-[844px] flex flex-col relative">
          {/* iOS / Android Camera Notch simulation for realism */}
          <div className="hidden sm:flex justify-center bg-white pt-2 pb-1">
            <div className="w-24 h-4 bg-gray-900 rounded-full flex items-center justify-center">
              <div className="w-2.5 h-2.5 bg-gray-800 rounded-full" />
            </div>
          </div>

          {/* Mobile Screen Body */}
          <div className="flex-1 w-full overflow-y-auto">
            <MainNavigator />
          </div>
        </div>
      </main>

      {/* Interactive Flutter Code Inspector Modal */}
      <FlutterCodeViewer
        isOpen={showCodeModal}
        onClose={() => setShowCodeModal(false)}
      />
    </div>
  );
};
