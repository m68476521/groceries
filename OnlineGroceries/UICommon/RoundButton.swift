//
//  RoundButton.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/6/26.
//

import SwiftUI

struct RoundButton: View {
    @State var title: String = "Title"
    var didTap: (() -> Void)?
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.primary)
        .cornerRadius(10)
    }
}

#Preview {
    RoundButton()
        .padding(20)
}
