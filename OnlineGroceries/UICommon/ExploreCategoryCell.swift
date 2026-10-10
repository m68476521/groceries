//
//  ExploreCategoryCell.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/29/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreCategoryCell: View {
    @State var obj: ExploreCategoryModel = ExploreCategoryModel(dict:[:])


    var body: some View {
        VStack {

            WebImage(url: URL(string: obj.image)) { image in
                    image.resizable()
                }
                placeholder: {
                    Color.gray.opacity(0.3)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 120, height: 90)
            
            Spacer()

            Text(obj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

            Spacer()
        }
        .padding(15)
        .background(obj.color.opacity(0.3))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(obj.color, lineWidth: 1)
        )

    }
}

#Preview {
    ExploreCategoryCell(obj: ExploreCategoryModel(dict: [
        "color" : "F8A44C",
        "image" : "http://localhost:3001/img/type/202307261610181018aVOpgmY1W1.png",
        "cat_id" : 1,
        "cat_name" : "Pulses"
    ])).padding(20)
}
