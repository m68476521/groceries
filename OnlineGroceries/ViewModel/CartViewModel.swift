//
//  CartViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 9/11/26.
//

import Combine
import SwiftUI


class CartViewModel: ObservableObject {
    static let shared: CartViewModel = CartViewModel()

    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [CartItemModel] = []
    @Published var total : String = "0.0"
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_CART_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.total = response.value(forKey: "total") as? String ?? "0.0"
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return CartItemModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallAddToCart(prodId: Int, qty: Int, didDone: ((_ isDone: Bool, _ message: String) ->())? ) {
        ServiceCall.post(
            parameter: ["prod_id" : prodId, "qty" : qty ],
            path: Globs.SV_ADD_CART,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    didDone?(true, response.value(forKey: KKey.message) as? String ?? "Done")
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Success"
                    self.showError = true
                } else {
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = true
                    didDone?(false, response.value(forKey: KKey.message) as? String ?? "Fail")
                }
            }
        } failure: { error in
            didDone?(false, error?.localizedDescription ?? "Fail")
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallUpdateQty(obj: CartItemModel, newQty: Int) {
        ServiceCall.post(
            parameter: ["cart_id" : obj.cartId, "prod_id" : obj.prodId, "new_qty": newQty],
            path: Globs.SV_UPDATE_CART,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.serviceCallList()
                    
                } else {
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallRemoveFromCart(obj: CartItemModel) {
        ServiceCall.post(
            parameter: ["cart_id" : obj.cartId, "prod_id" : obj.prodId],
            path: Globs.SV_REMOVE_CART,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                
//                    self.errorMessage =
//                        response.value(forKey: KKey.message) as? String
//                        ?? "Success"
//                    self.showError = true
                    
                    self.serviceCallList()
                    
                } else {
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
}
