//
//  MainTabView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/29/26.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var homeVM = HomeViewModel.shared

    var body: some View {
        ZStack {
            if (homeVM.selectTab == 0) {
                HomeView()
            } else if (homeVM.selectTab == 1) {
                ExploreView()
            } else if (homeVM.selectTab == 2) {
                MyCartView()
            } else if (homeVM.selectTab == 3) {
                FavoriteView()
            } else if (homeVM.selectTab == 4) {
                AccountView()
            }
            
            VStack {
                Spacer()
                HStack {
                    TabButton(
                        title: "Shop",
                        icon: "store_tab",
                        isSelected: homeVM.selectTab == 0
                    ) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 0
                            }
                        }
                    }

                    TabButton(
                        title: "Explore",
                        icon: "explore_tab",
                        isSelected: homeVM.selectTab == 1
                    ) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 1
                            }
                        }
                    }

                    TabButton(
                        title: "Cart",
                        icon: "cart_tab",
                        isSelected: homeVM.selectTab == 2
                    ) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 2
                            }
                        }
                    }

                    TabButton(
                        title: "Favorite",
                        icon: "fav_tab",
                        isSelected: homeVM.selectTab == 3
                    ) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 3
                            }
                        }
                    }

                    TabButton(
                        title: "Account",
                        icon: "account_tab",
                        isSelected: homeVM.selectTab == 4
                    ) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 4
                            }
                        }
                    }

                }
                .padding(.top, 10)
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
            }
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    MainTabView()
}
