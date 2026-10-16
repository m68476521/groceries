//
//  AccountView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/7/26.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 15) {
                    Image("u1")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    
                    VStack {
                        HStack {
                            Text("Code for Any")
                                .font(.customfont(.bold, fontSize: 20))
                                .foregroundColor(.primaryText)
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.primary)
                       
                            
                            Spacer()
                        }
                        .padding(.bottom, 2)
                        
                        Text("codeforAny@gmail.com")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                            .accentColor(.secondaryText)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity )
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                Divider()
                
                ScrollView {
                    LazyVStack {
                        VStack {
                            
                            AccountRaw(title: "Orders", icon: "a_order")
                            
                            AccountRaw(title: "My Details", icon: "a_my_detail")
                            
                            NavigationLink {
                                DeliveryAddressView()
                            } label : {
                                AccountRaw(title: "Delivery Address", icon: "a_delivery_address")
                            }
                            
                            AccountRaw(title: "Payment Methos", icon: "paymenth_methods")
                            
                            AccountRaw(title: "Promo Code", icon: "a_promocode")
                        }
                        
                        VStack {
                            AccountRaw(title: "Notifications", icon: "a_noitification")
                            AccountRaw(title: "Help", icon: "a_help")
                            AccountRaw(title: "About", icon: "a_about")
                        }
                        
                        
                        Button {
                            MainViewModel.shared.logout()
                        } label: {
                            ZStack {
                                Text("Log Out")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                HStack {
                                    Spacer()
                                    Image("logout")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                        .background(Color(hex: "F2F3F2"))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15 )
                       
                    }
                }
            }
            .padding(.bottom, .bottomInsets + 60)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView{
        AccountView()
    }
}
