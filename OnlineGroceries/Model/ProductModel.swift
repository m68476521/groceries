//
//  ProductModel.swift
//  OnlineGroceries
//
//  Created by Mike Wasauskee on 8/4/26.
//

import Foundation

struct ProductModel: Identifiable, Equatable {
    var id: Int = 0
    var prodId: Int = 0
    var catId: Int = 0
    var brandId: Int = 0
    var typeId: Int = 0
    var name: String = ""
    var unitName: String = ""
    var unitValue: Int = 0
    var nutriotionWeight: String = ""
    var detail: String = ""
    var offerPrice: Double?
    var price: Double = 0.0
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    var username: String = ""
    var image: String = ""
    var mobile: String = ""
    var catName: String = ""
    var typeName: String = ""
    var isFav: Bool = false

    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "prod_id") as? Int ?? 0
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.catId = dict.value(forKey: "cat_id") as? Int ?? 0
        self.brandId = dict.value(forKey: "brand_id") as? Int ?? 0
        self.typeId = dict.value(forKey: "type_id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.unitName = dict.value(forKey: "unit_name") as? String ?? ""
        self.unitValue = dict.value(forKey: "unit_value") as? Int ?? 0
        self.nutriotionWeight = dict.value(forKey: "nutrition_weight") as? String ?? ""
        self.detail = dict.value(forKey: "detail") as? String ?? ""
        self.offerPrice = dict.value(forKey: "offer_price") as? Double
        self.price = dict.value(forKey: "price") as? Double ?? 0
        self.startDate = (dict.value(forKey: "start_date") as? String ?? "").stringDateToDate() ?? Date()
        self.endDate = (dict.value(forKey: "end_date") as? String ?? "").stringDateToDate() ?? Date()
        
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.catName = dict.value(forKey: "cat_name") as? String ?? ""
        self.typeName = dict.value(forKey: "type_name") as? String ?? ""
        self.isFav = dict.value(forKey: "is_fav") as? Bool ?? false
    }

    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}
