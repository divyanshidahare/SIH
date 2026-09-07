import React, { useState } from 'react';
import { Sparkles, Camera, Package, Handshake, ArrowRight } from 'lucide-react';
import { useApp } from '../../context/AppContext';

export const OnboardingScreen: React.FC = () => {
  const [currentPage, setCurrentPage] = useState(0);
  const { navigateTo } = useApp();

  const pages = [
    {
      icon: Sparkles,
      title: "Your Craft Deserves to Grow",
      description: "Turn your handmade products into a professional digital business.",
      badge: "🏺 Handcrafted with Pride",
    },
    {
      icon: Camera,
      title: "AI Makes Things Easier",
      description: "Improve photos, create catalogs, and get smart suggestions.",
      badge: "✨ Smart AI Artisan Studio",
    },
    {
      icon: Package,
      title: "Manage Your Craft Business",
      description: "Track products, inventory, orders, and opportunities in one place.",
      badge: "📦 Simple Craft Books",
    },
    {
      icon: Handshake,
      title: "Your Digital Craft Partner",
      description: "कलाMITRA helps you take the next step with confidence.",
      badge: "🤝 Verified B2B Access",
    },
  ];

  const handleFinish = () => {
    // Crucial flow mandate: Language Selection MUST come before Login in initial setup
    navigateTo('language', false);
  };

  const handleNext = () => {
    if (currentPage < pages.length - 1) {
      setCurrentPage((prev) => prev + 1);
    } else {
      handleFinish();
    }
  };

  const current = pages[currentPage];
  const IconComponent = current.icon;
  const isLast = currentPage === pages.length - 1;

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col justify-between p-6 font-sans">
      {/* Top Skip button */}
      <div className="flex justify-end pt-2">
        {!isLast ? (
          <button
            onClick={handleFinish}
            className="text-gray-400 hover:text-gray-900 text-sm font-semibold px-3 py-1 rounded-full transition-colors"
          >
            Skip
          </button>
        ) : (
          <div className="h-8" />
        )}
      </div>

      {/* Center Carousel Content */}
      <div className="flex flex-col items-center text-center my-auto px-2">
        {/* Large Artisan Illustration Icon */}
        <div className="rounded-full bg-[#B45309]/10 border-2 border-[#B45309] flex items-center justify-center mb-6 transition-all shadow-sm w-28 h-28">
          <IconComponent className="text-[#B45309] w-14 h-14" />
        </div>

        {/* Craft Badge */}
        <div className="bg-[#B45309]/10 border border-[#B45309]/30 rounded-full px-4 py-1 mb-5">
          <span className="text-xs font-semibold text-[#B45309]">{current.badge}</span>
        </div>

        {/* Title */}
        <h2 className="font-bold text-gray-900 tracking-tight mb-3 text-2xl">
          {current.title}
        </h2>

        {/* Description */}
        <p className="text-gray-500 font-normal max-w-xs text-base">
          {current.description}
        </p>
      </div>

      {/* Bottom Controls */}
      <div className="w-full space-y-6 pb-4">
        {/* Page Indicators */}
        <div className="flex justify-center items-center gap-2">
          {pages.map((_, index) => (
            <div
              key={index}
              className={`h-2 rounded-full transition-all duration-300 ${
                currentPage === index ? 'w-8 bg-[#B45309]' : 'w-2 bg-gray-200'
              }`}
            />
          ))}
        </div>

        {/* Action Button */}
        <button
          onClick={handleNext}
          className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold rounded-full flex items-center justify-center gap-2 shadow-sm active:scale-98 transition-all py-4 text-base min-h-[48px]"
        >
          <span>{isLast ? "Get Started" : "Next"}</span>
          <ArrowRight size={20} className="stroke-[2.5]" />
        </button>
      </div>
    </div>
  );
};
