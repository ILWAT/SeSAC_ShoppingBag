//
//  SearchFilter.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import Foundation

@frozen enum SearchFilter: Int{
    case accuracy = 0
    case date
    case ascOrder
    case dscOrder
}

extension SearchFilter{
    var getFilterQuery: String{
        get{
            switch self {
            case .accuracy:
                return "sim"
            case .date:
                return "date"
            case .ascOrder:
                return "asc"
            case .dscOrder:
                return "dsc"
            }
        }
    }
}
