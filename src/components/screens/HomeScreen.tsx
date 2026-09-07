import React from 'react';
import {
  UploadCloud,
  ShoppingBag,
  MessageSquare,
  Package,
  Eye,
  TrendingUp,
  Sparkles,
} from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { BottomNav } from '../BottomNav';

export const HomeScreen: React.FC = () => {
  const {
    navigateTo,
    showToast,
    orders,
    products,
    setActiveTab,
    artisanProfile,
  } = useApp();

  const pendingOrdersCount = orders.filter((o) => o.status === 'new').length;
  const firstName = artisanProfile.name ? artisanProfile.name.split(' ')[0] : 'Priya';

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-28 select-none font-sans">
      {/* Top Header matching Natural Tones theme */}
      <header className="px-5 py-5 sm:px-10 sm:py-8 flex justify-between items-center border-b border-gray-100 bg-white sticky top-0 z-20">
        <div className="flex flex-col">
          <h1 className="font-bold text-gray-900 tracking-tight text-2xl sm:text-4xl">
            Namaste, {firstName} 👋
          </h1>
          <p className="text-sm sm:text-base text-gray-500 font-medium mt-1">
            {artisanProfile.specialisation || "Let's grow your craft business today."}
          </p>
        </div>

        <div className="flex items-center gap-2.5 sm:gap-4">
          {/* Profile Button */}
          <button
            type="button"
            onClick={() => {
              setActiveTab(4);
              navigateTo('profile');
            }}
            className="w-10 h-10 sm:w-12 sm:h-12 bg-[#B45309] rounded-full flex items-center justify-center text-white shadow-md text-base sm:text-lg font-bold cursor-pointer active:scale-95 transition-all overflow-hidden border-2 border-white hover:ring-2 hover:ring-[#B45309]/50"
            title="Profile"
          >
            {firstName.charAt(0)}
          </button>
        </div>
      </header>

      {/* Main Content */}
      <main className="p-5 sm:p-10 flex flex-col justify-center space-y-6 sm:space-y-8 max-w-5xl mx-auto w-full">
        {/* Section Header with Natural Tones Decorative Gold Bar */}
        <div className="text-center">
          <h2 className="text-lg sm:text-xl font-semibold text-gray-800 uppercase tracking-widest">
            What would you like to do?
          </h2>
          <div className="w-16 sm:w-20 h-1 bg-[#B45309] mx-auto mt-2.5 rounded-full" />
        </div>

        {/* FOUR LARGE PRIMARY ACTION CARDS (2x2 Grid) */}
        <div className="grid grid-cols-2 gap-4 sm:gap-6 w-full">
          {/* PRIMARY ACTION 1: UPLOAD PRODUCT */}
          <div
            onClick={() => navigateTo('upload_product')}
            className="bg-white border-2 border-gray-50 hover:border-[#B45309] rounded-[28px] sm:rounded-[36px] shadow-xs hover:shadow-md flex flex-col items-center text-center transition-all cursor-pointer group active:scale-98 p-5 sm:p-8"
          >
            <div className="bg-[#B45309]/10 rounded-2xl sm:rounded-3xl flex items-center justify-center group-hover:bg-[#B45309]/15 transition-colors w-16 h-16 sm:w-20 sm:h-20 mb-3 sm:mb-5">
              <UploadCloud className="w-8 h-8 sm:w-10 sm:h-10 text-[#B45309]" />
            </div>
            <h3 className="font-bold text-gray-900 mb-1.5 sm:mb-2 leading-tight text-base sm:text-xl">
              Upload Product
            </h3>
            <p className="text-gray-500 leading-relaxed text-xs sm:text-sm">
              AI auto-photo & catalog: snap photo and list automatically
            </p>
          </div>

          {/* PRIMARY ACTION 2: NEW ORDERS */}
          <div
            onClick={() => navigateTo('orders')}
            className="bg-white border-2 border-gray-50 hover:border-[#B45309] rounded-[28px] sm:rounded-[36px] shadow-xs hover:shadow-md flex flex-col items-center text-center transition-all cursor-pointer group active:scale-98 p-5 sm:p-8 relative"
          >
            {pendingOrdersCount > 0 && (
              <span className="absolute top-4 right-4 bg-[#B45309]/15 border border-[#B45309]/30 text-[#B45309] font-bold text-[10px] sm:text-xs px-2.5 py-0.5 rounded-full">
                {pendingOrdersCount} New
              </span>
            )}
            <div className="bg-[#B45309]/10 rounded-2xl sm:rounded-3xl flex items-center justify-center group-hover:bg-[#B45309]/15 transition-colors w-16 h-16 sm:w-20 sm:h-20 mb-3 sm:mb-5">
              <ShoppingBag className="w-8 h-8 sm:w-10 sm:h-10 text-[#B45309]" />
            </div>
            <h3 className="font-bold text-gray-900 mb-1.5 sm:mb-2 leading-tight text-base sm:text-xl">
              New Orders
            </h3>
            <p className="text-gray-500 leading-relaxed text-xs sm:text-sm">
              3 pending wholesale orders from Ahmedabad & Jaipur
            </p>
          </div>

          {/* PRIMARY ACTION 3: ASK HELP */}
          <div
            onClick={() => navigateTo('help')}
            className="bg-white border-2 border-gray-50 hover:border-[#B45309] rounded-[28px] sm:rounded-[36px] shadow-xs hover:shadow-md flex flex-col items-center text-center transition-all cursor-pointer group active:scale-98 p-5 sm:p-8"
          >
            <div className="bg-[#B45309]/10 rounded-2xl sm:rounded-3xl flex items-center justify-center group-hover:bg-[#B45309]/15 transition-colors w-16 h-16 sm:w-20 sm:h-20 mb-3 sm:mb-5">
              <MessageSquare className="w-8 h-8 sm:w-10 sm:h-10 text-[#B45309]" />
            </div>
            <h3 className="font-bold text-gray-900 mb-1.5 sm:mb-2 leading-tight text-base sm:text-xl">
              Ask Help
            </h3>
            <p className="text-gray-500 leading-relaxed text-xs sm:text-sm">
              Chat with your AI partner about fair pricing or materials
            </p>
          </div>

          {/* PRIMARY ACTION 4: INVENTORY */}
          <div
            onClick={() => navigateTo('inventory')}
            className="bg-white border-2 border-gray-50 hover:border-[#B45309] rounded-[28px] sm:rounded-[36px] shadow-xs hover:shadow-md flex flex-col items-center text-center transition-all cursor-pointer group active:scale-98 p-5 sm:p-8"
          >
            <div className="bg-[#B45309]/10 rounded-2xl sm:rounded-3xl flex items-center justify-center group-hover:bg-[#B45309]/15 transition-colors w-16 h-16 sm:w-20 sm:h-20 mb-3 sm:mb-5">
              <Package className="w-8 h-8 sm:w-10 sm:h-10 text-[#B45309]" />
            </div>
            <h3 className="font-bold text-gray-900 mb-1.5 sm:mb-2 leading-tight text-base sm:text-xl">
              Inventory
            </h3>
            <p className="text-gray-500 leading-relaxed text-xs sm:text-sm">
              Track stock levels of your handloom & handicraft items
            </p>
          </div>
        </div>

        {/* Craft Business Status Overview Card */}
        <div className="bg-white border border-gray-100 rounded-[28px] sm:rounded-[32px] p-5 sm:p-6 shadow-xs w-full">
          <div className="flex items-center justify-between mb-3">
            <div>
              <h3 className="font-bold text-gray-900 text-sm sm:text-base">
                Craft Status Overview
              </h3>
              <p className="text-xs text-gray-400 font-medium">
                Varanasi Handloom Cluster
              </p>
            </div>
            <button
              onClick={() => {
                setActiveTab(1);
                navigateTo('catalog');
              }}
              className="text-xs font-bold text-[#B45309] hover:text-[#92400E] transition-colors"
            >
              View Catalog →
            </button>
          </div>

          <div className="grid grid-cols-3 gap-2 sm:gap-3 pt-3 border-t border-gray-100 text-center">
            <div className="p-3 rounded-2xl bg-gray-50/70 border border-gray-100/60">
              <p className="text-[11px] font-semibold text-gray-400">Digitized</p>
              <p className="font-bold text-gray-900 text-sm sm:text-base mt-0.5">{products.length} Items</p>
            </div>
            <div className="p-3 rounded-2xl bg-gray-50/70 border border-gray-100/60">
              <p className="text-[11px] font-semibold text-gray-400">Catalog Views</p>
              <p className="font-bold text-gray-900 text-sm sm:text-base mt-0.5">342</p>
            </div>
            <div className="p-3 rounded-2xl bg-gray-50/70 border border-gray-100/60">
              <p className="text-[11px] font-semibold text-gray-400">Revenue</p>
              <p className="font-bold text-gray-900 text-sm sm:text-base mt-0.5">₹48.8k</p>
            </div>
          </div>
        </div>

        {/* Government Opportunity Spotlight */}
        <div
          onClick={() => {
            setActiveTab(3);
            navigateTo('opportunities');
          }}
          className="bg-white border border-gray-100 hover:border-[#B45309]/50 rounded-[24px] sm:rounded-[32px] p-4 sm:p-5 flex items-center justify-between cursor-pointer shadow-xs hover:shadow-md transition-all w-full"
        >
          <div className="flex items-center gap-3.5">
            <div className="w-10 h-10 sm:w-12 sm:h-12 rounded-2xl bg-[#B45309]/10 flex items-center justify-center text-[#B45309]">
              <Sparkles size={20} />
            </div>
            <div>
              <p className="text-xs sm:text-sm font-bold text-gray-900">PM Vishwakarma Toolkit Voucher</p>
              <p className="text-[11px] sm:text-xs text-gray-500 font-medium">₹15,000 tool subsidy + 5% loan access</p>
            </div>
          </div>
          <span className="text-xs sm:text-sm font-bold text-[#B45309]">Explore →</span>
        </div>
      </main>

      {/* Persistent Bottom Navigation */}
      <BottomNav />
    </div>
  );
};
