//
//  MainViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/7/26.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    
    // MARK: ServiceCall
    
    func serviceCallLoginn() {
        print("MKE1")
//        if (txtEmail.isEmpty) {
//            self.errorMessage = "Please enter a valid email address"
//            self.showError = true
//            print("MKE2")
//            return
//        }
        
        if (!txtEmail.isValidEmail) {
            self.errorMessage = "Please enter a valid email address"
            self.showError = true
            print("MKE2")
            return
        }
        
        if (txtPassword.isEmpty) {
            print("MKE3")
            self.errorMessage = "Please enter a valid password"
            self.showError = true
            return
        }
        print("MKE4")
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtPassword], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? NSDictionary {
                if  response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    print(response)
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showError = true
                } else {
                    print("MKE51")
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = false
                }
            }
        } failure: { error in
            print("MKE52")
            debugPrint("MKE", error?.localizedDescription)
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
}
