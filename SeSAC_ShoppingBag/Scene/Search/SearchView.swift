//
//  BaseView.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/07.
//

import UIKit
import SnapKit

final class SearchView: BaseCollectionSearchView{
    //MARK: - Properties
    private lazy var filterView = {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }()
    
    private lazy var accuracyButton = {
        let button = UIButton()
        button.setTitle("정확도", for: .normal)
        setButtonConfig(button)
        return button
    }()
    
    private lazy var dateButton = {
        let button = UIButton()
        button.setTitle("날짜순", for: .normal)
        setButtonConfig(button)
        return button
    }()
    
    private lazy var orderDesButton = {
        let button = UIButton()
        button.setTitle("가격 높은순", for: .normal)
        setButtonConfig(button)
        return button
    }()
    
    private lazy var orderAscButton = { [self] in
        let button = UIButton()
        button.setTitle("가격 낮은순", for: .normal)
        setButtonConfig(button)
        return button
    }()
    
    
    
    //MARK: - setUI
    override func configure() {
        super.configure()
        addSubViews([filterView])
        filterView.addSubViews([accuracyButton, dateButton, orderDesButton, orderAscButton])
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        filterView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(50)
        }
        accuracyButton.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(10)
        }
        dateButton.snp.makeConstraints { make in
            make.leading.equalTo(accuracyButton.snp.trailing).offset(10)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        orderAscButton.snp.makeConstraints { make in
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        orderDesButton.snp.makeConstraints { make in
            make.leading.equalTo(orderAscButton.snp.trailing).offset(10)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(filterView.snp.bottom)
        }
        
    }
    
    //MARK: - Helper
    func setButtonConfig(_ button: UIButton){
        if #available(iOS 15.0, *){
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .clear
            config.baseForegroundColor = .systemGray
            config.title = button.currentTitle
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ container in
                var outgoing = container
                outgoing.font = .systemFont(ofSize: 14)
                return outgoing
            })
            button.configuration = config
        } else {
            button.backgroundColor = .clear
            button.setTitleColor(.systemGray, for: .normal)
            button.setTitleColor(.systemGray3, for: .highlighted)
            button.setTitle(" \(button.currentTitle) ", for: .normal)
        }
    
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.clipsToBounds = true
    }
    
    
    
}
