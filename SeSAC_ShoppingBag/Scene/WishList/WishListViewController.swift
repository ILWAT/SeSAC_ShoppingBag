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
    
    let allRealmData: Results<SearchShoppingRealmModel>? = RealmManager.shared.readShoppingRealmData()
    
    var resultRealmData:Results<SearchShoppingRealmModel>? = nil
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
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
        guard let resultRealmData else {
            makeToast(toastType: .failureSaveDB)
            return
        }
        
        sender.isSelected = RealmManager.shared.changeShoppingRealmLikeData(data: resultRealmData[sender.tag], isLiked: sender.isSelected)
        
        if RealmManager.shared.removeShoppingRealmData(data: resultRealmData[sender.tag]) {
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
        nextVC.realmData = resultRealmData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


extension WishListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.makeToastActivity(.center) //첫 로딩은 로딩 Toast를 사용하여 로딩중임을 보여주도록 한다.
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text else {return}
        resultRealmData = RealmManager.shared.getSearchResultsInRealm(productName: text)
        print(resultRealmData)
        mainView.collectionView.reloadData()
        self.view.hideToastActivity()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil //텍스트를 모두 지운다
        searchBar.resignFirstResponder() //키보드를 내린다.
        searchBar.showsCancelButton = false //취소 버튼을 숨긴다.
        
        resultRealmData = nil
        mainView.collectionView.reloadData()
    }
}
