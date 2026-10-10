//
//  CartItemRaw.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/2/26.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartItemRaw: View {
        @State var obj: CartItemModel = CartItemModel(dict: [:])
        
        var body: some View {
            VStack {
                HStack(spacing: 15) {
                    WebImage(url: URL(string: obj.image)) { image in
                            image.resizable()
                        }
                        placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .onFailure { error in
                            print(" WebImage failed:", error)
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    VStack(spacing: 4){
                        
                        HStack {
                            Text(obj.name)
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                CartViewModel.shared.serviceCallRemoveFromCart(obj: obj)
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }

                        Text("\(obj.unitValue)\(obj.unitName)")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        HStack {
                            
                            Button {
                                var newQty = obj.qty - 1
                                CartViewModel.shared.serviceCallUpdateQty(obj: obj, newQty: newQty)
                            } label: {
                                Image("subtack")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
                            )
                            
                            Text("\(obj.qty)")
                                .font(.customfont(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                                .frame(width: 45, height: 45, alignment: .center)
                            
                            
                            Button {
                                var newQty = obj.qty + 1
                                CartViewModel.shared.serviceCallUpdateQty(obj: obj, newQty: newQty)
                            } label: {
                                Image("add_green")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
                            )
                            
                            Spacer()
                            
                            Text("$\(obj.offerPrice ?? obj.price, specifier: "%.2f")")
                                .font(.customfont(.semibold, fontSize: 20))
                                .foregroundColor(.primaryText)
                        }
                    }
        
                        
                }
                Divider()
            }
        }
    }
    

#Preview {
    CartItemRaw(
        obj: CartItemModel(dict: [
            "cart_id": 39,
            "user_id": 5,
            "prod_id": 6,
            "qty": 1,
            "cat_id": 1,
            "brand_id": 1,
            "type_id": 1,
            "name": "Red Apple",
            "detail": "Apples contain key nutrients, including fiber and antioxidants. They may offer health benefits, including lowering blood sugar levels and benefitting heart health.",
            "unit_name": "kg",
            "unit_value": "1",
            "nutrition_weight": "182g",
            "price": 1.99,
            "created_date": "2023-07-31T09:51:36.000Z",
            "modify_date": "2023-07-31T09:51:36.000Z",
            "cat_name": "Frash Fruits & Vegetable",
            "is_fav": 0,
            "brand_name": "bigs",
            "type_name": "Pulses",
            "offer_price": 1.99,
            "start_date": "",
            "end_date": "",
            "is_offer_active": 0,
            "image": "http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
            "item_price": 1.99,
            "total_price": 1.99
    ]))
    .padding(.horizontal, 20)
}

