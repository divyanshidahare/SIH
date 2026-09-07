import React, { useState } from 'react';
import { Search, Plus, Share2, Tag, ShieldCheck, Download } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';
import { BottomNav } from '../BottomNav';
import { ProductItem } from '../../types';

export const CatalogScreen: React.FC<{ isRootTab?: boolean }> = ({ isRootTab = false }) => {
  const { products, navigateTo, showToast } = useApp();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [selectedProduct, setSelectedProduct] = useState<ProductItem | null>(null);

  const categories = ['All', 'Handloom Weaving', 'Terracotta Pottery', 'Woodcraft', 'Block Printing', 'Metal Craft'];

  const filteredProducts = products.filter((p) => {
    const matchesSearch =
      p.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      p.titleHindi.toLowerCase().includes(searchQuery.toLowerCase()) ||
      p.tags.some((t) => t.toLowerCase().includes(searchQuery.toLowerCase()));
    const matchesCat = selectedCategory === 'All' || p.category === selectedCategory;
    return matchesSearch && matchesCat;
  });

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-24 font-sans">
      <AppBar
        title="My Digital Catalog"
        showBackButton={!isRootTab}
        actions={
          <button
            onClick={() => showToast("Exported PDF catalog with QR code for buyers!")}
            className="p-2 rounded-xl bg-white border border-gray-100 text-gray-800 hover:bg-gray-50 shadow-xs"
            title="Download PDF Catalog"
          >
            <Download size={18} />
          </button>
        }
      />

      <div className="p-4 space-y-4">
        {/* Search Bar */}
        <div className="relative">
          <Search size={18} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search craft, silk, terracotta, GI tag..."
            className="w-full bg-white border border-gray-100 rounded-2xl pl-10 pr-4 py-2.5 text-sm font-semibold text-gray-800 focus:border-[#B45309] outline-none shadow-xs"
          />
        </div>

        {/* Category Horizontal Filter */}
        <div className="flex gap-2 overflow-x-auto pb-1 no-scrollbar">
          {categories.map((cat) => (
            <button
              key={cat}
              onClick={() => setSelectedCategory(cat)}
              className={`px-3.5 py-1.5 rounded-full text-xs font-bold whitespace-nowrap transition-all ${
                selectedCategory === cat
                  ? 'bg-gray-900 text-white shadow-xs'
                  : 'bg-white border border-gray-100 text-gray-600 hover:border-[#B45309]/40'
              }`}
            >
              {cat}
            </button>
          ))}
        </div>

        {/* Catalog Items Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {filteredProducts.map((prod) => (
            <div
              key={prod.id}
              onClick={() => setSelectedProduct(prod)}
              className="bg-white border border-gray-100 hover:border-[#B45309] rounded-[24px] overflow-hidden shadow-xs hover:shadow-md transition-all cursor-pointer group"
            >
              <div className="relative aspect-video w-full overflow-hidden bg-gray-50">
                <img
                  src={prod.imageUrl}
                  alt={prod.title}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                />
                <span className="absolute top-2.5 left-2.5 bg-white/90 backdrop-blur-xs text-gray-900 text-[10px] font-bold px-2.5 py-1 rounded-full border border-gray-100">
                  {prod.category}
                </span>
                <span className="absolute bottom-2.5 right-2.5 bg-[#B45309] text-white text-xs font-bold px-3 py-1 rounded-full shadow-sm">
                  ₹{prod.price.toLocaleString()}
                </span>
              </div>

              <div className="p-4">
                <h3 className="font-bold text-gray-900 line-clamp-1 text-sm">
                  {prod.title}
                </h3>
                <p className="text-xs font-medium text-gray-500 line-clamp-1 mt-0.5">
                  {prod.titleHindi}
                </p>

                <div className="flex items-center justify-between mt-3 pt-2.5 border-t border-gray-100 text-xs text-gray-500 font-medium">
                  <span className="flex items-center gap-1 text-[#B45309] font-bold">
                    <ShieldCheck size={14} />
                    GI Authenticated
                  </span>
                  <span>Stock: {prod.stock}</span>
                </div>
              </div>
            </div>
          ))}
        </div>

        {filteredProducts.length === 0 && (
          <div className="text-center py-12 bg-white rounded-2xl border border-dashed border-gray-200 p-6">
            <p className="font-bold text-gray-500 text-sm">No crafts found matching your search</p>
            <button
              onClick={() => navigateTo('upload_product')}
              className="mt-3 bg-[#B45309] hover:bg-[#92400E] text-white font-bold px-4 py-2 rounded-xl text-xs inline-flex items-center gap-1.5 transition-all"
            >
              <Plus size={14} /> Digitize New Craft
            </button>
          </div>
        )}
      </div>

      {/* Product Detail Modal */}
      {selectedProduct && (
        <div className="fixed inset-0 bg-black/50 z-50 flex items-end sm:items-center justify-center p-0 sm:p-4 backdrop-blur-xs">
          <div className="bg-white w-full max-w-md rounded-t-3xl sm:rounded-3xl max-h-[85vh] overflow-y-auto p-6 space-y-4 animate-slide-up">
            <div className="relative aspect-video rounded-2xl overflow-hidden border border-gray-100">
              <img src={selectedProduct.imageUrl} alt={selectedProduct.title} className="w-full h-full object-cover" />
            </div>

            <div className="flex justify-between items-start">
              <div>
                <span className="text-xs font-bold text-[#B45309] uppercase tracking-wider">{selectedProduct.category}</span>
                <h3 className="font-black text-[#1F2937] text-lg">{selectedProduct.title}</h3>
                <p className="text-xs font-bold text-gray-500">{selectedProduct.titleHindi}</p>
              </div>
              <span className="text-xl font-black text-[#1F2937]">₹{selectedProduct.price.toLocaleString()}</span>
            </div>

            <p className="text-xs text-gray-600 font-medium leading-relaxed bg-gray-50 p-3 rounded-xl">
              {selectedProduct.description}
            </p>

            <div className="flex flex-wrap gap-1.5">
              {selectedProduct.tags.map((t, idx) => (
                <span key={idx} className="bg-[#FEF3C7] text-[#B45309] text-xs font-bold px-2.5 py-0.5 rounded-md flex items-center gap-1">
                  <Tag size={12} /> {t}
                </span>
              ))}
            </div>

            <div className="grid grid-cols-2 gap-3 pt-2">
              <button
                onClick={() => {
                  showToast("Copied buyer catalog link to clipboard!");
                  setSelectedProduct(null);
                }}
                className="bg-[#25D366] text-white font-bold py-3 rounded-xl text-xs flex items-center justify-center gap-2"
              >
                <Share2 size={16} /> Share on WhatsApp
              </button>
              <button
                onClick={() => setSelectedProduct(null)}
                className="bg-gray-100 text-[#1F2937] font-bold py-3 rounded-xl text-xs"
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
