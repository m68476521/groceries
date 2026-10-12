//
//  AccountRaw.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/9/26.
//

import SwiftUI

struct AccountRaw: View {
    @State var title: String = "Title"
    @State var icon: String = "a_order"
    
    var body: some View {
        VStack {

            HStack(spacing: 15) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Image("next")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                
            }
            .padding( 20)
            Divider()
        }
    }
}

#Preview {
    AccountRaw()
}
