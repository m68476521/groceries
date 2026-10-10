//
//  CartItemModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 9/11/26.
//

import Foundation

struct CartItemModel: Identifiable, Equatable {
    var id: UUID = UUID()
    var cartId: Int = 0
    var userId: Int = 0
    var qty: Int = 0
    var prodId: Int = 0
    var catId: Int = 0
    var brandId: Int = 0
    var typeId: Int = 0
    var name: String = ""
    var brandName: String = ""
    var unitName: String = ""
    var unitValue: Int = 0
    var nutriotionWeight: String = ""
    var detail: String = ""
    var offerPrice: Double?
    var price: Double = 0.0
    var startDate: Date = Date()
    var endDate: Date = Date()
    
//    var username: String = ""
    var image: String = ""
//    var mobile: String = ""
    var catName: String = ""
    var typeName: String = ""
    var itemPrice: Double?
    var totalPrice: Double?
    var isFav: Bool = false

    init(dict: NSDictionary) {
//        self.id = dict.value(forKey: "cart_id") as? Int ?? 0
        self.cartId = dict.value(forKey: "cart_id") as? Int ?? 0
        self.userId = dict.value(forKey: "user_id") as? Int ?? 0
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.qty = dict.value(forKey: "qty") as? Int ?? 0
        self.catId = dict.value(forKey: "cat_id") as? Int ?? 0
        self.brandId = dict.value(forKey: "brand_id") as? Int ?? 0
        self.typeId = dict.value(forKey: "type_id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.unitName = dict.value(forKey: "unit_name") as? String ?? ""
        self.unitValue = dict.value(forKey: "unit_value") as? Int ?? 0
        self.nutriotionWeight = dict.value(forKey: "nutrition_weight") as? String ?? ""
        self.detail = dict.value(forKey: "detail") as? String ?? ""
        self.itemPrice = dict.value(forKey: "item_price") as? Double
        self.totalPrice = dict.value(forKey: "total_price") as? Double
        self.offerPrice = dict.value(forKey: "offer_price") as? Double
        self.price = dict.value(forKey: "price") as? Double ?? 0
        self.startDate = (dict.value(forKey: "start_date") as? String ?? "").stringDateToDate() ?? Date()
        self.endDate = (dict.value(forKey: "end_date") as? String ?? "").stringDateToDate() ?? Date()
        
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.catName = dict.value(forKey: "cat_name") as? String ?? ""
        self.brandName = dict.value(forKey: "brand_name") as? String ?? ""
        
        self.typeName = dict.value(forKey: "type_name") as? String ?? ""
        self.isFav = dict.value(forKey: "is_fav") as? Bool ?? false
    }

    static func == (lhs: CartItemModel, rhs: CartItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
