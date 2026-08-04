//
//  CategoryCell.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/4/26.
//

import SwiftUI

struct CategoryCell: View {
    @State var color: Color = Color.yellow
    var didAddCart: (() -> Void)?

    var body: some View {
        HStack {

            Image("pulses")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)

            Text("Pulses")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

        }
        .padding(15)
        .frame(width: 180, height: 100)
        .background(color.opacity(0.3))
        .cornerRadius(16)

    }
}

#Preview {
    CategoryCell()
}
