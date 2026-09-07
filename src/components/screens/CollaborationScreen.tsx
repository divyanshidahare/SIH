import React from 'react';
import { Users, Palette, HeartHandshake, Building2, ArrowRight } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';

export const CollaborationScreen: React.FC = () => {
  const { showToast } = useApp();

  const pillars = [
    {
      icon: Users,
      title: "Master Artisans & Guilds",
      desc: "Connect with 1,200+ fellow weavers and craftspeople across Varanasi, Kutch, and Jaipur. Share raw materials and bulk loom orders.",
      action: "Find Fellow Artisans",
      badge: "450 Active Guilds",
    },
    {
      icon: Palette,
      title: "NIFT Textile Designers",
      desc: "Collaborate with contemporary product and textile designers to blend traditional GI motifs with modern export silhouettes.",
      action: "Request Design Mentorship",
      badge: "180 Verified Mentors",
    },
    {
      icon: HeartHandshake,
      title: "NGOs & Craft Foundations",
      desc: "Partner with organizations like SEWA, Dastkar, and Craftsvilla Foundation for women artisan tool grants and fair pricing.",
      action: "Connect with NGOs",
      badge: "85 Partner Orgs",
    },
    {
      icon: Building2,
      title: "Verified B2B Buyers & Curators",
      desc: "Direct institutional buyers seeking certified ethical handicrafts, museum stores, and boutique hotels.",
      action: "Browse Buyer RFQs",
      badge: "320 Verified Buyers",
    },
  ];

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-16 font-sans">
      <AppBar title="Artisan Collaboration Hub" />

      <div className="p-4 space-y-4 max-w-2xl mx-auto">
        {pillars.map((item, idx) => (
          <div
            key={idx}
            className="bg-white border border-gray-100 hover:border-[#B45309]/30 rounded-[28px] p-5 shadow-xs space-y-3.5 transition-all"
          >
            <div className="flex items-center justify-between">
              <div className="p-3 rounded-2xl bg-[#B45309]/15 text-[#B45309]">
                <item.icon size={22} />
              </div>
              <span className="bg-[#B45309]/10 text-[#B45309] border border-[#B45309]/30 text-[10px] font-bold px-3 py-1 rounded-full">
                {item.badge}
              </span>
            </div>

            <div>
              <h3 className="font-bold text-gray-900 text-base">
                {item.title}
              </h3>
              <p className="text-xs text-gray-500 font-normal leading-relaxed mt-1">
                {item.desc}
              </p>
            </div>

            <button
              onClick={() => showToast(`Opened ${item.action} directory (Demo)`)}
              className="w-full bg-white hover:bg-[#B45309]/10 border border-[#B45309] text-gray-900 font-bold rounded-full flex items-center justify-center gap-2 transition-all active:scale-98 shadow-xs py-2.5 text-xs cursor-pointer"
            >
              <span>{item.action}</span>
              <ArrowRight size={14} />
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};
