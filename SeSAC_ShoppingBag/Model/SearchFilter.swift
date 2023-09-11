//
//  SearchFilter.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import Foundation

//[mainView.accuracyButton, mainView.dateButton, mainView.orderAscButton, mainView.orderDesButton]

@frozen enum SearchFilter: String{
    case accuracy = "sim"
    case date = "date"
    case ascOrder = "asc"
    case dscOrder = "dsc"
}

extension SearchFilter{
    var getFilterQuery: String{
        get{
            switch self {
            case .accuracy:
                return rawValue
            case .date:
                return rawValue
            case .ascOrder:
                return rawValue
            case .dscOrder:
                return rawValue
            }
        }
    }
}
