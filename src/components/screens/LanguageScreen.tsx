import React, { useState, useMemo } from 'react';
import { ArrowLeft, Check, Search, ArrowRight } from 'lucide-react';
import { useApp } from '../../context/AppContext';

export interface LanguageItem {
  id: string;
  englishName: string;
  nativeName: string;
  isRTL?: boolean;
}

export const ALL_INDIAN_LANGUAGES: LanguageItem[] = [
  { id: 'English', englishName: 'English', nativeName: 'English' },
  { id: 'Hindi', englishName: 'Hindi', nativeName: 'हिन्दी' },
  { id: 'Assamese', englishName: 'Assamese', nativeName: 'অসমীয়া' },
  { id: 'Bengali', englishName: 'Bengali', nativeName: 'বাংলা' },
  { id: 'Bodo', englishName: 'Bodo', nativeName: 'बड़ो' },
  { id: 'Dogri', englishName: 'Dogri', nativeName: 'डोगरी' },
  { id: 'Gujarati', englishName: 'Gujarati', nativeName: 'ગુજરાતી' },
  { id: 'Kannada', englishName: 'Kannada', nativeName: 'ಕನ್ನಡ' },
  { id: 'Kashmiri', englishName: 'Kashmiri', nativeName: 'कश्मीरी' },
  { id: 'Konkani', englishName: 'Konkani', nativeName: 'कोंकणी' },
  { id: 'Maithili', englishName: 'Maithili', nativeName: 'मैथिली' },
  { id: 'Malayalam', englishName: 'Malayalam', nativeName: 'മലയാളം' },
  { id: 'Manipuri', englishName: 'Manipuri', nativeName: 'মণিপুরী' },
  { id: 'Marathi', englishName: 'Marathi', nativeName: 'मराठी' },
  { id: 'Nepali', englishName: 'Nepali', nativeName: 'नेपाली' },
  { id: 'Odia', englishName: 'Odia', nativeName: 'ଓଡ଼ିଆ' },
  { id: 'Punjabi', englishName: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ' },
  { id: 'Sanskrit', englishName: 'Sanskrit', nativeName: 'संस्कृतम्' },
  { id: 'Santali', englishName: 'Santali', nativeName: 'ᱥᱟᱱᱛᱟᱲᱤ' },
  { id: 'Sindhi', englishName: 'Sindhi', nativeName: 'سنڌي', isRTL: true },
  { id: 'Tamil', englishName: 'Tamil', nativeName: 'தமிழ்' },
  { id: 'Telugu', englishName: 'Telugu', nativeName: 'తెలుగు' },
  { id: 'Urdu', englishName: 'Urdu', nativeName: 'اردو', isRTL: true },
];

export const LanguageScreen: React.FC = () => {
  const {
    selectedLanguage,
    setLanguage,
    navigateTo,
    goBack,
    isFromSettings,
  } = useApp();

  const [searchQuery, setSearchQuery] = useState('');
  const [selectedId, setSelectedId] = useState<string>(() => {
    return selectedLanguage || 'English';
  });

  // Filter languages by English or Native name
  const filteredLanguages = useMemo(() => {
    const query = searchQuery.trim().toLowerCase();
    if (!query) return ALL_INDIAN_LANGUAGES;
    return ALL_INDIAN_LANGUAGES.filter(
      (lang) =>
        lang.englishName.toLowerCase().includes(query) ||
        lang.nativeName.toLowerCase().includes(query)
    );
  }, [searchQuery]);

  const currentSelectedLang = useMemo(() => {
    return (
      ALL_INDIAN_LANGUAGES.find((l) => l.id === selectedId) ||
      ALL_INDIAN_LANGUAGES[0]
    );
  }, [selectedId]);

  const handleCardClick = (langId: string) => {
    setSelectedId(langId);
  };

  const handleContinue = () => {
    setLanguage(selectedId);
    if (isFromSettings) {
      goBack();
    } else {
      navigateTo('login');
    }
  };

  const handleBack = () => {
    if (isFromSettings) {
      goBack();
    } else {
      navigateTo('onboarding');
    }
  };

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col justify-between font-sans text-gray-900">
      {/* Top Header with Back Arrow */}
      <header className="px-5 py-4 flex items-center gap-3 border-b border-gray-100 bg-white sticky top-0 z-30">
        <button
          type="button"
          onClick={handleBack}
          aria-label="Go back"
          className="w-10 h-10 rounded-full flex items-center justify-center text-gray-700 hover:bg-gray-100 active:scale-95 transition-all focus:outline-none focus:ring-2 focus:ring-[#B45309]"
        >
          <ArrowLeft size={20} className="stroke-[2.5]" />
        </button>
        <div>
          <h1 className="text-lg sm:text-xl font-bold text-gray-900 leading-tight">
            Choose your preferred language
          </h1>
        </div>
      </header>

      {/* Main Content Area */}
      <main className="flex-1 p-4 sm:p-6 max-w-5xl mx-auto w-full space-y-4">
        {/* Search Bar */}
        <div className="relative">
          <Search
            size={18}
            className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none"
          />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search language"
            aria-label="Search language"
            className="w-full bg-white border border-gray-200 rounded-[16px] pl-11 pr-4 py-3 text-sm text-gray-900 placeholder:text-gray-400 focus:outline-none focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 shadow-xs transition-all"
          />
          {searchQuery && (
            <button
              onClick={() => setSearchQuery('')}
              className="absolute right-3.5 top-1/2 -translate-y-1/2 text-xs font-semibold text-gray-400 hover:text-gray-700 px-2 py-1 rounded-md"
            >
              Clear
            </button>
          )}
        </div>

        {/* 2-column mobile, 3-column tablet, 4-column desktop grid */}
        <div
          role="radiogroup"
          aria-label="Select preferred language"
          className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-2.5 sm:gap-3.5 pb-24"
        >
          {filteredLanguages.map((lang) => {
            const isSelected = selectedId === lang.id;

            return (
              <button
                key={lang.id}
                role="radio"
                aria-checked={isSelected}
                onClick={() => handleCardClick(lang.id)}
                className={`min-h-[64px] sm:min-h-[72px] p-3.5 rounded-[16px] border text-left flex items-center justify-between transition-all duration-200 cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#B45309] active:scale-[0.98] ${
                  isSelected
                    ? 'bg-[#B45309]/10 border-[#B45309] shadow-sm ring-1 ring-[#B45309]/30'
                    : 'bg-white border-gray-100 hover:border-gray-300 hover:bg-gray-50/50 shadow-xs'
                }`}
              >
                <div className="flex-1 pr-2 min-w-0">
                  {/* Native Script */}
                  <p
                    dir={lang.isRTL ? 'rtl' : 'ltr'}
                    className={`font-bold text-base leading-snug truncate ${
                      isSelected ? 'text-gray-900' : 'text-gray-800'
                    }`}
                  >
                    {lang.nativeName}
                  </p>
                  {/* English Name */}
                  <p className="text-xs text-gray-500 font-medium truncate mt-0.5">
                    {lang.englishName}
                  </p>
                </div>

                {/* Checkmark indicator */}
                <div
                  className={`w-6 h-6 rounded-full flex items-center justify-center shrink-0 border transition-colors ${
                    isSelected
                      ? 'bg-[#B45309] border-[#B45309] text-white shadow-xs'
                      : 'border-gray-200 bg-transparent text-transparent'
                  }`}
                >
                  <Check size={14} className="stroke-[3]" />
                </div>
              </button>
            );
          })}
        </div>

        {filteredLanguages.length === 0 && (
          <div className="text-center py-12 bg-white rounded-2xl border border-gray-100 p-6">
            <p className="text-sm font-semibold text-gray-700">
              No language found matching "{searchQuery}"
            </p>
            <p className="text-xs text-gray-400 mt-1">
              Try searching with either English or native script spelling
            </p>
          </div>
        )}
      </main>

      {/* Sticky Bottom Bar with Dynamic Button and Settings Note */}
      <footer className="fixed bottom-0 left-0 right-0 bg-white/95 backdrop-blur-md border-t border-gray-100 p-4 z-40">
        <div className="max-w-5xl mx-auto space-y-2">
          <button
            type="button"
            onClick={handleContinue}
            className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold py-3.5 sm:py-4 px-6 rounded-full flex items-center justify-center gap-2 shadow-md shadow-[#B45309]/20 active:scale-[0.99] transition-all text-base focus:outline-none focus:ring-2 focus:ring-[#B45309] min-h-[48px]"
          >
            <span>
              Continue in {currentSelectedLang.id === 'English' ? 'English' : currentSelectedLang.nativeName}
            </span>
            <ArrowRight size={18} className="stroke-[2.5]" />
          </button>

          <p className="text-center text-[11px] sm:text-xs text-gray-500 font-medium">
            You can change your language anytime from Settings.
          </p>
        </div>
      </footer>
    </div>
  );
};
