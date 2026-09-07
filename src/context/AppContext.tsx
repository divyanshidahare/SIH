import React, { createContext, useContext, useState, ReactNode } from 'react';
import { ScreenName, ProductItem, CraftOrderItem, OpportunityItem, ArtisanProfile } from '../types';
import { INITIAL_PRODUCTS, INITIAL_ORDERS, INITIAL_OPPORTUNITIES, ARTISAN_PROFILE } from '../data/mockData';

interface AppContextType {
  currentScreen: ScreenName;
  screenHistory: ScreenName[];
  selectedLanguage: string;
  isFromSettings: boolean;
  products: ProductItem[];
  orders: CraftOrderItem[];
  opportunities: OpportunityItem[];
  toastMessage: string | null;
  activeTab: number;
  artisanProfile: ArtisanProfile;
  isEasyMode: boolean;
  setActiveTab: (tab: number) => void;
  navigateTo: (screen: ScreenName, fromSettings?: boolean) => void;
  goBack: () => void;
  setLanguage: (lang: string) => void;
  showToast: (msg: string) => void;
  updateProductStock: (productId: string, delta: number) => void;
  addProduct: (product: ProductItem) => void;
  updateOrderStatus: (orderId: string, status: CraftOrderItem['status']) => void;
  updateArtisanProfile: (profile: Partial<ArtisanProfile>) => void;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

export const AppProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [currentScreen, setCurrentScreen] = useState<ScreenName>('splash');
  const [screenHistory, setScreenHistory] = useState<ScreenName[]>([]);
  const [selectedLanguage, setSelectedLanguage] = useState<string>(() => {
    return localStorage.getItem('kalamitra_language') || 'English';
  });
  const [isFromSettings, setIsFromSettings] = useState<boolean>(false);
  const [products, setProducts] = useState<ProductItem[]>(INITIAL_PRODUCTS);
  const [orders, setOrders] = useState<CraftOrderItem[]>(INITIAL_ORDERS);
  const [opportunities] = useState<OpportunityItem[]>(INITIAL_OPPORTUNITIES);
  const [toastMessage, setToastMessage] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState<number>(0);
  const [artisanProfile, setArtisanProfile] = useState<ArtisanProfile>(() => {
    try {
      const saved = localStorage.getItem('kalamitra_artisan_profile');
      if (saved) return JSON.parse(saved);
    } catch {
      // fallback
    }
    return ARTISAN_PROFILE;
  });

  const showToast = (msg: string) => {
    setToastMessage(msg);
    setTimeout(() => {
      setToastMessage(null);
    }, 2800);
  };

  const navigateTo = (screen: ScreenName, fromSettings: boolean = false) => {
    setIsFromSettings(fromSettings);
    setScreenHistory((prev) => [...prev, currentScreen]);
    setCurrentScreen(screen);
  };

  const goBack = () => {
    if (screenHistory.length > 0) {
      const prev = screenHistory[screenHistory.length - 1];
      setScreenHistory((history) => history.slice(0, -1));
      setCurrentScreen(prev);
    } else {
      setCurrentScreen('home');
    }
  };

  const setLanguage = (lang: string) => {
    setSelectedLanguage(lang);
    localStorage.setItem('kalamitra_language', lang);
    showToast(`Language set to ${lang}`);
  };

  const updateArtisanProfile = (updated: Partial<ArtisanProfile>) => {
    setArtisanProfile((prev) => {
      const next = { ...prev, ...updated };
      localStorage.setItem('kalamitra_artisan_profile', JSON.stringify(next));
      return next;
    });
  };

  const updateProductStock = (productId: string, delta: number) => {
    setProducts((prev) =>
      prev.map((p) => {
        if (p.id === productId) {
          const newStock = Math.max(0, p.stock + delta);
          showToast(`Updated stock for '${p.title}' to ${newStock}`);
          return { ...p, stock: newStock };
        }
        return p;
      })
    );
  };

  const addProduct = (product: ProductItem) => {
    setProducts((prev) => [product, ...prev]);
  };

  const updateOrderStatus = (orderId: string, status: CraftOrderItem['status']) => {
    setOrders((prev) =>
      prev.map((o) => {
        if (o.id === orderId) {
          return { ...o, status };
        }
        return o;
      })
    );
  };

  return (
    <AppContext.Provider
      value={{
        currentScreen,
        screenHistory,
        selectedLanguage,
        isFromSettings,
        products,
        orders,
        opportunities,
        toastMessage,
        activeTab,
        artisanProfile,
        isEasyMode: false,
        setActiveTab,
        navigateTo,
        goBack,
        setLanguage,
        showToast,
        updateProductStock,
        addProduct,
        updateOrderStatus,
        updateArtisanProfile,
      }}
    >
      {children}
    </AppContext.Provider>
  );
};

export const useApp = () => {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
};
