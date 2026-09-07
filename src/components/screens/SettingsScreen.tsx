import React, { useState } from 'react';
import {
  Globe,
  Bell,
  Type,
  HelpCircle,
  ShieldCheck,
  ChevronRight,
  User,
  Sliders,
} from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';

export const SettingsScreen: React.FC = () => {
  const { selectedLanguage, navigateTo, showToast, artisanProfile } = useApp();
  const [notifications, setNotifications] = useState(true);
  const [fontScale, setFontScale] = useState(1);

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-16 font-sans text-gray-900">
      <AppBar title="Settings & Preferences" />

      <div className="p-4 sm:p-6 space-y-4 max-w-2xl mx-auto">
        {/* Profile Card Shortcut */}
        <div
          onClick={() => navigateTo('profile_setup')}
          className="bg-white border border-gray-100 hover:border-[#B45309]/40 rounded-[28px] p-5 shadow-xs flex items-center justify-between cursor-pointer transition-all active:scale-98"
        >
          <div className="flex items-center gap-3.5">
            <div className="p-3 rounded-2xl bg-[#B45309]/15 text-[#B45309]">
              <User size={22} />
            </div>
            <div>
              <h3 className="font-bold text-gray-900 text-base">
                {artisanProfile.name}
              </h3>
              <p className="text-xs text-gray-500 font-medium">
                Edit profile details, DOB, address & craft
              </p>
            </div>
          </div>
          <span className="text-xs font-bold text-[#B45309] flex items-center gap-1">
            Edit <ChevronRight size={14} />
          </span>
        </div>

        {/* Preferences Section */}
        <div className="bg-white border border-gray-100 rounded-[28px] p-5 shadow-xs space-y-4">
          <p className="text-xs font-bold uppercase tracking-wider text-gray-400">App Preferences</p>

          {/* Language Item */}
          <button
            onClick={() => navigateTo('language', true)}
            className="w-full flex items-center justify-between py-2 hover:bg-gray-50 rounded-2xl px-2 text-left transition-all"
          >
            <div className="flex items-center gap-3.5">
              <div className="p-2 rounded-xl bg-gray-100 text-gray-700">
                <Globe size={18} />
              </div>
              <div>
                <p className="text-sm font-bold text-gray-900">App Language (भाषा)</p>
                <p className="text-xs text-gray-500 font-medium">Currently: {selectedLanguage}</p>
              </div>
            </div>
            <ChevronRight size={18} className="text-gray-400" />
          </button>

          {/* Notifications Toggle */}
          <div className="flex items-center justify-between py-2 px-2 border-t border-gray-50">
            <div className="flex items-center gap-3.5">
              <div className="p-2 rounded-xl bg-gray-100 text-gray-700">
                <Bell size={18} />
              </div>
              <div>
                <p className="text-sm font-bold text-gray-900">Order & Scheme Alerts</p>
                <p className="text-xs text-gray-500 font-medium">SMS & notification reminders</p>
              </div>
            </div>
            <button
              onClick={() => {
                setNotifications(!notifications);
                showToast(notifications ? "Notifications silenced" : "Notifications enabled");
              }}
              className={`w-12 h-7 rounded-full p-1 transition-colors ${
                notifications ? 'bg-[#B45309]' : 'bg-gray-200'
              }`}
            >
              <div
                className={`w-5 h-5 rounded-full bg-white shadow-md transform transition-transform ${
                  notifications ? 'translate-x-5' : 'translate-x-0'
                }`}
              />
            </button>
          </div>

          {/* Font Scaling Slider */}
          <div className="py-2 px-2 border-t border-gray-50 space-y-2">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3.5">
                <div className="p-2 rounded-xl bg-gray-100 text-gray-700">
                  <Type size={18} />
                </div>
                <p className="text-sm font-bold text-gray-900">Text Size Preference</p>
              </div>
              <span className="text-xs font-bold text-[#B45309]">
                {fontScale === 1 ? 'Standard' : fontScale === 2 ? 'Comfortable' : 'Large'}
              </span>
            </div>
            <input
              type="range"
              min="1"
              max="3"
              step="1"
              value={fontScale}
              onChange={(e) => setFontScale(Number(e.target.value))}
              className="w-full accent-[#B45309] cursor-pointer"
            />
          </div>
        </div>

        {/* Support & Legal Section */}
        <div className="bg-white border border-gray-100 rounded-[28px] p-5 shadow-xs space-y-4">
          <p className="text-xs font-bold uppercase tracking-wider text-gray-400">Support & Security</p>

          <button
            onClick={() => navigateTo('help')}
            className="w-full flex items-center justify-between py-2 hover:bg-gray-50 rounded-2xl px-2 text-left transition-all"
          >
            <div className="flex items-center gap-3.5">
              <div className="p-2 rounded-xl bg-gray-100 text-gray-700">
                <HelpCircle size={18} />
              </div>
              <div>
                <p className="text-sm font-bold text-gray-900">Helpline & AI Artisan Support</p>
                <p className="text-xs text-gray-500 font-medium">Toll-free voice assistance & guidance</p>
              </div>
            </div>
            <ChevronRight size={18} className="text-gray-400" />
          </button>

          <button
            onClick={() => showToast("Artisan IP protection & Data sovereignty verified.")}
            className="w-full flex items-center justify-between py-2 px-2 border-t border-gray-50 hover:bg-gray-50 rounded-2xl text-left transition-all"
          >
            <div className="flex items-center gap-3.5">
              <div className="p-2 rounded-xl bg-gray-100 text-gray-700">
                <ShieldCheck size={18} />
              </div>
              <div>
                <p className="text-sm font-bold text-gray-900">Artisan Design IP Protection</p>
                <p className="text-xs text-gray-500 font-medium">Your craft motifs remain 100% yours</p>
              </div>
            </div>
            <ChevronRight size={18} className="text-gray-400" />
          </button>
        </div>
      </div>
    </div>
  );
};
