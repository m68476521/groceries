//
//  ProductDetailsView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/22/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var detailVM: ProductDetailViewModel = ProductDetailViewModel(prodObj: ProductModel(dict: [:]))

    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                        Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                    
                    
                    WebImage(url: URL(string: detailVM.obj.image))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)

                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                VStack {
                    HStack {
                        Text(detailVM.obj.name)
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            detailVM.serviceCallAddRemoveFav()
                        } label: {
                            Image(detailVM.isFav ? "favorite" : "fav")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(Color.secondaryText)
                    }
                    
                    Text("\(detailVM.obj.unitValue)\(detailVM.obj.unitName)")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button {
                            detailVM.addSubQty(isAdd: false)
                        } label: {
                            Image("subtack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        
                        Text("\(detailVM.qty)")
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
                            )
                        
                        Button {
                            detailVM.addSubQty(isAdd: true)
                        } label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        
                        Spacer()
                        Text("$\((detailVM.obj.offerPrice ?? detailVM.obj.price) * Double(detailVM.qty), specifier: "%.2f")" )
                            .font(.customfont(.bold, fontSize: 28))
                            .foregroundColor(.primaryText)
                        
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                VStack {
                    HStack {
                        Text("Product Detail")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            withAnimation {
                                detailVM.showDetails()
                            }
                        } label: {
                            Image(detailVM.isShowDetail ? "detail_open" : "next")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    
                    if (detailVM.isShowDetail) {
                        Text(detailVM.obj.detail)
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                VStack {
                    HStack {
                        Text("Nutritions")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Text(detailVM.obj.nutriotionWeight)
                            .font(.customfont(.semibold, fontSize: 10))
                            .foregroundColor(.secondaryText)
                            .padding(8)
                            .background(Color.placeHolder.opacity(0.5))
                            .cornerRadius(5)
                        
                        Button {
                            withAnimation {
                                detailVM.showNutrition()
                            }
                        } label: {
                            Image(detailVM.isShowNutrition ? "detail_open" : "next")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                                
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    
                    if (detailVM.isShowNutrition) {
                        LazyVStack {
                            ForEach(detailVM.nutritionArray, id: \.id) { obj in
                                HStack {
                                    Text(obj.nutritionName)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.secondaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(obj.nutritionValue)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.primaryText)
                                }
                                
                                Divider()
                            }
                            .padding(.vertical, 0)
                            
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Review")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.orange)
                                .frame(width: 15, height: 15)
                            
                        }
                    }
                    
                    Button {
                        withAnimation {
                            
                        }
                    } label: {
                        Image("next")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(15)
                            
                    }
                    .foregroundColor(Color.primaryText)
                }
                .padding(.horizontal, 20)
                
                RoundButton(title: "Add to Basket") {
                    CartViewModel.shared.serviceCallAddToCart(
                        prodId: detailVM.obj.prodId,
                        qty: detailVM.qty) { isDone, msg in
                            detailVM.qty = 1
                            self.detailVM.errorMessage = msg
                            self.detailVM.showError = true
                        }
                }
                .padding(20)
                
            }
            
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
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("share")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }

                }
                Spacer()

            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $detailVM.showError, content: {
            Alert(title: Text(Globs.appName), message: Text(detailVM.errorMessage), dismissButton: .default(Text("Ok")))
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ProductDetailsView(detailVM: ProductDetailViewModel(prodObj: ProductModel(dict: [
        
            "offer_price": 1.29,
            "start_date": "2026-08-01T00:00:00.000Z",
            "end_data": "2026-09-30T00:00:00.000Z",
            "prod_id": 6,
            "cat_id": 1,
            "brand_id": 1,
            "type_id": 1,
            "name": "Red Apple",
            "detail": "Apples contain key nutrients, including fiber and antioxidants. They may offer health benefits, including lowering blood sugar levels and benefitting heart health.",
            "unit_name": "kg",
            "unit_value": "1",
            "nutrition_weight": "182g",
            "price": 1.99,
            "image": "http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
            "cat_name": "Frash Fruits & Vegetable",
            "type_name": "Pulses",
            "is_fav": 0,
            "avg_rating": 0
        
    ])))
}
