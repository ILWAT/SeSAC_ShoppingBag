//
//  BaseViewController.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setNavigation()
    }
    ///delegate 또는 addTaget등을 수행한다.
    func configure() { }
    ///네비게이션 관련 프로퍼티 또는 메서드를 설정하고 수행한다.
    func setNavigation() { }

}
