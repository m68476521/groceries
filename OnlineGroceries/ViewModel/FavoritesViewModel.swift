//
//  FavoritesViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/26/26.
//

import SwiftUI
import Combine


class FavoritesViewModel: ObservableObject {
    static var shared: FavoritesViewModel = FavoritesViewModel()

    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [ProductModel] = []
    
    init() {
        print("MKE 100")
        serviceCallList()
    }
 
    //MARK: ServiceCall
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_FAVORITE_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    print("MKE HVM::: \(response)")
                    debugPrint("MKE22 HVM ", response)
                          
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return ProductModel(dict: obj as? NSDictionary ?? [:])
                        })

                } else {
                    print("MKE51 HVM")
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = false
                }
            }
        } failure: { error in
            print("MKE 200")
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }

}
