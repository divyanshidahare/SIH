export type ScreenName =
  | 'splash'
  | 'onboarding'
  | 'language'
  | 'login'
  | 'profile_setup'
  | 'home'
  | 'upload_product'
  | 'catalog'
  | 'inventory'
  | 'orders'
  | 'help'
  | 'opportunities'
  | 'collaboration'
  | 'growth'
  | 'profile'
  | 'settings';

export interface ArtisanProfile {
  name: string;
  dob: string;
  address: string;
  specialisation: string;
  phone?: string;
  email?: string;
  artisanId?: string;
  location?: string;
  experience?: string;
}

export interface ProductItem {
  id: string;
  title: string;
  titleHindi: string;
  category: string;
  price: number;
  estimatedCost: number;
  stock: number;
  description: string;
  descriptionHindi: string;
  tags: string[];
  imageUrl: string;
  completionPercentage: number;
  craftType: string;
}

export type OrderStatus = 'new' | 'pending' | 'completed' | 'rejected';

export interface CraftOrderItem {
  id: string;
  buyerName: string;
  buyerType: string;
  productName: string;
  quantity: number;
  totalAmount: number;
  orderDate: string;
  status: OrderStatus;
  deliveryLocation: string;
  phone: string;
}

export interface OpportunityItem {
  id: string;
  title: string;
  organization: string;
  type: 'governmentScheme' | 'tradeFair' | 'ngoGrant';
  deadline: string;
  stipendOrGrant: string;
  description: string;
  eligibility: string[];
  applicationStatus: string;
}
