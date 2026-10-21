//
//  PaymentViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/21/26.
//

import SwiftUI
import Combine

class PaymentViewModel: ObservableObject {
    static let shared: PaymentViewModel = PaymentViewModel()

    @Published var txtName: String = ""
    @Published var txtCardNumber: String = ""
    @Published var txtCardMonth: String = ""
    @Published var txtCardYear: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    @Published var listArray: [PaymentModel] = []
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList() {
        ServiceCall.post(
            parameter: [:],
            path: Globs.SV_PAYMENT_METHOD_LIST,
            isToken: true
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                
                    self.listArray = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return PaymentModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallRemove(obj: PaymentModel) {
        ServiceCall.post(
            parameter: ["pay_id" : obj.id],
            path: Globs.SV_REMOVE_PAYMENT_METHOD,
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
    
    func serviceCallAdd(didDone: (() ->())? ) {
        ServiceCall.post(
            parameter: ["name" : txtName, "card_ number" : txtCardNumber,
                        "card_month" : txtCardMonth, "card_year" : txtCardYear,],
            path: Globs.SV_ADD_PAYMENT_METHOD,
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
        txtCardNumber = ""
        txtCardYear = ""
        txtCardMonth = ""
    }
    
    func setData(obj: PaymentModel) {
        txtName = obj.name
        txtCardNumber = obj.cardNumber
        txtCardYear = obj.cardYear
        txtCardMonth = obj.cardMonth
    }
}
