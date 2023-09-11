//
//  WishListView.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import UIKit

final class WishListView: BaseCollectionSearchView{
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
