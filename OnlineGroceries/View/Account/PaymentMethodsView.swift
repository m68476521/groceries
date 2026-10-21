//
//  PaymentMethodsView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/21/26.
//

import SwiftUI

struct PaymentMethodsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var paymentVM = PaymentViewModel.shared
    
    var body: some View {
        ZStack {
            
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(paymentVM.listArray, id: \.id, content: { obj in
                        
                        HStack(spacing: 15) {
                            Image("paymenth_methods")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            VStack(spacing: 4) {
                                
                                
                                Text(obj.name)
                                    .font(.customfont(.medium, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text("**** **** **** \(obj.cardNumber)")
                                    .font(.customfont(.bold, fontSize: 15 ))
                                    .foregroundColor(.primary )
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                                
                            Button {
                                paymentVM.serviceCallRemove(obj: obj)
                            } label: {
                                Image("close")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            Spacer()
                         
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    Text("Payment Methods")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
//                    NavigationLink {
//                        AddDeliveryAddressView(isEdit: true, editObj: obj)
//                    } label: {
//                        Image(systemName: "add_temp")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(.primary)
//                    }
//                    .foregroundColor(.primaryText)
//                    .padding(.bottom, 8)

                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2) ,radius: 2)
            
                Spacer()
            }
            
        }
        .onAppear {
//            paymentVM.serviceCallList()
        }
        .alert(isPresented: $paymentVM.showError , content: {
            Alert(title: Text(Globs.appName), message: Text(paymentVM.errorMessage))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    PaymentMethodsView()
}
