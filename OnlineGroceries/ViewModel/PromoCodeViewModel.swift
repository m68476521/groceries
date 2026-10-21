//
//  PromoCodeViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/19/26.
//


import Combine
import SwiftUI

class PromoCodeViewModel: ObservableObject {
    static let shared: PromoCodeViewModel = PromoCodeViewModel()
    
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [PromoCodeModel] = []
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_PROMO_CODE_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return PromoCodeModel(dict: obj as? NSDictionary ?? [:])
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
