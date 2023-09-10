//
//  EndPoint.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/09.
//

import Foundation


enum EndPoint{
    case searchShopping
}

extension EndPoint{
    var getURL: String{
        get{
            switch self {
            case .searchShopping:
                return URL.naverSearchShoppingURL+"/search/shop.json"
            }
        }
    }
}
