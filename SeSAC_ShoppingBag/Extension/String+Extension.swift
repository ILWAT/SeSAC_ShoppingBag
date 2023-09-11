//
//  String+Extension.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import Foundation

extension String{
    func removeSearchKeywordPoint() ->String {
        let removefirst = self.replacingOccurrences(of: "<b>", with: "")
        let removelast = removefirst.replacingOccurrences(of: "</b>", with: "")
        return removelast
    }
    
//    func addPriceUnit() -> String {
//        let countUnit = self.count / 3
//    }
}
