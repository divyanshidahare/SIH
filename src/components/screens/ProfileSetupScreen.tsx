import React, { useState } from 'react';
import { User, Calendar, MapPin, Sparkles, Check, ArrowRight, ShieldCheck } from 'lucide-react';
import { useApp } from '../../context/AppContext';

export const ProfileSetupScreen: React.FC = () => {
  const { artisanProfile, updateArtisanProfile, navigateTo, showToast } = useApp();

  const [name, setName] = useState(artisanProfile.name || 'Priya Sharma');
  const [dob, setDob] = useState(artisanProfile.dob || '1988-04-12');
  const [address, setAddress] = useState(
    artisanProfile.address ||
      'House 42, Weavers Colony, Kabir Chaura, Varanasi, Uttar Pradesh - 221001'
  );
  const [specialisation, setSpecialisation] = useState(
    artisanProfile.specialisation ||
      'Master Handloom Weaver & Banarasi Brocade Artisan'
  );

  const CRAFT_SUGGESTIONS = [
    'Handloom Silk Weaving',
    'Terracotta & Clay Pottery',
    'Jaipur Hand Block Printing',
    'Dhokra Lost-Wax Brass Casting',
    'Channapatna Woodcraft & Lacquer Toys',
    'Zardozi & Aari Embroidery',
    'Kashmiri Pashmina & Carpet Weaving',
    'Madhubani & Warli Folk Art',
  ];

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!name.trim()) {
      showToast('Please enter your full name');
      return;
    }
    if (!dob) {
      showToast('Please enter your date of birth');
      return;
    }
    if (!address.trim()) {
      showToast('Please enter your workshop or home address');
      return;
    }
    if (!specialisation.trim()) {
      showToast('Please specify your craft specialisation');
      return;
    }

    updateArtisanProfile({
      name: name.trim(),
      dob,
      address: address.trim(),
      specialisation: specialisation.trim(),
    });

    showToast('Profile details saved! Welcome to your studio.');
    navigateTo('home');
  };

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col justify-between font-sans text-gray-900 pb-12">
      {/* Top Header */}
      <header className="px-6 py-5 border-b border-gray-100 bg-white sticky top-0 z-20">
        <div className="max-w-2xl mx-auto flex items-center justify-between">
          <div>
            <div className="inline-flex items-center gap-1.5 bg-[#B45309]/10 border border-[#B45309]/30 rounded-full px-3 py-1 mb-1.5">
              <Sparkles size={13} className="text-[#B45309]" />
              <span className="text-[11px] font-bold text-[#B45309] uppercase tracking-wider">
                Artisan Onboarding
              </span>
            </div>
            <h1 className="text-xl sm:text-2xl font-bold text-gray-900">
              Artisan Profile Details
            </h1>
            <p className="text-xs sm:text-sm text-gray-500 mt-0.5">
              Please share your basic details for government schemes, GI tag verification, and B2B buyers.
            </p>
          </div>
        </div>
      </header>

      {/* Main Form */}
      <main className="flex-1 p-5 sm:p-8 max-w-2xl mx-auto w-full">
        <form onSubmit={handleSubmit} className="space-y-6 bg-white border border-gray-100 rounded-[28px] p-6 sm:p-8 shadow-xs">
          {/* Full Name */}
          <div>
            <label className="block text-xs font-bold text-gray-700 uppercase tracking-wider mb-2">
              Full Name (पूरा नाम) *
            </label>
            <div className="relative">
              <User
                size={18}
                className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none"
              />
              <input
                type="text"
                required
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="e.g. Priya Sharma"
                className="w-full bg-gray-50/70 border border-gray-200 rounded-2xl pl-11 pr-4 py-3.5 text-sm font-medium text-gray-900 focus:bg-white focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 outline-none transition-all shadow-xs"
              />
            </div>
          </div>

          {/* Date of Birth */}
          <div>
            <label className="block text-xs font-bold text-gray-700 uppercase tracking-wider mb-2">
              Date of Birth (जन्म तिथि) *
            </label>
            <div className="relative">
              <Calendar
                size={18}
                className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none"
              />
              <input
                type="date"
                required
                value={dob}
                onChange={(e) => setDob(e.target.value)}
                className="w-full bg-gray-50/70 border border-gray-200 rounded-2xl pl-11 pr-4 py-3.5 text-sm font-medium text-gray-900 focus:bg-white focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 outline-none transition-all shadow-xs"
              />
            </div>
            <p className="text-[11px] text-gray-400 mt-1">
              Required for MSME PM Vishwakarma and Ministry of Textiles artisan records.
            </p>
          </div>

          {/* Address */}
          <div>
            <label className="block text-xs font-bold text-gray-700 uppercase tracking-wider mb-2">
              Workshop / Residential Address (पता) *
            </label>
            <div className="relative">
              <MapPin
                size={18}
                className="absolute left-4 top-4 text-gray-400 pointer-events-none"
              />
              <textarea
                required
                rows={3}
                value={address}
                onChange={(e) => setAddress(e.target.value)}
                placeholder="House / Workshop number, Village / Street, District, State & Pincode"
                className="w-full bg-gray-50/70 border border-gray-200 rounded-2xl pl-11 pr-4 py-3.5 text-sm font-medium text-gray-900 focus:bg-white focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 outline-none transition-all shadow-xs resize-none"
              />
            </div>
          </div>

          {/* Specialisation */}
          <div>
            <label className="block text-xs font-bold text-gray-700 uppercase tracking-wider mb-2">
              Craft Specialisation (शिल्प विशेषज्ञता) *
            </label>
            <input
              type="text"
              required
              value={specialisation}
              onChange={(e) => setSpecialisation(e.target.value)}
              placeholder="e.g. Master Handloom Weaver & Banarasi Brocade Artisan"
              className="w-full bg-gray-50/70 border border-gray-200 rounded-2xl px-4 py-3.5 text-sm font-medium text-gray-900 focus:bg-white focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 outline-none transition-all shadow-xs"
            />

            {/* Popular Specialisation Chips */}
            <div className="mt-3">
              <p className="text-[11px] font-semibold text-gray-400 mb-2">
                Quick Select Traditional Specialisation:
              </p>
              <div className="flex flex-wrap gap-1.5">
                {CRAFT_SUGGESTIONS.map((craft, idx) => (
                  <button
                    key={idx}
                    type="button"
                    onClick={() => setSpecialisation(craft)}
                    className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all ${
                      specialisation === craft
                        ? 'bg-[#B45309] text-white shadow-xs'
                        : 'bg-gray-100 hover:bg-[#B45309]/15 text-gray-700'
                    }`}
                  >
                    {craft}
                  </button>
                ))}
              </div>
            </div>
          </div>

          {/* Verified Guarantee Note */}
          <div className="bg-[#B45309]/10 border border-[#B45309]/30 rounded-2xl p-4 flex items-start gap-3">
            <ShieldCheck size={20} className="text-[#B45309] shrink-0 mt-0.5" />
            <p className="text-xs text-gray-700 leading-relaxed font-normal">
              Your details are encrypted and used only to connect your craft with verified B2B buyers and official government welfare grants.
            </p>
          </div>

          {/* Submit Button */}
          <div className="pt-2">
            <button
              type="submit"
              className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold py-4 px-6 rounded-full flex items-center justify-center gap-2 shadow-md shadow-[#B45309]/20 active:scale-[0.99] transition-all text-base min-h-[48px]"
            >
              <span>Save Details & Enter Studio</span>
              <ArrowRight size={18} className="stroke-[2.5]" />
            </button>
          </div>
        </form>
      </main>
    </div>
  );
};
