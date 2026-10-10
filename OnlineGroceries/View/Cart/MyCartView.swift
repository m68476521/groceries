//
//  MyCartView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/2/26.
//

import SwiftUI

struct MyCartView: View {
    
    @StateObject var cartVM = CartViewModel.shared
    
    var body: some View {
        ZStack{
            if (cartVM.listArray.count == 0) {
                Text("No items in your cart")
                    .font(.customfont(.bold, fontSize: 20))
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(cartVM.listArray, id: \.id, content: { obj in
                       CartItemRaw(obj: obj)
                    })
                    .padding(.vertical, 8)
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            
            VStack {
                HStack {
                    
                    Spacer()
                    Text("My Cart")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2) ,radius: 2)
                
                Spacer()
                
                if (cartVM.listArray.count > 0) {
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Text("Check out")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            HStack {
                                Spacer()
                                Text("$\(cartVM.total)")
                                    .font(.customfont(.semibold, fontSize: 12 ))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.drakGray.opacity(0.2))
                                    .cornerRadius(5)
                            }.padding(.trailing)
                        }
                      
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color.primary)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                    .padding(.bottom, .bottomInsets + 70)
                    
                       
                }
            
            }
            
        }
        .onAppear {
            cartVM.serviceCallList()
        }
        .alert(isPresented: $cartVM.showError, content: {
            Alert(title: Text(Globs.appName),
                  message: Text(cartVM.errorMessage),
                  dismissButton: .default(Text("OK")))
        })
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        MyCartView()
    }
}
