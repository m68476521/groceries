//
//  HomeView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/30/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel.shared
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)

                    HStack {
                        Image("location")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)

                        Text("San Francisco, CA")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.gray)
                    }

                    SearchTextField(
                        placeHolder: "Search Store",
                        txt: $homeVM.txtSearch
                    )
                    .padding(12)

                    Image("banner_top")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 115)
                        .padding(.horizontal, 12)

                    SectionTitleAll(
                        title: "Exclusive offer",
                        titleAll: "See All"
                    ) {

                    }
                    .padding(.horizontal, 20)

                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 15) {
                            ForEach(0...5, id: \.self) { index in
                                ProductCell {

                                }

                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }

                    SectionTitleAll(title: "Best Selling", titleAll: "See All")
                    {

                    }
                    .padding(.horizontal, 12)

                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 15) {
                            ForEach(0...5, id: \.self) { index in
                                ProductCell {

                                }

                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }

                    SectionTitleAll(title: "Groceries", titleAll: "See All") {

                    }
                    .padding(.horizontal, 12)

                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 15) {
                            ForEach(0...5, id: \.self) { index in
                                CategoryCell(color: Color(hex: "F8A44C")) {

                                }

                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, 4)

                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 15) {
                            ForEach(0...5, id: \.self) { index in
                                ProductCell {

                                }

                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, 15)

                }
                .padding(.top, .topInsets)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
