//
//  ProductCell.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/31/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCell: View {
    @State var obj: ProductModel = ProductModel(dict: [:])
    var didAddCart: (() -> Void)?
    var body: some View {
        NavigationLink {
            ProductDetailsView(detailVM: ProductDetailViewModel(prodObj: obj))
        } label: {
            //            Image("add")
            //                .resizable()
            //                .scaledToFit()
            //                .frame(width: 15, height: 15)
            //        }
            //        .frame(width: 40, height: 40)
            //        .background(Color.primary)
            //        .cornerRadius(15)
            
            VStack {
                
                WebImage(url: URL(string: obj.image)) { image in
                    image.resizable()
                }
                placeholder: {
                    Color.gray.opacity(0.3)
                }
                .onFailure { error in
                    print("❌ MKE WebImage failed:", error)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 100, height: 80)
                
                
                Spacer()
                
                Text(obj.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(obj.unitValue)\(obj.unitName)")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    Text("$\(obj.offerPrice ?? obj.price, specifier: "%.2f")")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    
                    Spacer()
                    
                    Button {
                        didAddCart?()
                    } label: {
                        Image("add")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.primary)
                    .cornerRadius(15)
                }
            }
            .padding(15)
            .frame(width: 180, height: 230)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

#Preview {
    ProductCell(obj: ProductModel(dict: ["avg_rating" : 0,
                                         "brand_id" : 1,
                                         "cat_id" : 1,
                                         "cat_name" : "Frash Fruits & Vegetable",
                                         "detail" : "Apples contain key nutrients, including fiber and antioxidants. They may offer health benefits, including lowering blood sugar levels and benefitting heart health.",
                                         "image" : "http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
                                         "is_fav" : 0,
                                         "name" : "Red Apple",
                                         "nutrition_weight" : "182g",
                                         "price" : 1.99,
                                         "prod_id" : 6,
                                         "type_id" : 1,
                                         "type_name" : "Pulses",
                                         "unit_name" : "kg",
                                         "unit_value" : "1",]))
}
