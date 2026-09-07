import React, { useState } from 'react';
import { Camera, Calculator, Award, Handshake, Mic, Send, Sparkles, Volume2 } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';

export const HelpScreen: React.FC = () => {
  const { showToast } = useApp();
  const [inputText, setInputText] = useState('');
  const [messages, setMessages] = useState<Array<{ isAi: boolean; text: string; time: string }>>([
    {
      isAi: true,
      text: "Namaste Priya ji! I am कलाMITRA AI Sarthi, your virtual craft advisor. How can I assist your artisan business today?",
      time: "Just now",
    },
  ]);

  const quickCategories = [
    {
      icon: Camera,
      title: "Photography Tips",
      prompt: "How do I take sharp photos of my handloom sarees with low natural light?",
      response: "Use morning window light placed at a 45° angle. Avoid flashlight, which causes glare on zari. कलाMITRA AI Studio will automatically clean the background!",
    },
    {
      icon: Calculator,
      title: "Pricing Calculation",
      prompt: "How do I price my craft so I don't lose money on raw silk?",
      response: "Formula: (Raw Material Cost + Packaging) + (Crafting Hours × ₹60/hr minimum) + 35% artisan profit margin. For your Banarasi silk, suggested selling price is ₹4,850 - ₹6,850.",
    },
    {
      icon: Award,
      title: "Govt Schemes & Grants",
      prompt: "How can I get the ₹15,000 tool incentive under PM Vishwakarma?",
      response: "Step 1: Visit your nearest Common Service Center (CSC) with Aadhaar and Artisan Pehchan card. Step 2: Choose 'Weaver/Potter' trade. Step 3: Complete 5-day basic training to receive digital toolkit voucher.",
    },
    {
      icon: Handshake,
      title: "B2B Buyers & Fairs",
      prompt: "How do I connect with craft emporiums for bulk orders?",
      response: "Export your digitized catalog as a PDF directly from the Catalog screen. Verified institutional buyers on कलाMITRA require minimum 5 products digitized with GI tagging.",
    },
  ];

  const handleSend = (text: string) => {
    if (!text.trim()) return;

    const newMsgs = [...messages, { isAi: false, text, time: "Now" }];
    setMessages(newMsgs);
    setInputText('');

    setTimeout(() => {
      let reply = "Thank you for asking! For traditional artisan crafts, maintaining authentic handloom provenance and pricing your labour at fair market rates guarantees long-term sustainability. Would you like me to guide you through cataloging or government scheme application?";
      for (const cat of quickCategories) {
        if (cat.prompt === text) {
          reply = cat.response;
          break;
        }
      }
      setMessages((prev) => [...prev, { isAi: true, text: reply, time: "Now" }]);
    }, 600);
  };

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col justify-between font-sans">
      <AppBar
        title="Ask कलाMITRA AI"
        actions={
          <button
            onClick={() => showToast("Voice read-aloud active (Hindi / English audio demo)")}
            className="p-2 rounded-xl bg-white border border-gray-100 text-gray-800 shadow-xs"
            title="Listen in Hindi"
          >
            <Volume2 size={18} />
          </button>
        }
      />

      {/* Quick Category Chips */}
      <div className="bg-white border-b border-gray-100 p-3 flex gap-2 overflow-x-auto no-scrollbar">
        {quickCategories.map((cat, idx) => (
          <button
            key={idx}
            onClick={() => handleSend(cat.prompt)}
            className="bg-gray-50/80 border border-gray-100 hover:border-[#B45309] px-3.5 py-2 rounded-full text-xs font-semibold text-gray-800 whitespace-nowrap flex items-center gap-1.5 shadow-xs transition-colors"
          >
            <cat.icon size={14} className="text-[#B45309]" />
            <span>{cat.title}</span>
          </button>
        ))}
      </div>

      {/* Messages Scroll Area */}
      <div className="flex-1 overflow-y-auto p-4 space-y-3.5">
        {messages.map((msg, index) => (
          <div
            key={index}
            className={`flex ${msg.isAi ? 'justify-start' : 'justify-end'}`}
          >
            <div
              className={`max-w-[85%] rounded-[24px] p-4 ${
                msg.isAi
                  ? 'bg-[#B45309]/10 border border-[#B45309]/25 text-gray-900 rounded-bl-sm'
                  : 'bg-gray-900 text-white rounded-br-sm shadow-xs'
              }`}
            >
              {msg.isAi && (
                <div className="flex items-center gap-1.5 text-[#B45309] text-[10px] font-bold uppercase mb-1.5">
                  <Sparkles size={12} />
                  कलाMITRA AI Advisor
                </div>
              )}
              <p className="font-medium leading-relaxed text-sm">
                {msg.text}
              </p>
            </div>
          </div>
        ))}
      </div>

      {/* Input Bar */}
      <div className="p-3 border-t border-gray-100 bg-white flex items-center gap-2">
        <button
          onClick={() => handleSend("How do I take sharp photos of my handloom sarees with low natural light?")}
          className="p-2.5 rounded-full bg-[#FEF3C7] text-[#B45309] hover:bg-[#B45309] hover:text-white transition-colors"
          title="Voice Ask"
        >
          <Mic size={20} />
        </button>

        <input
          type="text"
          value={inputText}
          onChange={(e) => setInputText(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && handleSend(inputText)}
          placeholder="Ask anything in Hindi or English..."
          className="flex-1 bg-gray-50 border border-gray-200 rounded-xl px-4 py-2.5 text-sm font-semibold text-[#1F2937] focus:bg-white focus:border-[#B45309] outline-none"
        />

        <button
          onClick={() => handleSend(inputText)}
          className="p-2.5 rounded-full bg-[#B45309] text-white hover:bg-[#92400E] transition-colors"
        >
          <Send size={18} />
        </button>
      </div>
    </div>
  );
};
