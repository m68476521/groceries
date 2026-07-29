//
//  OnlineGroceriesApp.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/6/26.
//

import SwiftUI

@main
struct OnlineGroceriesApp: App {
    @StateObject var mainVM = MainViewModel.shared
    var body: some Scene {
        WindowGroup {

            NavigationView {
                if mainVM.isUserLogin {
                    MainTabView()
                } else {
                    WelcomeView()
                }

            }
        }
    }
}
