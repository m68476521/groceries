//
//  ExploreViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/29/26.
//

import Combine
import Foundation

class ExploreViewModel: ObservableObject {
    static var shared: ExploreViewModel = ExploreViewModel()

    @Published var txtSearch: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [ExploreCategoryModel] = []
    
    init() {
        serviceCallList()
    }
 
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_EXPLORE_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return ExploreCategoryModel(dict: obj as? NSDictionary ?? [:])
                        })

                } else {
                    
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = false
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
}



