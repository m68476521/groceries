//
//  HomeViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/30/26.
//
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    static var shared: HomeViewModel = HomeViewModel()

    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""

}
