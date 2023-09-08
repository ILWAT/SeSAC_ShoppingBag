//
//  BaseCollectionSearchView.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit

class BaseCollectionSearchView: UIView{
    lazy var searchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = backgroundColor
        bar.tintColor = .systemGray
        return bar
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemWidth = UIScreen.main.bounds.width - (spacing * 3)
        let itemHeight = UIScreen.main.bounds.height * 0.3
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemWidth/2, height: itemHeight)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    ///addSubView 등을 수행한다.
    func configure() { addSubViews([collectionView, searchBar]) }
    
    ///AutoLayout을 적용한다.
    func setConstraints() { }
    
    
}
