//
//  SearchViewController.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit
import Toast
import RealmSwift

final class SearchViewController: BaseViewController {
    //MARK: - Properties
    private let mainView = SearchView()
    
    private var searchResultItems: [Item] = []
    
    private var pageNumber: Int = 1
    private var isEnd: Bool = false
    private var filter: SearchFilter?
    
    private lazy var filterButtons: [UIButton] = [mainView.accuracyButton, mainView.dateButton, mainView.orderAscButton, mainView.orderDscButton]
    
    private let realm = RealmManager.shared
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    
    //MARK: - setUI
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.searchBar.delegate = self
        
        mainView.accuracyButton.addTarget(self, action: #selector(tappedFilterButton), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(tappedFilterButton), for: .touchUpInside)
        mainView.orderAscButton.addTarget(self, action: #selector(tappedFilterButton), for: .touchUpInside)
        mainView.orderDscButton.addTarget(self, action: #selector(tappedFilterButton), for: .touchUpInside)
    }
    
    override func setNavigation() {
        self.title = "쇼핑 검색"
    }
    
    //MARK: - Action
    @objc func tappedLikeButton(_ sender: UIButton){
        let originData = sender.isSelected
        let selectedItem = searchResultItems[sender.tag]
        if realm.checkDataInRealm(productID: selectedItem.productID) {
            guard let productID = realm.getDataInRealm(productID: selectedItem.productID) else {
                print("데이터 로드 실패")
                makeToast(toastType: .failureSaveDB)
                return
            }
            sender.isSelected = realm.changeShoppingRealmLikeData(data: productID, isLiked: sender.isSelected)
            
            if realm.removeShoppingRealmData(data: productID){
                makeToast(toastType: .success)
            } else {
                makeToast(toastType: .failureSaveDB)
            }
        } else {
            sender.isSelected = realm.insertShoppingRealmData(data: selectedItem)
        }
        
        
        if originData == sender.isSelected{ //만약 데이터베이스 저장된 결과가 수행되기 전과 같다면 실패이므로 실패 토스트를 띄운다.
            makeToast(toastType: .failureSaveDB)
        } else {
            makeToast(toastType: .success)
        }
        
    }
    
    @objc func tappedFilterButton(_ sender: UIButton){
        for index in 0...filterButtons.count-1{
            let item = filterButtons[index]
            
            //버튼의 선택에따라 수행할 동작을 결정한다.
            if item.isEqual(sender) {
                item.isSelected = !sender.isSelected
                
                if item.isSelected{
                    filter = SearchFilter(rawValue: index)
                } else {
                    filter = nil
                }
                
                if let text = mainView.searchBar.text, text != "" {
                    self.clearData()
                    
                    APIManager.shared.requestSearchShopping(text, page: pageNumber, filter: filter) { result, pageEnd in
                        self.updateData(result: result, pageEnd: pageEnd)
                        self.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true) //최상단으로 올라간다
                    }
                }
                
            }
            else { item.isSelected = false }
            
            //버튼의 선택에 따라 UI를 결정한다.
            if item.isSelected { item.backgroundColor = .magenta }
            else { item.backgroundColor = .clear }
        }
    }
    
    
    
    //MARK: - Helper
    func updateData(result: SearchShoppingModel?, pageEnd: Bool){
        guard let result = result else {
            makeToast(toastType: .networkError)
            return
        }
        
        self.isEnd = pageEnd
        guard !self.isEnd else { //API가 마지막 페이지라면 마지막 페이지임을 알리는 토스트를 띄운다.
            makeToast(toastType: .fianlPage)
            return
        }
        
        result.items.forEach { item in //데이터를 추가한다.
            self.searchResultItems.append(item)
        }
        self.mainView.collectionView.reloadData()
        
    }
    
    func clearData(){
        pageNumber = 1
        searchResultItems = []
        mainView.collectionView.reloadData()
    }
    
    
}


//MARK: - CollectionView Delegate, DataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let searchResultItem = searchResultItems[indexPath.row]
        
        cell.likeButton.addTarget(self, action: #selector(self.tappedLikeButton), for: .touchUpInside)
        cell.likeButton.isSelected = RealmManager.shared.checkDataInRealm(productID: searchResultItem.productID)
        cell.likeButton.tag = indexPath.row
        cell.setDisplayData(searchResultItem)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        guard let searchResultItems else {return}
        print(indexPaths)
        for indexPath in indexPaths {
//            print(indexPath)
            if searchResultItems.count - 1 == indexPath.row && !isEnd {
                print("prefecth")
                guard let text = mainView.searchBar.text else {return}
                
                pageNumber += 30
                print(pageNumber)
                APIManager.shared.requestSearchShopping(text, page: pageNumber,filter: filter) { result, pageEnd in
                    self.updateData(result: result, pageEnd: pageEnd)
                }
            }
            
            if searchResultItems.count - 34 == indexPath.row { //메모리 부하를 줄이기 위해 위로 스크롤 했을 경우 하단 데이터를 지운다.... -> 효율성...?? -> KingFisher의 캐시 저장때문에 별 효과가 없는 듯하다..
                pageNumber -= 30
                searchResultItems.removeSubrange(searchResultItems.count-30...searchResultItems.count-1)
                mainView.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        let item = searchResultItems[indexPath.row]
        nextVC.data = item
        nextVC.realmData = RealmManager.shared.getDataInRealm(productID: item.productID )
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.makeToastActivity(.center) //첫 로딩은 로딩 Toast를 사용하여 로딩중임을 보여주도록 한다.
        
        guard let text = searchBar.text else {return}
        clearData()
        
        APIManager.shared.requestSearchShopping(text, page: pageNumber,filter: filter) { result, pageEnd in
            self.updateData(result: result, pageEnd: pageEnd)
            self.view.hideToastActivity() //데이터가 로드 되면 로딩 토스트를 hide한다.
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil //텍스트를 모두 지운다
        searchBar.resignFirstResponder() //키보드를 내린다.
        searchBar.showsCancelButton = false //취소 버튼을 숨긴다.
        
        clearData()
    }
}
