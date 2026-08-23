//
//  CategoryCell.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/4/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCell: View {
    @State var obj: TypeModel = TypeModel(dict:[:])
    @State var color: Color = Color.yellow
    var didAddCart: (() -> Void)?

    var body: some View {
        HStack {

            WebImage(url: URL(string: obj.image)) { image in
                    image.resizable()
                }
                placeholder: {
                    Color.gray.opacity(0.3)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 70, height: 70)

            Text(obj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

        }
        .padding(15)
        .frame(width: 180, height: 100)
        .background(obj.color.opacity(0.3))
        .cornerRadius(16)

    }
}

#Preview {
    CategoryCell(obj: TypeModel(dict: ["color" : "F8A44C",
                                "image" : "http://localhost:3001/img/type/202307261610181018aVOpgmY1W1.png",
                                "type_id" : 1,
                                "type_name" : "Pulses"]))
}
