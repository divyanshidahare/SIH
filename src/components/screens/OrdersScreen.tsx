import React, { useState } from 'react';
import { ShoppingBag, CheckCircle, Clock, MapPin, Phone, Truck, XCircle } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { AppBar } from '../AppBar';
import { OrderStatus } from '../../types';

export const OrdersScreen: React.FC = () => {
  const { orders, updateOrderStatus, showToast } = useApp();
  const [activeFilter, setActiveFilter] = useState<OrderStatus>('new');

  const filteredOrders = orders.filter((o) => {
    if (activeFilter === 'new') return o.status === 'new';
    if (activeFilter === 'pending') return o.status === 'pending';
    return o.status === 'completed' || o.status === 'rejected';
  });

  return (
    <div className="min-h-screen bg-[#FDFDFD] pb-16 font-sans">
      <AppBar title="B2B & Exhibition Orders" />

      <div className="p-4 space-y-4 max-w-2xl mx-auto">
        {/* Status Filter Tabs */}
        <div className="grid grid-cols-3 gap-2 bg-gray-50 border border-gray-100 p-1.5 rounded-full">
          {[
            { id: 'new', label: 'New', count: orders.filter((o) => o.status === 'new').length },
            { id: 'pending', label: 'In Progress', count: orders.filter((o) => o.status === 'pending').length },
            { id: 'completed', label: 'Completed', count: orders.filter((o) => o.status === 'completed').length },
          ].map((tab) => (
            <button
              key={tab.id}
              onClick={() => setActiveFilter(tab.id as OrderStatus)}
              className={`py-2 rounded-full text-xs font-bold transition-all flex items-center justify-center gap-1.5 ${
                activeFilter === tab.id
                  ? 'bg-white text-gray-900 shadow-xs border border-gray-100'
                  : 'text-gray-500 hover:text-gray-900'
              }`}
            >
              <span>{tab.label}</span>
              <span className={`text-[10px] px-2 py-0.5 rounded-full ${
                activeFilter === tab.id ? 'bg-[#B45309] text-white font-bold' : 'bg-gray-200 text-gray-600 font-semibold'
              }`}>
                {tab.count}
              </span>
            </button>
          ))}
        </div>

        {/* Orders List */}
        <div className="space-y-4">
          {filteredOrders.map((ord) => (
            <div
              key={ord.id}
              className="bg-white border border-gray-100 hover:border-[#B45309]/40 rounded-[24px] p-5 shadow-xs space-y-3.5 transition-all"
            >
              {/* Order Header */}
              <div className="flex items-center justify-between">
                <div>
                  <span className="text-[10px] font-bold uppercase text-gray-400">Order #{ord.id}</span>
                  <h3 className="font-bold text-gray-900 text-base">
                    {ord.buyerName}
                  </h3>
                  <p className="text-xs text-gray-500 font-medium">{ord.buyerType}</p>
                </div>

                <div className="text-right">
                  <p className="font-bold text-gray-900 text-lg">
                    ₹{ord.totalAmount.toLocaleString()}
                  </p>
                  <span className={`text-[10px] font-bold uppercase px-2.5 py-0.5 rounded-full ${
                    ord.status === 'new'
                      ? 'bg-[#B45309]/15 text-[#B45309]'
                      : ord.status === 'pending'
                      ? 'bg-blue-100 text-blue-800'
                      : ord.status === 'completed'
                      ? 'bg-green-100 text-green-800'
                      : 'bg-red-100 text-red-800'
                  }`}>
                    {ord.status}
                  </span>
                </div>
              </div>

              {/* Order Item Details */}
              <div className="bg-gray-50 rounded-2xl p-3 text-xs space-y-1">
                <p className="font-bold text-gray-800">
                  {ord.quantity} × {ord.productName}
                </p>
                <div className="flex items-center gap-1.5 text-gray-500">
                  <MapPin size={12} />
                  <span>{ord.deliveryLocation}</span>
                </div>
                <div className="flex items-center gap-1.5 text-gray-500">
                  <Phone size={12} />
                  <span>{ord.phone}</span>
                </div>
              </div>

              {/* Action Buttons */}
              {ord.status === 'new' && (
                <div className="grid grid-cols-2 gap-2 pt-1">
                  <button
                    onClick={() => {
                      updateOrderStatus(ord.id, 'pending');
                      showToast(`Accepted order #${ord.id}! Added to In Progress.`);
                    }}
                    className="bg-[#B45309] hover:bg-[#92400E] text-white font-bold rounded-full flex items-center justify-center gap-1.5 py-2.5 text-xs transition-all active:scale-98 shadow-xs cursor-pointer"
                  >
                    <CheckCircle size={16} />
                    <span>Accept Order</span>
                  </button>

                  <button
                    onClick={() => {
                      updateOrderStatus(ord.id, 'rejected');
                      showToast(`Declined order #${ord.id}`);
                    }}
                    className="bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold rounded-full flex items-center justify-center gap-1.5 py-2.5 text-xs transition-all active:scale-98 cursor-pointer"
                  >
                    <XCircle size={16} />
                    <span>Decline</span>
                  </button>
                </div>
              )}

              {ord.status === 'pending' && (
                <button
                  onClick={() => {
                    updateOrderStatus(ord.id, 'completed');
                    showToast(`Order #${ord.id} marked as dispatched! Payment settlement initiated.`);
                  }}
                  className="w-full bg-[#1F2937] hover:bg-black text-white font-bold rounded-full flex items-center justify-center gap-1.5 py-2.5 text-xs transition-all cursor-pointer active:scale-98"
                >
                  <Truck size={16} />
                  <span>Mark as Dispatched / Completed</span>
                </button>
              )}

              {ord.status === 'completed' && (
                <div className="flex items-center gap-1.5 text-xs font-bold text-green-700 bg-green-50 p-3 rounded-2xl">
                  <CheckCircle size={14} /> Delivered & Settled directly to artisan bank account
                </div>
              )}
            </div>
          ))}

          {filteredOrders.length === 0 && (
            <div className="text-center py-12 bg-white rounded-2xl border border-dashed border-gray-200 p-6">
              <ShoppingBag className="w-10 h-10 text-gray-300 mx-auto mb-2" />
              <p className="font-bold text-gray-500 text-sm">No orders in this status</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};
