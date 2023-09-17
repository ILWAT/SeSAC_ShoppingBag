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
    
    func addPriceUnit() -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        guard let returnNumber = format.string(for: Int(self)) else {return "적용 오류"}
        return "\(returnNumber)"
    }
}
