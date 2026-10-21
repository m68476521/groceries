//
//  PromoCodeView.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 10/19/26.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @StateObject var promoVM = PromoCodeViewModel.shared

    var body: some View {
        ZStack {

            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(
                        promoVM.listArray,
                        id: \.id,
                        content: { obj in

                            VStack {
                                HStack {
                                    Text(obj.title)
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(
                                            minWidth: 0,
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )

                                    Text(obj.code)
                                        .font(.customfont(.bold, fontSize: 12))
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(
                                            Color.secondaryText.opacity(0.3)
                                        )
                                        .cornerRadius(5)

                                }

                                Text(obj.description)
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )

                                HStack {
                                    Text("Expiration Date: ")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .padding(.vertical, 8)

                                    Text(
                                        obj.endDate.displayDate(
                                            format: "yyyy-MM-dd hh:mm a"
                                        )
                                    )
                                    .font(.customfont(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .multilineTextAlignment(.leading)
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                }

                            }
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.15), radius: 2)

                        }
                    )
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }

            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }

                    Spacer()
                    Text("Promo Code")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                    //                    Button {
                    //                        mode.wrappedValue.dismiss()
                    //                    } label: {
                    //                        Image("add_temp")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: 20, height: 20)
                    //                    }.foregroundColor(.primaryText)

                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)

                Spacer()
            }

        }
        .onAppear {
            promoVM.serviceCallList()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    PromoCodeView()
}
