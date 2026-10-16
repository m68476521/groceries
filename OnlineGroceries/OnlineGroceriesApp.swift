//
//  OnlineGroceriesApp.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/6/26.
//

import SwiftUI

@main
struct OnlineGroceriesApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @StateObject var mainVM = MainViewModel.shared

    // Bumped once the real safe-area insets are known, so the tree is rebuilt
    // with correct `.topInsets` / `.bottomInsets` values.
    @State private var safeAreaRevision = 0

    var body: some View {
        NavigationView {
            if mainVM.isUserLogin {
                MainTabView()
            } else {
                WelcomeView()
            }
        }
        .id(safeAreaRevision)
        .onAppear {
            // Safe to touch UIKit here: `onAppear` runs outside the view update.
            CGFloat.refreshSafeAreaInsets()
            if safeAreaRevision == 0, CGFloat.cachedSafeAreaInsets != .zero {
                safeAreaRevision = 1
            }
        }
    }
}
