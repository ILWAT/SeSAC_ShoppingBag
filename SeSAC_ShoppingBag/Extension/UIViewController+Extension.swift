//
//  UIViewController+.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit
import Toast

enum ToastType{
    case networkError
    case success
    case failureSaveDB
    case fianlPage
}

extension ToastType{
    var getErrorMessage: String {
        switch self {
        case .networkError:
            return "네트워크 통신에 실패 했습니다.\n 네트워크를 확인후 다시 시도해주세요."
        case .success:
            return "성공적으로 수행되었습니다."
        case .failureSaveDB:
            return "오류가 발생했습니다. 다시 시도해주세요."
        case .fianlPage:
            return "마지막 페이지입니다!"
        }
    }
}


extension UIViewController{
    func makeToast(toastType: ToastType){
        self.view.makeToast(toastType.getErrorMessage)
    }
}
