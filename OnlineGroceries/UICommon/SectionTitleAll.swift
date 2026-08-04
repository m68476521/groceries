//
//  SectionTitleAll.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/31/26.
//

import SwiftUI

struct SectionTitleAll: View {
    @State var title: String = "Title"
    @State var titleAll: String = "Title All"
    var didTap: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.primaryText)

            Spacer()

            Text(titleAll)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.primary)
        }
        .frame(height: 40)
    }
}

#Preview {
    SectionTitleAll()
        .padding(20)
}
