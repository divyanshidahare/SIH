import React, { useEffect } from 'react';
import { Palette, Sparkles } from 'lucide-react';
import { useApp } from '../../context/AppContext';

export const SplashScreen: React.FC = () => {
  const { navigateTo } = useApp();

  useEffect(() => {
    const timer = setTimeout(() => {
      navigateTo('onboarding');
    }, 2200);
    return () => clearTimeout(timer);
  }, [navigateTo]);

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col items-center justify-center p-6 text-center animate-fade-in select-none font-sans">
      {/* Minimal Artisan Emblem with Natural Tones */}
      <div className="relative mb-6">
        <div className="w-28 h-28 rounded-full bg-[#B45309]/10 border-2 border-[#B45309] flex items-center justify-center shadow-lg shadow-[#B45309]/20">
          <Palette className="w-12 h-12 text-[#B45309]" />
        </div>
        <div className="absolute -top-1 -right-1 w-7 h-7 bg-[#B45309] rounded-full flex items-center justify-center shadow-sm">
          <Sparkles className="w-4 h-4 text-white" />
        </div>
      </div>

      {/* Brand Title */}
      <h1 className="text-4xl font-bold tracking-widest text-gray-900 mb-2">
        कलाMITRA
      </h1>

      {/* Tagline */}
      <div className="bg-[#B45309]/10 border border-[#B45309]/30 rounded-full px-5 py-1.5 mb-10">
        <p className="text-sm font-semibold text-[#B45309]">
          Your AI Partner for Every Craft
        </p>
      </div>

      {/* Artisan Category Badges */}
      <p className="text-xs uppercase tracking-widest text-gray-400 font-semibold mb-8">
        Built for Artisans • Weavers • Handicrafts
      </p>

      {/* Loading Spinner */}
      <div className="w-6 h-6 border-2 border-[#B45309] border-t-transparent rounded-full animate-spin" />
    </div>
  );
};
