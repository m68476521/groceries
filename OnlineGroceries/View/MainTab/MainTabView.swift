//
//  MainTabView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/29/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var homeVM = HomeViewModel.shared

    var body: some View {
        VStack {
            TabView(selection: $homeVM.selectTab) {
                HomeView().tag(0)
                ExploreView().tag(1)
                ExploreView().tag(2)
                ExploreView().tag(3)
                ExploreView().tag(4)
            }

            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: homeVM.selectTab) { newValue in
                debugPrint("Selected tab: \(newValue)")
            }

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
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    MainTabView()
}
