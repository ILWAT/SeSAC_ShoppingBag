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
    
//    var realmData: SearchShoppingRealmModel?
    
    lazy var isLiked: Bool = false{
        didSet{
            setLikeButtonImage()
        }
    }
   
    
    //MARK: - LifeCycle
    override func loadView() {
        view = webView
        webView.uiDelegate = self
    }
    
    //MARK: - setUI
    override func configure(){
        //웹뷰를 포함한 사용자에게 보여질 화면을 셋팅한다.
        displayData()
    }
    
    override func setNavigation() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(tappedLikeButton)), animated: true)
        //LikeButton 설정
        setLikeButtonImage()
    }
    
    //MARK: - Action
    
    @objc func tappedLikeButton(_ sender: UIBarButtonItem){
        
        let originLike = isLiked
        
        let realm = RealmManager.shared
        
        if realm.checkDataInRealm(productID: data.productID) {
            guard let realmData = realm.getDataInRealm(productID: data.productID) else {
                makeToast(toastType: .failureSaveDB)
                return
            }
            
            isLiked = !realm.removeShoppingRealmData(data: realmData) //데이터베이스를 바로 삭제한다. => 데이터베이스 성공시 true값 반환이므로, 좋아요 상태는 반대를 저장한다.
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
    
    func setLikeButtonImage() {
        guard let rightBarButton = self.navigationItem.rightBarButtonItem else {return}
        if isLiked {
            rightBarButton.image = UIImage(systemName: "heart.fill")
        } else {
            rightBarButton.image = UIImage(systemName: "heart")
        }
    }
    
    func displayData() {
        if let data = data {
            self.title = data.title.removeSearchKeywordPoint()
            setWebView(query: data.productID)
            isLiked = RealmManager.shared.checkDataInRealm(productID: data.productID)
        } else {
            makeToast(toastType: .networkError)
            self.navigationController?.popViewController(animated: true)
            return
        }
    }
    
    func setWebView(query: String?){
        //WebView 설정
        var mobileString = EndPoint.mobileShoppingWebLink.getURL
        
        guard let query = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            makeToast(toastType: .networkError)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        mobileString += query
        print(mobileString)
        
        guard let url = URL(string:mobileString) else {
            makeToast(toastType: .networkError)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
