import React, { useState, useEffect } from 'react';
import {
  Camera,
  Image as ImageIcon,
  Sparkles,
  Mic,
  Check,
  Share2,
  BookOpen,
  ArrowRight,
  Calculator,
  CheckCircle2,
  ShieldCheck,
} from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';
import { ProductItem } from '../../types';

export const UploadProductFlowScreen: React.FC = () => {
  const { navigateTo, addProduct, showToast, setActiveTab } = useApp();
  const [currentStep, setCurrentStep] = useState<number>(1);
  const [isProcessingAi, setIsProcessingAi] = useState<boolean>(false);

  // Form State across steps
  const [selectedPhoto, setSelectedPhoto] = useState<string>(
    "https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=600&auto=format&fit=crop&q=80"
  );
  const [voiceSpokenText, setVoiceSpokenText] = useState<string>(
    "Pure silk Banarasi saree with gold zari work, woven on handloom over two weeks with traditional mango bootidars."
  );
  const [isListening, setIsListening] = useState<boolean>(false);

  // Automatically trigger AI enhancement when entering Step 2
  useEffect(() => {
    if (currentStep === 2) {
      setIsProcessingAi(true);
      const timer = setTimeout(() => {
        setIsProcessingAi(false);
        showToast("AI automatically cleaned workshop clutter & balanced lighting!");
      }, 750);
      return () => clearTimeout(timer);
    }
  }, [currentStep]);

  // AI Generated Catalog metadata
  const [titleEnglish, setTitleEnglish] = useState<string>("Handwoven Banarasi Katan Silk Saree");
  const [titleHindi, setTitleHindi] = useState<string>("हाथ से बुनी बनारसी कातान सिल्क साड़ी");
  const [category, setCategory] = useState<string>("Handloom Weaving");
  const [craftType, setCraftType] = useState<string>("Banarasi Silk");
  const [descriptionEnglish, setDescriptionEnglish] = useState<string>(
    "Authentic hand-loomed pure Katan silk with gold Zari floral motifs (Kadhwa technique). Woven over 14 days by Varanasi master artisan."
  );
  const [tags, setTags] = useState<string[]>(["Pure Silk", "Zari Work", "GI Tagged", "Handloom"]);

  // Pricing formula inputs
  const [materialCost, setMaterialCost] = useState<number>(2800);
  const [hoursSpent, setHoursSpent] = useState<number>(36);
  const [hourlyWage, setHourlyWage] = useState<number>(65);

  const calculateSuggestedPrice = () => {
    const labor = hoursSpent * hourlyWage;
    const base = materialCost + labor;
    const margin = base * 0.35; // 35% fair artisan profit margin
    return Math.round(base + margin);
  };

  const calculateMinPrice = () => {
    const labor = hoursSpent * hourlyWage;
    return Math.round(materialCost + labor);
  };

  // Step 3: Voice Simulation
  const handleToggleVoice = () => {
    if (!isListening) {
      setIsListening(true);
      showToast("Listening... Speak in Hindi or English");
      setTimeout(() => {
        setIsListening(false);
        setVoiceSpokenText(
          "Master handwoven pure Mulberry silk saree with antique zari motifs and hand-spun silk borders."
        );
        showToast("Voice captured & transcribed!");
      }, 1600);
    } else {
      setIsListening(false);
    }
  };

  // Step 7: Save & Publish
  const handleSaveToCatalog = () => {
    const newProduct: ProductItem = {
      id: `prod-${Date.now()}`,
      title: titleEnglish,
      titleHindi: titleHindi,
      category: category,
      price: calculateSuggestedPrice(),
      estimatedCost: calculateMinPrice(),
      stock: 5,
      description: descriptionEnglish,
      descriptionHindi: "प्रामाणिक कढ़वा तकनीक से शुद्ध कातान सिल्क पर सोने की जरी से हाथ से बुनी गई उत्कृष्ट साड़ी।",
      tags: tags,
      imageUrl: selectedPhoto,
      completionPercentage: 100,
      craftType: craftType,
    };

    addProduct(newProduct);
    setCurrentStep(7); // Jump to success step
  };

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col justify-between font-sans">
      {/* Step Header */}
      <AppBar
        title={`AI Studio: Step ${currentStep} of 6`}
        onBack={() => {
          if (currentStep > 1 && currentStep < 7) {
            setCurrentStep((prev) => prev - 1);
          } else {
            navigateTo('home');
          }
        }}
      />

      {/* Progress Bar */}
      {currentStep < 7 && (
        <div className="w-full bg-gray-100 h-1.5">
          <div
            className="bg-[#B45309] h-1.5 transition-all duration-300"
            style={{ width: `${(currentStep / 6) * 100}%` }}
          />
        </div>
      )}

      {/* Main Step Body */}
      <div className="p-5 flex-1 overflow-y-auto">
        {/* ================= STEP 1: PRODUCT PHOTO ================= */}
        {currentStep === 1 && (
          <div className="space-y-5">
            <div>
              <span className="text-xs font-bold text-[#B45309] uppercase tracking-wider">
                Step 1 of 6
              </span>
              <h2 className="font-bold text-gray-900 tracking-tight text-xl">
                Add Product Photo
              </h2>
              <p className="text-xs text-gray-500 font-normal mt-1">
                Take a clear photo in your workshop or select from your gallery.
              </p>
            </div>

            {/* Photo Preview Container */}
            <div className="relative aspect-square w-full rounded-[24px] overflow-hidden border-2 border-[#B45309] bg-gray-50 shadow-xs">
              <img
                src={selectedPhoto}
                alt="Selected craft"
                className="w-full h-full object-cover"
              />
              <div className="absolute top-3 right-3 bg-white/90 backdrop-blur-xs px-3 py-1 rounded-full text-xs font-bold text-gray-900 border border-gray-100 shadow-sm flex items-center gap-1.5">
                <Check size={14} className="text-green-600 stroke-[3]" />
                Photo Selected
              </div>
            </div>

            {/* Photo Action Buttons */}
            <div className="grid grid-cols-2 gap-3">
              <button
                type="button"
                onClick={() => {
                  setSelectedPhoto("https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=600&auto=format&fit=crop&q=80");
                  showToast("Photo captured from Camera!");
                }}
                className="border border-gray-200 hover:border-[#B45309] rounded-full font-bold flex items-center justify-center gap-2 active:scale-98 transition-all p-3 text-sm min-h-[48px] bg-white text-gray-800 shadow-xs"
              >
                <Camera size={18} />
                <span>Take Photo</span>
              </button>

              <button
                type="button"
                onClick={() => {
                  setSelectedPhoto("https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=600&auto=format&fit=crop&q=80");
                  showToast("Photo selected from Gallery!");
                }}
                className="border border-gray-200 hover:border-[#B45309] rounded-full font-bold flex items-center justify-center gap-2 active:scale-98 transition-all p-3 text-sm min-h-[48px] bg-white text-gray-800 shadow-xs"
              >
                <ImageIcon size={18} />
                <span>Choose Gallery</span>
              </button>
            </div>
          </div>
        )}

        {/* ================= STEP 2: AI PHOTO STUDIO ================= */}
        {currentStep === 2 && (
          <div className="space-y-5">
            <div>
              <span className="text-xs font-bold text-[#B45309] uppercase tracking-wider">
                Step 2 of 6
              </span>
              <h2 className="font-bold text-gray-900 tracking-tight text-xl">
                AI Photo Studio (Automatic)
              </h2>
              <p className="text-xs text-gray-500 font-normal mt-1">
                कलाMITRA AI automatically removes workshop clutter and balances lighting. No manual editing needed.
              </p>
            </div>

            {/* Preview with Automated Processing */}
            <div className="relative aspect-square w-full rounded-[24px] overflow-hidden border border-gray-100 bg-gray-50 shadow-xs">
              <img
                src={selectedPhoto}
                alt="Studio enhanced"
                className={`w-full h-full object-cover transition-all duration-300 ${
                  !isProcessingAi ? 'brightness-105 contrast-105 saturate-105' : 'blur-xs'
                }`}
              />

              {isProcessingAi && (
                <div className="absolute inset-0 bg-white/80 backdrop-blur-xs flex flex-col items-center justify-center">
                  <div className="w-10 h-10 border-3 border-[#B45309] border-t-transparent rounded-full animate-spin mb-3" />
                  <p className="text-sm font-bold text-gray-900">AI Cleaning Background Automatically...</p>
                  <p className="text-xs text-gray-500">Isolating craft motifs & balancing studio lighting</p>
                </div>
              )}

              {!isProcessingAi && (
                <div className="absolute bottom-3 left-3 bg-white/95 backdrop-blur-xs px-3.5 py-1.5 rounded-full text-xs font-bold text-gray-900 border border-gray-100 shadow-sm flex items-center gap-1.5">
                  <Sparkles size={14} className="text-[#B45309]" />
                  <span>AI Auto-Enhanced Studio Quality</span>
                </div>
              )}
            </div>

            {/* Automatic Enhancements Status Cards */}
            <div className="bg-white border border-gray-100 rounded-[24px] p-4 shadow-xs space-y-3">
              <div className="flex items-center gap-2 text-xs font-bold text-gray-900">
                <CheckCircle2 size={16} className="text-green-600 shrink-0" />
                <span>Automated Studio Enhancements Applied</span>
              </div>
              <div className="grid grid-cols-2 gap-2 text-[11px] text-gray-600 font-medium">
                <div className="bg-gray-50 p-2.5 rounded-xl border border-gray-100 flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-green-500 shrink-0" />
                  <span className="truncate">Workshop clutter removed</span>
                </div>
                <div className="bg-gray-50 p-2.5 rounded-xl border border-gray-100 flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-green-500 shrink-0" />
                  <span className="truncate">Studio lighting balanced</span>
                </div>
                <div className="bg-gray-50 p-2.5 rounded-xl border border-gray-100 flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-green-500 shrink-0" />
                  <span className="truncate">Zari & thread tones preserved</span>
                </div>
                <div className="bg-gray-50 p-2.5 rounded-xl border border-gray-100 flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-green-500 shrink-0" />
                  <span className="truncate">High-res export isolation</span>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ================= STEP 3: DESCRIBE PRODUCT ================= */}
        {currentStep === 3 && (
          <div className="space-y-6">
            <div>
              <span className="text-xs font-black text-[#B45309] uppercase tracking-wider">
                Step 3 of 6
              </span>
              <h2 className="font-bold text-gray-900 tracking-tight text-xl">
                Describe Your Craft
              </h2>
              <p className="text-xs text-gray-500 font-normal mt-1">
                No need to type! Just tap the microphone and speak in Hindi or English.
              </p>
            </div>

            {/* BIG MIC BUTTON */}
            <div className="flex flex-col items-center justify-center py-6 bg-gray-50 rounded-[24px] border-2 border-dashed border-gray-200">
              <button
                type="button"
                onClick={handleToggleVoice}
                className={`relative rounded-full flex items-center justify-center transition-all duration-300 active:scale-95 w-22 h-22 ${
                  isListening
                    ? 'bg-red-500 text-white animate-pulse shadow-lg shadow-red-500/40'
                    : 'bg-[#B45309] text-white shadow-md shadow-[#B45309]/30 hover:bg-[#92400E]'
                }`}
              >
                <Mic size={36} className="stroke-[2.5]" />
              </button>

              <p className="font-bold mt-4 text-gray-900 text-base">
                {isListening ? "Listening to your voice..." : "Tap and Speak (बोलें)"}
              </p>
              <p className="text-xs text-gray-500 font-medium mt-1 text-center max-w-xs">
                "What is this product? What material did you use? How long did it take?"
              </p>
            </div>

            {/* Editable Voice Transcript Field */}
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-1">
                Transcribed Craft Description:
              </label>
              <textarea
                rows={3}
                value={voiceSpokenText}
                onChange={(e) => setVoiceSpokenText(e.target.value)}
                placeholder="Speak or type product details..."
                className="w-full p-3 bg-white border border-gray-200 rounded-xl text-sm font-semibold text-[#1F2937] focus:border-[#B45309] outline-none"
              />
            </div>
          </div>
        )}

        {/* ================= STEP 4: AI AUTO-CATALOGING ================= */}
        {currentStep === 4 && (
          <div className="space-y-5">
            <div className="bg-[#FEF3C7] border border-[#B45309]/30 rounded-2xl p-4 flex items-center gap-3">
              <Sparkles size={24} className="text-[#B45309] shrink-0" />
              <div>
                <h3 className="text-sm font-black text-[#1F2937]">कलाMITRA AI Auto-Cataloged</h3>
                <p className="text-xs text-gray-600 font-medium">
                  We generated bilingual titles, craft heritage story, and buyer search tags.
                </p>
              </div>
            </div>

            {/* Bilingual Title Fields */}
            <div className="space-y-3">
              <div>
                <label className="block text-xs font-bold text-gray-500 mb-1">
                  Product Title (English):
                </label>
                <input
                  type="text"
                  value={titleEnglish}
                  onChange={(e) => setTitleEnglish(e.target.value)}
                  className="w-full p-3 bg-gray-50 border border-gray-200 rounded-xl text-sm font-bold text-[#1F2937] focus:bg-white focus:border-[#B45309] outline-none"
                />
              </div>

              <div>
                <label className="block text-xs font-bold text-gray-500 mb-1">
                  Product Title (Hindi / हिंदी):
                </label>
                <input
                  type="text"
                  value={titleHindi}
                  onChange={(e) => setTitleHindi(e.target.value)}
                  className="w-full p-3 bg-gray-50 border border-gray-200 rounded-xl text-sm font-bold text-[#1F2937] focus:bg-white focus:border-[#B45309] outline-none"
                />
              </div>
            </div>

            {/* Category & Craft */}
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-bold text-gray-500 mb-1">Category</label>
                <input
                  type="text"
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  className="w-full p-3 bg-gray-50 border border-gray-200 rounded-xl text-xs font-bold"
                />
              </div>
              <div>
                <label className="block text-xs font-bold text-gray-500 mb-1">Craft Provenance</label>
                <input
                  type="text"
                  value={craftType}
                  onChange={(e) => setCraftType(e.target.value)}
                  className="w-full p-3 bg-gray-50 border border-gray-200 rounded-xl text-xs font-bold"
                />
              </div>
            </div>

            {/* AI Generated Craft Story */}
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-1">
                Artisan Story & Provenance Note:
              </label>
              <textarea
                rows={3}
                value={descriptionEnglish}
                onChange={(e) => setDescriptionEnglish(e.target.value)}
                className="w-full p-3 bg-gray-50 border border-gray-200 rounded-xl text-xs font-medium leading-relaxed"
              />
            </div>

            {/* Tags */}
            <div>
              <label className="block text-xs font-bold text-gray-500 mb-1">Buyer Search Tags</label>
              <div className="flex flex-wrap gap-1.5">
                {tags.map((t, idx) => (
                  <span key={idx} className="bg-gray-100 text-gray-700 text-xs font-bold px-2.5 py-1 rounded-lg">
                    #{t}
                  </span>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ================= STEP 5: SMART PRICING ================= */}
        {currentStep === 5 && (
          <div className="space-y-5">
            <div>
              <span className="text-xs font-black text-[#B45309] uppercase tracking-wider">
                Step 5 of 6
              </span>
              <h2 className="font-bold text-gray-900 tracking-tight text-xl">
                Smart Fair-Wage Pricing
              </h2>
              <p className="text-xs text-gray-500 font-medium mt-1">
                Never underprice your hard work. We calculate raw materials + fair artisan hourly wages.
              </p>
            </div>

            {/* Input fields */}
            <div className="grid grid-cols-2 gap-3">
              <div className="bg-gray-50 p-3 rounded-xl border border-gray-200">
                <label className="block text-xs font-bold text-gray-500 mb-1">Material Cost</label>
                <div className="flex items-center gap-1">
                  <span className="text-gray-400 font-bold">₹</span>
                  <input
                    type="number"
                    value={materialCost}
                    onChange={(e) => setMaterialCost(Number(e.target.value))}
                    className="w-full bg-transparent font-black text-lg outline-none"
                  />
                </div>
              </div>

              <div className="bg-gray-50 p-3 rounded-xl border border-gray-200">
                <label className="block text-xs font-bold text-gray-500 mb-1">Crafting Hours</label>
                <div className="flex items-center gap-1">
                  <input
                    type="number"
                    value={hoursSpent}
                    onChange={(e) => setHoursSpent(Number(e.target.value))}
                    className="w-full bg-transparent font-black text-lg outline-none"
                  />
                  <span className="text-gray-400 text-xs font-bold">Hours</span>
                </div>
              </div>
            </div>

            {/* AI Suggested Price Hero Card */}
            <div className="bg-[#FEF3C7] border-2 border-[#B45309] rounded-2xl p-5 space-y-3">
              <div className="flex items-center justify-between">
                <span className="text-xs font-black uppercase text-[#1F2937] flex items-center gap-1">
                  <Calculator size={16} className="text-[#B45309]" />
                  AI Suggested Selling Price
                </span>
                <span className="bg-[#B45309] text-white text-[10px] font-extrabold px-2 py-0.5 rounded-full">
                  Fair Trade Certified
                </span>
              </div>

              <div className="flex items-baseline gap-2">
                <span className="text-3xl font-black text-[#1F2937]">₹{calculateSuggestedPrice().toLocaleString()}</span>
                <span className="text-xs text-gray-600 font-semibold">(Min ₹{calculateMinPrice().toLocaleString()})</span>
              </div>

              <div className="text-xs text-gray-700 bg-white/80 rounded-xl p-3 border border-gray-100 space-y-1">
                <p className="font-extrabold text-[#1F2937]">Why this price?</p>
                <p>• Raw materials: ₹{materialCost}</p>
                <p>• Artisan labour: {hoursSpent} hrs × ₹{hourlyWage}/hr = ₹{hoursSpent * hourlyWage}</p>
                <p>• 35% craft reserve margin for business growth</p>
              </div>
            </div>
          </div>
        )}

        {/* ================= STEP 6: CATALOG PREVIEW ================= */}
        {currentStep === 6 && (
          <div className="space-y-5">
            <div>
              <span className="text-xs font-black text-[#B45309] uppercase tracking-wider">
                Step 6 of 6
              </span>
              <h2 className="font-bold text-gray-900 tracking-tight text-xl">
                Catalog Preview
              </h2>
              <p className="text-xs text-gray-500 font-medium mt-1">
                This is exactly how institutional buyers and craft lovers will see your product.
              </p>
            </div>

            {/* Beautiful Preview Card */}
            <div className="bg-white border-2 border-[#B45309] rounded-2xl overflow-hidden shadow-md">
              <div className="relative aspect-video w-full">
                <img src={selectedPhoto} alt="Preview" className="w-full h-full object-cover" />
                <span className="absolute top-3 left-3 bg-[#B45309] text-white font-black text-[11px] px-2.5 py-0.5 rounded-full shadow-sm">
                  {category}
                </span>
              </div>

              <div className="p-4 space-y-2">
                <div className="flex justify-between items-start">
                  <div>
                    <h3 className="font-black text-[#1F2937] text-base leading-tight">
                      {titleEnglish}
                    </h3>
                    <p className="text-xs font-bold text-gray-500 mt-0.5">
                      {titleHindi}
                    </p>
                  </div>
                  <span className="font-black text-[#1F2937] text-lg">
                    ₹{calculateSuggestedPrice().toLocaleString()}
                  </span>
                </div>

                <p className="text-xs text-gray-600 font-medium leading-relaxed">
                  {descriptionEnglish}
                </p>

                <div className="pt-2 flex flex-wrap gap-1">
                  {tags.map((t, idx) => (
                    <span key={idx} className="bg-[#FEF3C7] text-[#1F2937] text-[10px] font-extrabold px-2 py-0.5 rounded-md">
                      {t}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ================= STEP 7: SUCCESS SCREEN ================= */}
        {currentStep === 7 && (
          <div className="flex flex-col items-center text-center py-8 space-y-5 animate-fade-in">
            <div className="w-24 h-24 rounded-full bg-[#FEF3C7] border-2 border-[#B45309] flex items-center justify-center text-4xl shadow-xl shadow-[#B45309]/30">
              🎉
            </div>

            <div>
              <h2 className="text-2xl font-black text-[#1F2937]">
                Product Added to Your Catalog!
              </h2>
              <p className="text-sm text-gray-500 font-medium mt-1 max-w-xs">
                Your craft is now digitized and ready to share with B2B buyers and exhibitions.
              </p>
            </div>

            <div className="w-full space-y-3 pt-4">
              <button
                onClick={() => {
                  showToast("Product link copied for WhatsApp sharing!");
                }}
                className="w-full bg-[#25D366] text-white font-black py-4 rounded-2xl flex items-center justify-center gap-2 active:scale-98 shadow-md"
              >
                <Share2 size={20} />
                <span>Share on WhatsApp</span>
              </button>

              <button
                onClick={() => {
                  setActiveTab(1);
                  navigateTo('catalog');
                }}
                className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-black py-4 rounded-2xl flex items-center justify-center gap-2 active:scale-98"
              >
                <BookOpen size={20} />
                <span>Go to My Catalog</span>
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Bottom Sticky Action Bar for Steps 1-6 */}
      {currentStep < 7 && (
        <div className="p-5 border-t border-gray-100 bg-white">
          <button
            onClick={() => {
              if (currentStep === 6) {
                handleSaveToCatalog();
              } else {
                setCurrentStep((prev) => prev + 1);
              }
            }}
            className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold rounded-full flex items-center justify-center gap-2 shadow-sm active:scale-98 transition-all py-4 text-base min-h-[48px]"
          >
            <span>{currentStep === 6 ? "Add to My Catalog" : "Next Step"}</span>
            <ArrowRight size={20} className="stroke-[2.5]" />
          </button>
        </div>
      )}
    </div>
  );
};
