import React from 'react';
import { ChevronLeft } from 'lucide-react';
import { useApp } from '../context/AppContext';

interface AppBarProps {
  title: string;
  showBackButton?: boolean;
  onBack?: () => void;
  actions?: React.ReactNode;
}

export const AppBar: React.FC<AppBarProps> = ({
  title,
  showBackButton = true,
  onBack,
  actions,
}) => {
  const { goBack } = useApp();

  return (
    <header className="w-full bg-white border-b border-gray-100 flex items-center justify-between px-4 py-3 h-14 z-20 sticky top-0 transition-all">
      <div className="flex items-center gap-2.5">
        {showBackButton && (
          <button
            type="button"
            onClick={onBack || goBack}
            className="flex items-center gap-1 bg-[#B45309]/10 hover:bg-[#B45309]/20 border border-[#B45309]/30 rounded-xl transition-all active:scale-95 text-[#B45309] font-bold px-2.5 py-1 text-sm cursor-pointer"
          >
            <ChevronLeft size={18} className="stroke-[2.5]" />
            <span>Back</span>
          </button>
        )}
        <h1 className="font-bold text-gray-900 tracking-tight truncate max-w-[210px] sm:max-w-xs text-lg">
          {title}
        </h1>
      </div>

      <div className="flex items-center gap-1.5">
        {actions}
      </div>
    </header>
  );
};
