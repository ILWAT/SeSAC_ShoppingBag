//
//  BaseView.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    ///addSubView 등을 수행한다.
    func configure() { }
    
    ///AutoLayout을 적용한다.
    func setConstraints() { }
    
}