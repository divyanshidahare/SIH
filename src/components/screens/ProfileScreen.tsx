import React from 'react';
import {
  Settings,
  ShoppingBag,
  TrendingUp,
  Users,
  LogOut,
  ChevronRight,
} from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';
import { BottomNav } from '../BottomNav';

export const ProfileScreen: React.FC<{ isRootTab?: boolean }> = ({ isRootTab = false }) => {
  const { navigateTo } = useApp();

  const menuItems = [
    {
      icon: ShoppingBag,
      title: "Orders & Shipments",
      desc: "Wholesale B2B requests and exhibition consignments",
      action: () => navigateTo('orders'),
    },
    {
      icon: TrendingUp,
      title: "My Craft Growth & Analytics",
      desc: "Track views, revenue & artisan tiers",
      action: () => navigateTo('growth'),
    },
    {
      icon: Users,
      title: "Artisan Collaboration Hub",
      desc: "Connect with master weavers, NIFT designers & NGOs",
      action: () => navigateTo('collaboration'),
    },
    {
      icon: Settings,
      title: "Settings & Preferences",
      desc: "Language, voice assist & notifications",
      action: () => navigateTo('settings'),
    },
  ];

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-24 font-sans text-gray-900">
      <AppBar
        title="Artisan Profile"
        showBackButton={!isRootTab}
        actions={
          <button
            onClick={() => navigateTo('settings')}
            className="p-2 rounded-xl bg-white border border-gray-100 text-gray-800 shadow-xs hover:border-[#B45309]/30 transition-all cursor-pointer"
            title="Settings"
          >
            <Settings size={18} />
          </button>
        }
      />

      <div className="p-4 sm:p-6 space-y-4 max-w-2xl mx-auto">
        {/* Profile Menu Links */}
        <div className="bg-white border border-gray-100 rounded-[28px] p-2.5 shadow-xs divide-y divide-gray-50">
          {menuItems.map((item, idx) => (
            <button
              key={idx}
              onClick={item.action}
              className="w-full flex items-center justify-between hover:bg-gray-50/80 rounded-2xl transition-all text-left p-4 cursor-pointer"
            >
              <div className="flex items-center gap-3.5">
                <div className="p-2.5 rounded-xl bg-[#FEF3C7] text-[#B45309]">
                  <item.icon size={18} />
                </div>
                <div>
                  <h3 className="font-bold text-gray-900 text-sm">
                    {item.title}
                  </h3>
                  <p className="text-xs text-gray-500 font-normal mt-0.5">{item.desc}</p>
                </div>
              </div>
              <ChevronRight size={18} className="text-gray-400" />
            </button>
          ))}
        </div>

        {/* Log out */}
        <button
          onClick={() => navigateTo('login')}
          className="w-full bg-white border border-red-200 text-red-600 hover:bg-red-50 font-bold py-3.5 rounded-full text-xs flex items-center justify-center gap-2 transition-all shadow-xs cursor-pointer"
        >
          <LogOut size={16} />
          <span>Log Out of कलाMITRA</span>
        </button>
      </div>

      {isRootTab && <BottomNav />}
    </div>
  );
};
