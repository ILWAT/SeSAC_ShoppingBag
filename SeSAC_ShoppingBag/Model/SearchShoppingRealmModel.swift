//
//  SearchShoppingRealmModel.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import Foundation
import RealmSwift

class SearchShoppingRealmModel: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var hprice: String
    @Persisted var mallName: String
    @Persisted var productID: String
    @Persisted var productType: String
    @Persisted var brand: String
    @Persisted var maker: String
    @Persisted var category1: String
    @Persisted var category2: String
    @Persisted var category3: String
    @Persisted var category4: String
    @Persisted var like: Bool
    
    
    convenience init(title: String, link: String, image: String, lprice: String, hprice: String, mallName: String, productID: String, productType: String, brand: String, maker: String, category1: String, category2: String, category3: String, category4: String, like: Bool = true) {
        self.init()
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.hprice = hprice
        self.mallName = mallName
        self.productID = productID
        self.productType = productType
        self.brand = brand
        self.maker = maker
        self.category1 = category1
        self.category2 = category2
        self.category3 = category3
        self.category4 = category4
        self.like = like
    }
}
