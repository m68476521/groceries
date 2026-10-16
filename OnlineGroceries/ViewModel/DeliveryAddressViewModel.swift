//
//  DeliveryAddressViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/13/26.
//
import Combine
import SwiftUI

class DeliveryAddressViewModel: ObservableObject {
    static let shared: DeliveryAddressViewModel = DeliveryAddressViewModel()

    @Published var txtName: String = ""
    @Published var txtMobile: String = ""
    @Published var txtAddress: String = ""
    @Published var txtCity: String = ""
    @Published var txtState: String = ""
    @Published var txtPostalCode: String = ""
    @Published var txtTypeName: String = "Home"
    
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [AddressModel] = []
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_ADDRESS_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return AddressModel(dict: obj as? NSDictionary ?? [:])
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
    
//    func serviceCallUpdate(obj: AddressModel, newQty: Int) {
//        ServiceCall.post(
//            parameter: ["cart_id" : obj.cartId, "prod_id" : obj.prodId, "new_qty": newQty],
//            path: Globs.SV_UPDATE_ADDRESS,
//            isToken: true
//        ) { responseObj in
//            if let response = responseObj as? NSDictionary {
//                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
//                    
//                    self.serviceCallList()
//                    
//                } else {
//                    self.errorMessage =
//                        response.value(forKey: KKey.message) as? String
//                        ?? "Fail"
//                    self.showError = true
//                }
//            }
//        } failure: { error in
//            self.errorMessage = error?.localizedDescription ?? "Fail"
//            self.showError = true
//        }
//    }
    
    func serviceCallRemove(obj: AddressModel) {
        ServiceCall.post(
            parameter: ["address_id" : obj.id],
            path: Globs.SV_REMOVE_ADDRESS,
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
    
    func serviceCallAddAddress(didDone: (() ->())? ) {
        ServiceCall.post(
            parameter: ["name" : txtName, "type_name" : txtTypeName,
                        "phone" : txtMobile, "address" : txtAddress,
                        "city" : txtCity, "state" : txtState, "postal_code": txtPostalCode],
            path: Globs.SV_ADD_ADDRESS,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.clearAll()
                    self.serviceCallList()
                    didDone?()
                } else {
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = true
                    didDone?()
                }
            }
        } failure: { error in
            didDone?()
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallUpdateAddress(obj: AddressModel?, didDone: (() ->())? ) {
        ServiceCall.post(
            parameter: ["address_id" : obj?.id ?? "",  "name" : txtName, "type_name" : txtTypeName,
                        "phone" : txtMobile, "address" : txtAddress,
                        "city" : txtCity, "state" : txtState, "postal_code": txtPostalCode],
            path: Globs.SV_UPDATE_ADDRESS,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.clearAll()
                    self.serviceCallList()
                    didDone?()
                } else {
                    self.errorMessage =
                        response.value(forKey: KKey.message) as? String
                        ?? "Fail"
                    self.showError = true
                    didDone?()
                }
            }
        } failure: { error in
            didDone?()
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func clearAll() {
        txtName = ""
        txtMobile = ""
        txtAddress = ""
        txtCity = ""
        txtState = ""
        txtPostalCode = ""
        txtTypeName = ""
    }
    
    func setData(obj: AddressModel) {
        txtName = obj.name
        txtMobile = obj.phone
        txtAddress = obj.address
        txtCity = obj.city
        txtState = obj.state
        txtPostalCode = obj.postalCode
        txtTypeName = obj.typeName
    }
}
