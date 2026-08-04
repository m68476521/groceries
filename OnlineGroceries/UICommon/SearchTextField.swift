//
//  SearchTextField.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/31/26.
//

import SwiftUI

struct SearchTextField: View {

    @State var placeHolder: String = "placeholder"
    @Binding var txt: String

    var body: some View {
        HStack(spacing: 15) {
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

            TextField(placeHolder, text: $txt)
                .font(.customfont(.regular, fontSize: 16))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)

        }
        .frame(height: 30)
        .padding(15)
        .background(Color(hex: "F2F2F2"))
        .cornerRadius(16)
    }
}

#Preview {
    @State var txt: String = ""
    SearchTextField(placeHolder: "Search Store", txt: $txt)
        .padding(15)
}
