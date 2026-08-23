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
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    @Published var offerArray: [ProductModel] = []
    @Published var bestArray: [ProductModel] = []
    @Published var listArray: [ProductModel] = []
    @Published var typeArray: [TypeModel] = []
    
    init() {
        print("MKE 100")
        serviceCallList()
    }
 
    //MARK: ServiceCall
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_HOME,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    print("MKE HVM::: \(response)")
                    debugPrint("MKE22 HVM ", response)
                    if let payloadObjt = response.value(forKey: KKey.payload) as? NSDictionary {
                        self.offerArray = (payloadObjt.value(forKey: "offer_list") as? NSArray ?? []).map({ obj in
                            return ProductModel(dict: obj as? NSDictionary ?? [:])
                        })
                        
                        self.bestArray = (payloadObjt.value(forKey: "best_sell_list") as? NSArray ?? []).map({ obj in
                            return ProductModel(dict: obj as? NSDictionary ?? [:])
                        })
                        
                        self.listArray = (payloadObjt.value(forKey: "list") as? NSArray ?? []).map({ obj in
                            return ProductModel(dict: obj as? NSDictionary ?? [:])
                        })
                        
                        self.typeArray = (payloadObjt.value(forKey: "type_list") as? NSArray ?? []).map({ obj in
                            return TypeModel(dict: obj as? NSDictionary ?? [:])
                        })
                    }
                    
                    

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
