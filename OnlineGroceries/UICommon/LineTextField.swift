//
//  LineTextField.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/7/26.
//

import SwiftUI

struct LineTextField: View {
    @State var title: String = "Title"
    @State var placeHolder: String = "placeholder"
    @Binding var txt: String
    @State var keyboardType: UIKeyboardType  = .default
    
    var body: some View {
        VStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor( .textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            TextField(placeHolder, text: $txt)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 40)
            
            Divider()
                
        }
    }
}

struct LineSecureField: View {
    @State var title: String = "Title"
    @State var placeHolder: String = "placeholder"
    
    @Binding var txt: String
    @Binding var isShowPassword: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor( .textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            if (isShowPassword) {
                TextField(placeHolder, text: $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .frame(height: 40)
            } else {
                SecureField(placeHolder, text: $txt)
                    .autocapitalization(.none)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .frame(height: 40)
            }
            
            Divider()
        }
    }
}

#Preview {
    @State var txt: String = ""
    LineTextField(txt: $txt)
        .padding(20)
}
