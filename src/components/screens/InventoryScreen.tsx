import React from 'react';
import { Plus, Minus, AlertTriangle, CheckCircle2, PackageCheck } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';

export const InventoryScreen: React.FC = () => {
  const { products, updateProductStock } = useApp();

  const totalUnits = products.reduce((acc, p) => acc + p.stock, 0);
  const lowStockItems = products.filter((p) => p.stock <= 3);

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-12 font-sans">
      <AppBar title="Craft Inventory" />

      <div className="p-4 space-y-4 max-w-2xl mx-auto">
        {/* Inventory Summary Cards */}
        <div className="grid grid-cols-2 gap-3">
          <div className="bg-white p-4 rounded-[24px] border border-gray-100 shadow-xs">
            <div className="flex items-center gap-2 text-gray-400 mb-1">
              <PackageCheck size={16} />
              <span className="text-xs font-semibold">Total Units</span>
            </div>
            <p className="text-2xl font-bold text-gray-900">{totalUnits} In Stock</p>
          </div>

          <div className="bg-white p-4 rounded-[24px] border border-gray-100 shadow-xs">
            <div className="flex items-center gap-2 text-[#B45309] mb-1">
              <AlertTriangle size={16} />
              <span className="text-xs font-semibold">Low Stock</span>
            </div>
            <p className="text-2xl font-bold text-[#B45309]">{lowStockItems.length} Products</p>
          </div>
        </div>

        {/* Product Stock List */}
        <div className="space-y-3">
          <h2 className="font-bold text-gray-900 text-base">
            Live Artisan Stock & Adjustments
          </h2>

          {products.map((prod) => {
            const isLowStock = prod.stock <= 3;

            return (
              <div
                key={prod.id}
                className={`bg-white border-2 rounded-[24px] p-4 transition-all shadow-xs ${
                  isLowStock ? 'border-[#B45309]/40' : 'border-gray-100 hover:border-[#B45309]/40'
                }`}
              >
                <div className="flex items-center gap-3.5">
                  <img
                    src={prod.imageUrl}
                    alt={prod.title}
                    className="w-16 h-16 rounded-2xl object-cover border border-gray-100 shrink-0"
                  />

                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-1.5">
                      <span className="text-[10px] font-bold uppercase text-gray-400">
                        {prod.category}
                      </span>
                      {isLowStock ? (
                        <span className="bg-amber-100 text-amber-800 text-[10px] font-bold px-1.5 py-0.5 rounded-full flex items-center gap-0.5">
                          <AlertTriangle size={10} /> Low
                        </span>
                      ) : (
                        <span className="bg-green-100 text-green-800 text-[10px] font-bold px-1.5 py-0.5 rounded-full flex items-center gap-0.5">
                          <CheckCircle2 size={10} /> Good
                        </span>
                      )}
                    </div>

                    <h3 className="font-bold text-gray-900 truncate text-sm">
                      {prod.title}
                    </h3>
                    <p className="text-xs font-semibold text-gray-500">₹{prod.price.toLocaleString()}</p>
                  </div>
                </div>

                {/* Stock Quick Adjustment Row */}
                <div className="mt-3 pt-3 border-t border-gray-100 flex items-center justify-between">
                  <span className="text-xs font-medium text-gray-500">Available Stock:</span>

                  <div className="flex items-center gap-3">
                    {/* Minus Button */}
                    <button
                      type="button"
                      onClick={() => updateProductStock(prod.id, -1)}
                      className="w-9 h-9 rounded-xl bg-gray-100 hover:bg-gray-200 text-gray-800 flex items-center justify-center font-bold active:scale-90 transition-all cursor-pointer"
                    >
                      <Minus size={16} className="stroke-[3]" />
                    </button>

                    {/* Stock Value */}
                    <span className={`font-bold text-center min-w-[36px] text-lg text-gray-900 ${isLowStock ? 'text-amber-600' : ''}`}>
                      {prod.stock}
                    </span>

                    {/* Plus Button */}
                    <button
                      type="button"
                      onClick={() => updateProductStock(prod.id, 1)}
                      className="w-9 h-9 rounded-xl bg-[#B45309] hover:bg-[#92400E] text-white flex items-center justify-center font-bold active:scale-90 transition-all cursor-pointer"
                    >
                      <Plus size={16} className="stroke-[3]" />
                    </button>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};
