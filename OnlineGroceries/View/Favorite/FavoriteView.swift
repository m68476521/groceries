//
//  FavoriteView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/26/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
    
    @StateObject var favVM = FavoritesViewModel.shared
    var body: some View {
        ZStack {
            
            ScrollView {
                LazyVStack {
                    ForEach(favVM.listArray, id: \.id, content: { obj in
                       FavoriteRow(obj: obj)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            
            VStack {
                HStack {
                    
                    Spacer()
                    Text("Favorites")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2) ,radius: 2)
                
                Spacer()
                
                RoundButton(title: "Add all to cart")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 70)
            
            }
            
        }
        .onAppear {
            favVM.serviceCallList()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

#Preview {
    FavoriteView()
}
