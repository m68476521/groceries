//
//  FavoriteRow.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/27/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
    @State var obj: ProductModel = ProductModel(dict: [:])
    
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
                    Text(obj.name)
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                    Text("\(obj.unitValue)\(obj.unitName)")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                Text("$\(obj.offerPrice ?? obj.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                Image("next")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    
            }
            Divider()
        }
    }
}

#Preview {
    FavoriteRow()
}
