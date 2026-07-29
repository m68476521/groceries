//
//  MainTabView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/29/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        MainViewModel.shared.isUserLogin = false
                    } label: {
                        Text("Logout")
                    }
                }
            }
        }.navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
    }
}

#Preview {
    MainTabView()
}
