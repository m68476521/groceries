//
//  ExploreView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/30/26.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var exploreVM = ExploreViewModel.shared
    @State var txtSearch: String = ""
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Find Products")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                
                SearchTextField(placeHolder: "Search Store", txt: $txtSearch)
                    .padding(.horizontal,20)
                    .padding(.bottom, 4)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(exploreVM.listArray, id: \.id) { item in
                            
                            NavigationLink(
                                destination: ExploreItemsView(itemsVM: ExploreItemViewModel(obj: item)
                            )) {
                                ExploreCategoryCell(obj: item)
                                    .aspectRatio(0.95, contentMode: .fill)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom,.bottomInsets + 60)
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        ExploreView()
    }

}
