//
//  DetailViewController.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import UIKit
import WebKit
import Toast


class DetailViewController: BaseViewController, WKUIDelegate{
    //MARK: - Properties
    let webView = WKWebView(frame: .zero, configuration: .init())
    
    var data: Item!
    
    var realmData: SearchShoppingRealmModel? = nil
    
    lazy var isLiked: Bool = realmData?.like ?? false{
        didSet{
            changeLikeButtonImage()
        }
    }
   
    
    //MARK: - LifeCycle
    override func loadView() {
        view = webView
        webView.uiDelegate = self
    }
    
    //MARK: - setUI
    override func configure() {
        //WebView 설정
        let mobilString = EndPoint.mobileShoppingWebLink.getURL+"/\(data.productID)"
        
        guard let url = URL(string:mobilString) else {
            makeToast(toastType: .networkError)
            return
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        //LikeButton 설정
        isLiked = realmData?.like ?? false
        changeLikeButtonImage()
    }
    
    override func setNavigation() {
        self.title = realmData?.title
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(tappedLikeButton)), animated: true)
    }
    
    //MARK: - Action
    
    @objc func tappedLikeButton(_ sender: UIBarButtonItem){
        let originLike = isLiked
        
        if let realmData {
            isLiked = RealmManager.shared.changeShoppingRealmLikeData(data: realmData, isLiked: isLiked)
        } else {
            isLiked = RealmManager.shared.insertShoppingRealmData(data: data)
        }
        
        if  originLike == isLiked{
            makeToast(toastType: .failureSaveDB)
        } else {
            makeToast(toastType: .success)
        }
        
    }
    
    
    
    //MARK: - Helper
    
    func changeLikeButtonImage() {
        guard let rightBarButton = self.navigationItem.rightBarButtonItem else {return}
        if isLiked {
            rightBarButton.image = UIImage(systemName: "heart.fill")
        } else {
            rightBarButton.image = UIImage(systemName: "heart")
        }
    }
}
