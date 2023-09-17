//
//  WishListViewController.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit
import RealmSwift

final class WishListViewController: BaseViewController{
    //MARK: - Properties
    
    private let mainView = WishListView()
    var resultRealmData:Results<SearchShoppingRealmModel>? = nil{
        didSet{
            self.mainView.collectionView.reloadData()
        }
    }
    let realm = RealmManager.shared
    //현재 저장되어있는 모든 데이터베이스 데이터를 매번 불러오기에는
    lazy var allRealmData = realm.readShoppingRealmData()
    
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //처음에는 사용자가 추가한 위시리스트 모두를 표시한다.
        resultRealmData = RealmManager.shared.readShoppingRealmData()
    }
    
    
    //MARK: - SetUI
    override func setNavigation() {
        self.title = "좋아요 목록"
    }
   
    override func configure() {
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    
    @objc func tappedLikeButton(_ sender: UIButton){
        guard let selectedItem = resultRealmData?[sender.tag] else {
            makeToast(toastType: .failureSaveDB)
            return
        }

        //버튼의 상태를 변화시키기 위해 데이터베이스의 좋아요를 변경후 삭제한다.
        sender.isSelected = realm.changeShoppingRealmLikeData(data: selectedItem, isLiked: sender.isSelected)

        if realm.removeShoppingRealmData(data: selectedItem ) {
            makeToast(toastType: .success)
        } else {
            makeToast(toastType: .failureSaveDB)
        }
        
        mainView.collectionView.reloadData()
    }
    
}

//MARK: - Delegate, DataSource
extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultRealmData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        
        guard let resultRealmData else {return cell}
        
        cell.likeButton.addTarget(self, action: #selector(self.tappedLikeButton), for: .touchUpInside)
        
        let cellData = resultRealmData[indexPath.row]
        
        cell.likeButton.isSelected = RealmManager.shared.checkDataInRealm(productID: cellData.productID)
        cell.likeButton.tag = indexPath.row
        cell.setDisplayData(cellData)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        guard let resultRealmData else {
            makeToast(toastType: .failureSaveDB)
            return
        }
//        nextVC.realmData = resultRealmData[indexPath.row]
        nextVC.data = realm.mappingShoppingItemModel(data: resultRealmData[indexPath.row])
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


extension WishListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText == "" else {
            self.view.hideToastActivity()
            searchBar.showsCancelButton = false
            self.makeToast(toastType: .noneText)
            return
        }
        
        resultRealmData = realm.getSearchResultsInRealm(productName: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.makeToastActivity(.center) //첫 로딩은 로딩 Toast를 사용하여 로딩중임을 보여주도록 한다.
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text else {
            self.view.hideToastActivity()
            self.makeToast(toastType: .noneText)
            return
        }
        
        resultRealmData = realm.getSearchResultsInRealm(productName: text)
        print(resultRealmData)
        self.view.hideToastActivity()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil //텍스트를 모두 지운다
        searchBar.resignFirstResponder() //키보드를 내린다.
        searchBar.showsCancelButton = false //취소 버튼을 숨긴다.
        
        resultRealmData = realm.readShoppingRealmData()
    }
}
