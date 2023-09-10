//
//  SearchViewController.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit
import Toast

final class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    var searchResult: SearchShoppingModel? = nil{
        didSet{
            mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    override func setNavigation() {
        self.title = "쇼핑 검색"
        self.tabBarController?.tabBar.items?[0].image = UIImage(systemName: "magnifyingglass")
        self.tabBarController?.tabBar.items?[0].title = "검색"
    }
    
    //MARK: - Action
    @objc func tappedLikeButton(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        print(sender.isSelected)
        print("tapped")
    }
    
    //MARK: - Helper
    func showNetworkErrorToast(){
        self.view.makeToast("네트워크 통신간 문제가 발생했습니다.\n잠시후 다시 시도해주세요.")
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult?.display ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.likeButton.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        guard let searchResult else {return cell}
        cell.setDisplayData(searchResult.items[indexPath.row])
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.makeToastActivity(.center)
        guard let text = searchBar.text else {return}
        
        APIManager.shared.requestSearchShopping(text, page: 1) { result in
            guard let result = result else {
                self.view.makeToast("네트워크 통신간 오류가 발생했습니다. 잠시후 다시 시도해주세요.")
                return
            }
            self.searchResult = result
            self.view.hideToastActivity()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = nil
    }
}
