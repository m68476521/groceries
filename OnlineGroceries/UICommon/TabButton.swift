//
//  TabButton.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/30/26.
//

import SwiftUI

struct TabButton: View {
    @State var title: String = "title"
    @State var icon: String = "store_tab"
    var isSelected: Bool = false
    var didSelect: (() -> ())

    var body: some View {
        Button {
            debugPrint("Tab button tapped")
            didSelect()
        } label: {
            VStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)

                Text(title)
                    .font(.customfont(.semibold, fontSize: 14))
            }
        }
        .foregroundColor(isSelected ? .primary : .primaryText)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#Preview {
    TabButton {
        print("Test")
    }
}
