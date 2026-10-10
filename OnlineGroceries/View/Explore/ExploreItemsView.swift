//
//  ExploreItemsView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 9/3/26.
//

import SwiftUI

struct ExploreItemsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var itemsVM = ExploreItemViewModel(obj: ExploreCategoryModel(dict: [:]))
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Text(itemsVM.obj.name)
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        
                    } label: {
                        Image("filter_ic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }

                }
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(itemsVM.listArray, id:\.id) { item in
                            ProductCell(obj: item, width: .infinity) {
                                CartViewModel.shared.serviceCallAddToCart(
                                    prodId: item.id,
                                   qty: 1) { isDone, msg in
                                       self.itemsVM.errorMessage = msg
                                       self.itemsVM.showError = true
                                }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }

            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $itemsVM.showError, content: {
            Alert(title: Text(Globs.appName),
                  message: Text(itemsVM.errorMessage),
                  dismissButton: .default(Text("OK")))
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ExploreItemsView(
        itemsVM: ExploreItemViewModel(obj: ExploreCategoryModel(dict: [
            "cat_id": 1,
            "cat_name": "Frash Fruits & Vegetable",
            "image": "http://localhost:3001/img/category/20230726155407547qM5gSxkrCh.png",
            "color": "53B175"
        ]))
    )
}
