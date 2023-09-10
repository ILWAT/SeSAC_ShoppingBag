//
//  IdentifierProtocol.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/08.
//

import UIKit

protocol IdentifierProtocol{
    static var identifier: String { get }
}

extension UIView: IdentifierProtocol{
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}


