import React from 'react';
import { Home, BookOpen, Plus, Handshake, User } from 'lucide-react';
import { useApp } from '../context/AppContext';

export const BottomNav: React.FC = () => {
  const { activeTab, setActiveTab, navigateTo } = useApp();

  const handleTabClick = (index: number) => {
    if (index === 2) {
      // Direct open AI cataloging workflow
      navigateTo('upload_product');
    } else {
      setActiveTab(index);
      if (index === 0) navigateTo('home');
      else if (index === 1) navigateTo('catalog');
      else if (index === 3) navigateTo('opportunities');
      else if (index === 4) navigateTo('profile');
    }
  };

  return (
    <nav className="fixed bottom-0 left-0 right-0 max-w-md mx-auto bg-white border-t border-gray-100 flex items-center justify-around z-30 shadow-md transition-all h-20 sm:h-22 px-4 sm:px-8">
      {/* Home */}
      <button
        type="button"
        onClick={() => handleTabClick(0)}
        className={`flex flex-col items-center justify-center gap-1 cursor-pointer transition-all ${
          activeTab === 0
            ? 'text-[#B45309]'
            : 'text-gray-900 opacity-40 hover:opacity-100'
        }`}
      >
        <Home size={22} className={activeTab === 0 ? 'stroke-[2.5]' : 'stroke-[2]'} />
        <span className="font-bold tracking-wider uppercase text-[10px]">
          Home
        </span>
      </button>

      {/* Catalog */}
      <button
        type="button"
        onClick={() => handleTabClick(1)}
        className={`flex flex-col items-center justify-center gap-1 cursor-pointer transition-all ${
          activeTab === 1
            ? 'text-[#B45309]'
            : 'text-gray-900 opacity-40 hover:opacity-100'
        }`}
      >
        <BookOpen size={22} className={activeTab === 1 ? 'stroke-[2.5]' : 'stroke-[2]'} />
        <span className="font-bold tracking-wider uppercase text-[10px]">
          Catalog
        </span>
      </button>

      {/* Primary Upload Floating Action matching Natural Tones design */}
      <button
        type="button"
        onClick={() => handleTabClick(2)}
        className="-mt-10 sm:-mt-12 bg-[#B45309] p-3.5 sm:p-4 rounded-full shadow-2xl border-4 border-white cursor-pointer hover:bg-[#92400E] active:scale-95 transition-all text-white flex items-center justify-center group"
        title="Upload & Digitize Craft"
      >
        <Plus size={26} className="text-white stroke-[3] group-hover:rotate-90 transition-transform duration-200" />
      </button>

      {/* Opportunities */}
      <button
        type="button"
        onClick={() => handleTabClick(3)}
        className={`flex flex-col items-center justify-center gap-1 cursor-pointer transition-all ${
          activeTab === 3
            ? 'text-[#B45309]'
            : 'text-gray-900 opacity-40 hover:opacity-100'
        }`}
      >
        <Handshake size={22} className={activeTab === 3 ? 'stroke-[2.5]' : 'stroke-[2]'} />
        <span className="font-bold tracking-wider uppercase text-[10px]">
          Govt & B2B
        </span>
      </button>

      {/* Profile */}
      <button
        type="button"
        onClick={() => handleTabClick(4)}
        className={`flex flex-col items-center justify-center gap-1 cursor-pointer transition-all ${
          activeTab === 4
            ? 'text-[#B45309]'
            : 'text-gray-900 opacity-40 hover:opacity-100'
        }`}
      >
        <User size={22} className={activeTab === 4 ? 'stroke-[2.5]' : 'stroke-[2]'} />
        <span className="font-bold tracking-wider uppercase text-[10px]">
          Profile
        </span>
      </button>
    </nav>
  );
};
