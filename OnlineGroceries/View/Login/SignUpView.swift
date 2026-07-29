//
//  SignUpView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 7/21/26.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var mainVM = MainViewModel.shared
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFit()
                .frame(width: .screenWidth, height: .screenHeight)

            ScrollView {
                VStack {

                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)

                    Text("Sign Up")
                        .font(.customfont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.bottom, 4)

                    Text("Enter your credentials to continue")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.bottom, .screenWidth * 0.12)

                    LineTextField(
                        title: "Username",
                        placeHolder: "Enter your username",
                        txt: $mainVM.txtUsername
                    )
                    .padding(.bottom, .screenWidth * 0.07)

                    LineTextField(
                        title: "Email",
                        placeHolder: "Enter your email address",
                        txt: $mainVM.txtEmail,
                        keyboardType: .emailAddress
                    )
                    .padding(.bottom, .screenWidth * 0.07)

                    LineSecureField(
                        title: "Password",
                        placeHolder: "Enter your password",
                        txt: $mainVM.txtPassword,
                        isShowPassword: $mainVM.isShowPassword
                    )
                    .padding(.bottom, .screenWidth * 0.04)

                    Text("By continuing you are agree to our")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )

                    HStack {
                        Text("Term of Service")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.primary)

                        Text(" and ")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)

                        Text("Privacy Policy")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.primary)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading
                            )

                    }
                    .padding(.bottom, .screenWidth * 0.02)

                    RoundButton(title: "Sign Up") {
                        mainVM.serviceCallSignUp()
                    }.padding(.bottom, .screenWidth * 0.03)

                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack {
                            Text("Already have an account?")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.primaryText)

                            Text("SingIn")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.primary)
                        }
                    }

                    Spacer()
                }
                .padding(.top, .topInsets + 64)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
            }

            VStack {

                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()

                }
                Spacer()

            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(
            isPresented: $mainVM.showError,
            content: {
                Alert(
                    title: Text(Globs.appName),
                    message: Text(mainVM.errorMessage),
                    dismissButton: .default(Text("Ok"))
                )
            }
        )
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}
