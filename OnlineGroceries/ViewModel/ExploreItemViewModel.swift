//
//  ExploreItemViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 9/3/26.
//

import SwiftUI
import Combine


class ExploreItemViewModel: ObservableObject {
    
    @Published var obj: ExploreCategoryModel = ExploreCategoryModel(dict: [:])
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [ProductModel] = []
    
    
    init(obj: ExploreCategoryModel) {
        self.obj = obj
        serviceCallList()
    }
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: ["cat_id" : self.obj.id],
            path: Globs.SV_EXPLORE_ITEM_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return ProductModel(dict: obj as? NSDictionary ?? [:])
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
