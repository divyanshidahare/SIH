import React, { useState } from 'react';
import { Smartphone, Lock, Eye, EyeOff, ShieldCheck, LogIn, UserPlus } from 'lucide-react';
import { useApp } from '../../context/AppContext';

export const LoginScreen: React.FC = () => {
  const [identifier, setIdentifier] = useState('9876543210');
  const [password, setPassword] = useState('artisan123');
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const { navigateTo, showToast } = useApp();

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    setTimeout(() => {
      setIsLoading(false);
      showToast("Welcome! Please confirm your profile details.");
      navigateTo('profile_setup');
    }, 400);
  };

  const handleForgotPassword = () => {
    showToast("SMS OTP sent to +91 98765 43210 (Demo)");
  };

  const handleCreateAccount = () => {
    showToast("Please enter your artisan profile details.");
    navigateTo('profile_setup');
  };

  return (
    <div className="min-h-screen bg-[#FDFDFD] flex flex-col justify-between p-6 font-sans">
      <div className="pt-6">
        {/* Artisan Portal Badge */}
        <div className="inline-block bg-[#B45309]/10 border border-[#B45309]/30 rounded-full px-4 py-1.5 mb-4">
          <span className="text-xs font-bold text-[#B45309] tracking-wider">
            कलाMITRA ARTISAN PORTAL
          </span>
        </div>

        {/* Title */}
        <h2 className="font-bold text-gray-900 tracking-tight mb-2 text-2xl">
          Welcome to कलाMITRA
        </h2>

        {/* Subtitle */}
        <p className="text-gray-500 font-normal mb-8 leading-relaxed text-sm">
          Sign in to manage your handmade craft business, explore new B2B orders, and access government support.
        </p>

        {/* Form */}
        <form onSubmit={handleLogin} className="space-y-4">
          {/* Mobile / Email */}
          <div>
            <label className="block font-semibold text-gray-800 mb-1.5 text-sm">
              Mobile Number or Email
            </label>
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-400">
                <Smartphone size={18} />
              </div>
              <input
                type="text"
                value={identifier}
                onChange={(e) => setIdentifier(e.target.value)}
                placeholder="Enter 10-digit mobile or email"
                className="w-full bg-white border border-gray-200 rounded-2xl pl-11 pr-4 py-3 text-base focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 outline-none font-medium text-gray-900 transition-all shadow-xs"
              />
            </div>
          </div>

          {/* Password */}
          <div>
            <label className="block font-semibold text-gray-800 mb-1.5 text-sm">
              Password
            </label>
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-400">
                <Lock size={18} />
              </div>
              <input
                type={showPassword ? 'text' : 'password'}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Enter your password"
                className="w-full bg-white border border-gray-200 rounded-2xl pl-11 pr-11 py-3 text-base focus:border-[#B45309] focus:ring-2 focus:ring-[#B45309]/20 outline-none font-medium text-gray-900 transition-all shadow-xs"
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-gray-400 hover:text-gray-700"
              >
                {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
              </button>
            </div>
          </div>

          {/* Forgot Password */}
          <div className="text-right pt-1">
            <button
              type="button"
              onClick={handleForgotPassword}
              className="font-semibold text-[#B45309] hover:underline text-xs"
            >
              Forgot Password?
            </button>
          </div>

          {/* Login Button */}
          <div className="pt-3 space-y-3">
            <button
              type="submit"
              disabled={isLoading}
              className="w-full bg-[#B45309] hover:bg-[#92400E] text-white font-bold rounded-full flex items-center justify-center gap-2 shadow-sm transition-all active:scale-98 py-4 text-base min-h-[48px]"
            >
              {isLoading ? (
                <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin" />
              ) : (
                <>
                  <LogIn size={20} className="stroke-[2.5]" />
                  <span>Login</span>
                </>
              )}
            </button>

            {/* Create Account Button */}
            <button
              type="button"
              onClick={handleCreateAccount}
              className="w-full bg-white border border-gray-200 hover:border-[#B45309]/40 text-gray-800 font-semibold rounded-full flex items-center justify-center gap-2 transition-all active:scale-98 shadow-xs py-3.5 text-base min-h-[48px]"
            >
              <UserPlus size={18} className="stroke-[2]" />
              <span>Create Account</span>
            </button>
          </div>
        </form>
      </div>

      {/* Verified Notice (Strictly no guest access) */}
      <div className="mt-8 bg-[#B45309]/10 border border-[#B45309]/30 rounded-2xl p-4 flex items-center gap-3">
        <ShieldCheck size={22} className="text-[#B45309] shrink-0" />
        <p className="text-xs font-normal text-gray-700 leading-relaxed">
          Verified artisan accounts ensure direct payment settlement and access to government grant portals.
        </p>
      </div>
    </div>
  );
};
