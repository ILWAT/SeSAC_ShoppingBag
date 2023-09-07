//
//  UIView+Extension.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit


extension UIView {
    
    ///addSubView를  다중 View를 한 코드로 줄이는 작업을 수행한다.
    func addSubViews(_ views: [UIView]){
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
}
