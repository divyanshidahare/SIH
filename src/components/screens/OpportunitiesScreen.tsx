import React, { useState } from 'react';
import { Award, Calendar, CheckCircle, Info, ArrowUpRight } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';
import { BottomNav } from '../BottomNav';
import { OpportunityItem } from '../../types';

export const OpportunitiesScreen: React.FC<{ isRootTab?: boolean }> = ({ isRootTab = false }) => {
  const { opportunities, showToast } = useApp();
  const [selectedOpp, setSelectedOpp] = useState<OpportunityItem | null>(null);

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-24 font-sans">
      <AppBar title="Government & Market Support" showBackButton={!isRootTab} />

      <div className="p-4 space-y-4">
        {/* Transparent Demo Data Disclaimer */}
        <div className="bg-[#B45309]/10 border border-[#B45309]/30 rounded-2xl p-3 flex items-center gap-2.5 text-gray-800">
          <Info size={18} className="text-[#B45309] shrink-0" />
          <p className="text-xs font-semibold leading-relaxed">
            Curated official artisan schemes: MSME Vishwakarma, Ministry of Textiles, and UNESCO craft grants.
          </p>
        </div>

        {/* Opportunities List */}
        <div className="space-y-4">
          {opportunities.map((opp) => (
            <div
              key={opp.id}
              className="bg-white border border-gray-100 hover:border-[#B45309]/40 rounded-[24px] p-5 shadow-xs space-y-3 transition-all"
            >
              <div className="flex items-center justify-between">
                <span className="bg-[#B45309]/15 text-[#B45309] text-[10px] font-bold uppercase px-2.5 py-1 rounded-full">
                  {opp.type === 'governmentScheme' ? 'Govt Scheme' : (opp.type === 'tradeFair' ? 'Trade Fair' : 'NGO Grant')}
                </span>
                <span className="flex items-center gap-1 text-xs text-gray-400 font-medium">
                  <Calendar size={13} /> {opp.deadline}
                </span>
              </div>

              <div>
                <h3 className="font-bold text-gray-900 text-base">
                  {opp.title}
                </h3>
                <p className="text-xs text-gray-500 font-medium">{opp.organization}</p>
              </div>

              <div className="bg-gray-50 border border-gray-100 rounded-xl p-3 text-xs font-semibold text-gray-800 flex items-center gap-2">
                <Award size={16} className="text-[#B45309] shrink-0" />
                <span>{opp.stipendOrGrant}</span>
              </div>

              <p className="text-xs text-gray-500 font-normal leading-relaxed">
                {opp.description}
              </p>

              <button
                onClick={() => setSelectedOpp(opp)}
                className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold rounded-full flex items-center justify-center gap-1.5 transition-all active:scale-98 shadow-sm py-2.5 text-xs"
              >
                <span>View Details & Apply</span>
                <ArrowUpRight size={16} />
              </button>
            </div>
          ))}
        </div>
      </div>

      {/* Application Details Modal */}
      {selectedOpp && (
        <div className="fixed inset-0 bg-black/50 z-50 flex items-end sm:items-center justify-center p-0 sm:p-4 backdrop-blur-xs">
          <div className="bg-white w-full max-w-md rounded-t-3xl sm:rounded-3xl max-h-[85vh] overflow-y-auto p-6 space-y-4 animate-slide-up">
            <span className="text-[10px] font-black uppercase tracking-wider bg-[#FEF3C7] px-2.5 py-1 rounded-md text-[#B45309]">
              Verified Opportunity
            </span>

            <h3 className="font-black text-xl text-[#1F2937]">{selectedOpp.title}</h3>
            <p className="text-xs text-gray-500 font-bold">{selectedOpp.organization}</p>

            <div className="bg-gray-50 p-3 rounded-xl border border-gray-100 text-xs space-y-1">
              <p className="font-black text-[#1F2937]">Grant & Incentive:</p>
              <p className="text-gray-700">{selectedOpp.stipendOrGrant}</p>
            </div>

            <div>
              <p className="font-bold text-xs text-[#1F2937] mb-2">Eligibility Criteria:</p>
              <ul className="space-y-1.5 text-xs text-gray-600">
                {selectedOpp.eligibility.map((el, idx) => (
                  <li key={idx} className="flex items-center gap-2">
                    <CheckCircle size={14} className="text-green-600 shrink-0" />
                    <span>{el}</span>
                  </li>
                ))}
              </ul>
            </div>

            <div className="pt-3 space-y-2">
              <button
                onClick={() => {
                  showToast("Draft application generated with your digitized catalog!");
                  setSelectedOpp(null);
                }}
                className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold py-3.5 rounded-xl text-sm transition-all"
              >
                Apply with Digitized Catalog
              </button>
              <button
                onClick={() => setSelectedOpp(null)}
                className="w-full bg-gray-100 text-[#1F2937] font-bold py-3 rounded-xl text-xs"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}

      {isRootTab && <BottomNav />}
    </div>
  );
};
