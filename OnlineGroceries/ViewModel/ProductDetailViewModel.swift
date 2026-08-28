//
//  ProductDetailViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/22/26.
//

import Combine
import SwiftUI


class ProductDetailViewModel: ObservableObject {
    
    @Published var obj: ProductModel = ProductModel(dict: [:])
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var nutritionArray: [NutritionModel] = []
    @Published var imageArray: [ImageModel] = []
    
    @Published var isFav: Bool = false
    @Published var isShowDetail: Bool = false
    @Published var isShowNutrition: Bool = false
    @Published var qty: Int = 1
    
    
    init(prodObj: ProductModel) {
        self.obj = prodObj
        self.isFav = prodObj.isFav
        serviceCallDetail()
    }
    
    func serviceCallDetail() {
        ServiceCall.post(
            parameter: ["prod_id" : self.obj.prodId ],
            path: Globs.SV_PRODUCT_DETAIL,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    if let payloadObjt = response.value(forKey: KKey.payload) as? NSDictionary {
                        
                        self.obj = ProductModel(dict: payloadObjt)
                        
                        self.nutritionArray = (payloadObjt.value(forKey: "nutrition_list") as? NSArray ?? []).map({ obj in
                            return NutritionModel(dict: obj as? NSDictionary ?? [:])
                        })
                        
                        self.imageArray = (payloadObjt.value(forKey: "images") as? NSArray ?? []).map({ obj in
                            return ImageModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallAddRemoveFav() {
        ServiceCall.post(
            parameter: ["prod_id" : self.obj.prodId ],
            path: Globs.SV_ADD_REMOVE_FAVORITE,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.isFav = !self.isFav
                    HomeViewModel.shared.serviceCallList()
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Success"
                    self.showError = true
                } else {
                    print("MKE serviceCallAddRemoveFav")
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            print("MKE serviceCallAddRemoveFav fail")
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func showDetails() {
        isShowDetail = !isShowDetail
    }
    
    func showNutrition() {
        isShowNutrition = !isShowNutrition
    }
    
    func addSubQty(isAdd: Bool = true) {
        if (isAdd) {
            qty += 1
            if (qty > 99) {
                qty = 99
            }
        } else {
            qty -= 1
            if (qty < 1) {
                qty = 1
            }
        }
    }
    
}
