//
//  MainViewModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/7/26.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    static let shared: MainViewModel = MainViewModel()

    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false

    @Published var showError: Bool = false
    @Published var errorMessage = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])

    // MARK: ServiceCall

    init() {
        if Utils.UDValueBool(key: Globs.userLogin) {
            // Use logIn
            self.setUserData(
                uDict: Utils.UDValue(key: Globs.userPayload) as? NSDictionary
                    ?? [:]
            )
        } else {
            // USer not login
        }

        //        txtUsername = "user4"
        //        txtEmail = "test@test.com"
        //        txtPassword = "123456"
    }
    
    func logout() {
        Utils.UDSET(data: false, key: Globs.userLogin)
        isUserLogin = false 
    }

    func serviceCallLogin() {

        if !txtEmail.isValidEmail {
            self.errorMessage = "Please enter a valid email address"
            self.showError = true
            return
        }

        if txtPassword.isEmpty {
            self.errorMessage = "Please enter a valid password"
            self.showError = true
            return
        }
        ServiceCall.post(
            parameter: [
                "email": txtEmail, "password": txtPassword,
                "dervice_token": "test123",
            ],
            path: Globs.SV_LOGIN
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                let statusValue = "\(response.value(forKey: KKey.status) ?? "")"
                if statusValue == "1" {
                    print(response)

                    self.setUserData(
                        uDict: response.value(forKey: KKey.payload)
                            as? NSDictionary ?? [:]
                    )

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

    func serviceCallSignUp() {
        print("serviceCallSingUp")

        if txtUsername.isEmpty {
            self.errorMessage = "Please enter a valid username"
            self.showError = true
            return
        }

        if !txtEmail.isValidEmail {
            self.errorMessage = "Please enter a valid email address"
            self.showError = true
            return
        }

        if txtPassword.isEmpty {
            self.errorMessage = "Please enter a valid password"
            self.showError = true
            return
        }

        ServiceCall.post(
            parameter: [
                "username": txtUsername,
                "email": txtEmail,
                "password": txtPassword,
                "dervice_token": "test123",
            ],
            path: Globs.SV_SIGN_UP
        ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    print("MKE::: \(response)")
                    debugPrint("MKE22", response)
                    self.setUserData(
                        uDict: response.value(forKey: KKey.payload)
                            as? NSDictionary ?? [:]
                    )

                } else {
                    print("MKE51")
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

    func setUserData(uDict: NSDictionary) {
        var payload = uDict
        Utils.UDSET(data: payload, key: Globs.userPayload)
        Utils.UDSET(data: true, key: Globs.userLogin)

        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true

        self.txtUsername = ""
        self.txtEmail = ""
        self.txtPassword = ""
        self.isShowPassword = false
    }
}
