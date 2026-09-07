import React from 'react';
import { Award, Eye, IndianRupee, Plus, TrendingUp, Sparkles } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';

export const GrowthScreen: React.FC = () => {
  const { products, navigateTo } = useApp();

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-16 font-sans text-gray-900">
      <AppBar title="My Craft Growth & Analytics" />

      <div className="p-4 sm:p-6 space-y-4 max-w-2xl mx-auto">
        {/* Hero Progress Card */}
        <div className="bg-white border-2 border-[#B45309]/30 rounded-[28px] p-6 space-y-4 shadow-xs">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold uppercase tracking-wider text-gray-500">
              Catalog Digitization
            </span>
            <span className="bg-[#B45309]/15 text-[#B45309] text-xs font-bold px-3 py-1 rounded-full flex items-center gap-1.5">
              <Award size={14} /> Silver Artisan Tier
            </span>
          </div>

          <div className="flex items-baseline gap-2">
            <span className="text-3xl sm:text-4xl font-bold text-gray-900">{products.length}</span>
            <span className="text-sm text-gray-500 font-medium">/ 10 Products Digitized</span>
          </div>

          {/* Progress Bar */}
          <div className="w-full bg-gray-100 h-2.5 rounded-full overflow-hidden">
            <div
              className="bg-[#B45309] h-full rounded-full transition-all duration-500"
              style={{ width: `${Math.min(100, (products.length / 10) * 100)}%` }}
            />
          </div>

          <p className="text-xs sm:text-sm text-gray-600 font-normal leading-relaxed">
            Digitize {Math.max(0, 10 - products.length)} more products to unlock the National Handloom & Handicraft Export Directory.
          </p>
        </div>

        {/* Business Metrics Grid */}
        <div className="grid grid-cols-2 gap-3 sm:gap-4">
          <div className="bg-white p-5 rounded-[24px] border border-gray-100 shadow-xs">
            <div className="flex items-center gap-1.5 text-gray-400 text-xs font-medium mb-1.5">
              <Eye size={15} /> Catalog Views
            </div>
            <p className="text-2xl sm:text-3xl font-bold text-gray-900">342</p>
            <p className="text-[11px] text-green-600 font-semibold mt-1 flex items-center gap-1">
              <TrendingUp size={12} /> +18% this month
            </p>
          </div>

          <div className="bg-white p-5 rounded-[24px] border border-gray-100 shadow-xs">
            <div className="flex items-center gap-1.5 text-gray-400 text-xs font-medium mb-1.5">
              <IndianRupee size={15} /> Gross Revenue
            </div>
            <p className="text-2xl sm:text-3xl font-bold text-gray-900">₹48,800</p>
            <p className="text-[11px] text-green-600 font-semibold mt-1">3 Completed B2B Orders</p>
          </div>
        </div>

        {/* Performance Insights */}
        <div className="bg-white border border-gray-100 rounded-[28px] p-5 shadow-xs space-y-3">
          <div className="flex items-center gap-2">
            <div className="p-2 rounded-xl bg-[#B45309]/15 text-[#B45309]">
              <Sparkles size={18} />
            </div>
            <h3 className="font-bold text-gray-900 text-base">
              Artisan Performance Insights
            </h3>
          </div>
          <div className="space-y-2 text-xs text-gray-600 leading-relaxed">
            <p className="p-3 bg-gray-50 rounded-2xl border border-gray-100">
              • Your Banarasi Silk collection received high inquiry rates from wholesale boutique buyers in New Delhi and Bangalore.
            </p>
            <p className="p-3 bg-gray-50 rounded-2xl border border-gray-100">
              • Products with detailed fair pricing calculations (materials + artisan labor) sell 40% faster on verified B2B marketplaces.
            </p>
          </div>
        </div>

        {/* Action Button */}
        <button
          onClick={() => navigateTo('upload_product')}
          className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold rounded-full flex items-center justify-center gap-2 shadow-sm transition-all active:scale-98 py-4 text-sm min-h-[48px]"
        >
          <Plus size={18} className="stroke-[3]" />
          <span>Digitize Another Craft Product</span>
        </button>
      </div>
    </div>
  );
};
