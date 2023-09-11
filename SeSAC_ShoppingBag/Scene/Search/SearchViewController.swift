//
//  SearchViewController.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit
import Toast

final class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    
    private var searchResultItems: [Item] = []
    
    private var pageNumber: Int = 1
    private var isEnd: Bool = false
    
    private lazy var filterButtons: [UIButton] = [mainView.accuracyButton, mainView.dateButton, mainView.orderAscButton, mainView.orderDscButton]
    
    override func loadView() {
        view = mainView
    }
    
    
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
        sender.isSelected = !sender.isSelected
        print(sender.isSelected)
        print("tapped")
    }
    
    @objc func tappedFilterButton(_ sender: UIButton){
        for item in filterButtons{
            if item.isEqual(sender) { item.isSelected = !sender.isSelected }
            else { item.isSelected = false }
            
            if item.isSelected { item.backgroundColor = .magenta }
            else { item.backgroundColor = .clear }
        }
    }
    
    //MARK: - Helper
    func updateData(result: SearchShoppingModel?, pageEnd: Bool){
        guard let result = result else {
            self.view.makeToast("네트워크 통신간 오류가 발생했습니다. 잠시후 다시 시도해주세요.")
            return
        }
        
        self.isEnd = pageEnd
        guard !self.isEnd else { //API가 마지막 페이지라면 마지막 페이지임을 알리는 토스트를 띄운다.
            self.view.makeToast("마지막 페이지입니다!")
            return
        }
        
        result.items.forEach { item in //데이터를 추가한다.
            self.searchResultItems.append(item)
        }
        self.mainView.collectionView.reloadData()
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UISearchBarDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.likeButton.addTarget(self, action: #selector(self.tappedLikeButton), for: .touchUpInside)
        cell.setDisplayData(searchResultItems[indexPath.row])
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
                APIManager.shared.requestSearchShopping(text, page: pageNumber) { result, pageEnd in
                    self.updateData(result: result, pageEnd: pageEnd)
                }
            }
            
            if searchResultItems.count - 34 == indexPath.row { //메모리 부하를 줄이기 위해 위로 스크롤 했을 경우 하단 데이터를 지운다.... -> 효율성...??
                pageNumber -= 30
                searchResultItems.removeSubrange(searchResultItems.count-30...searchResultItems.count-1)
                mainView.collectionView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.makeToastActivity(.center) //첫 로딩은 로딩 Toast를 사용하여 로딩중임을 보여주도록 한다.
        
        guard let text = searchBar.text else {return}
        pageNumber = 1
        searchResultItems = []
        
        APIManager.shared.requestSearchShopping(text, page: pageNumber) { result, pageEnd in
            self.updateData(result: result, pageEnd: pageEnd)
            self.view.hideToastActivity() //데이터가 로드 되면 로딩 토스트를 hide한다.
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = nil
    }
}
