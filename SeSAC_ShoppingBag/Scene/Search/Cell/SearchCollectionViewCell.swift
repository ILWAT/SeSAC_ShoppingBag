//
//  SearchCollectionViewCell.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/08.
//

import UIKit
import SnapKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell{
    //MARK: - Properties
    let brandLabel =  {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let productLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true //가격이 잘리지 않고 폰트를 작게 해서 가격이 보이도록 한다.
        label.textColor = .black
        return label
    }()
    
    let productImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill //화면을 꽉채우면서 비율은 유지하게 한다.
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let textStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .equalSpacing
        return view
    }()
    
    lazy var likeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.backgroundColor = .white
        DispatchQueue.main.async {
            button.layer.cornerRadius = button.frame.width/2
        }
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(){
        [brandLabel, productLabel, priceLabel].forEach { label in
            textStackView.addArrangedSubview(label)
        }
        contentView.addSubViews([textStackView, productImageView, likeButton])
        
    }
    
    func setConstraints(){
        productImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(productImageView.snp.width)
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(productImageView).inset(10)
            make.width.equalTo(productImageView).multipliedBy(0.2)
            make.height.equalTo(likeButton.snp.width)
        }
        textStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(productImageView)
            make.top.equalTo(productImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func setDisplayData(_ data: Item){
        productLabel.text = data.title.removeSearchKeywordPoint()
        brandLabel.text = "[\(data.mallName)]"
        priceLabel.text = data.lprice.addPriceUnit()
        
        guard let imageURL = URL(string: data.image) else {return}
        productImageView.kf.setImage(with: imageURL)
        
        
        
//        DispatchQueue.global().async {
//            guard let imageURL = URL(string: data.image) else {return}
//            do{
//                let imageData = try Data(contentsOf: imageURL)
//                DispatchQueue.main.async {
//                    self.productImageView.image = UIImage(data: imageData)
//                }
//            } catch {
//                print(error)
//            }
//        }
        
       
    }
    
    func setDisplayData(_ data: SearchShoppingRealmModel){
        productLabel.text = data.title.removeSearchKeywordPoint()
        brandLabel.text = "[\(data.mallName)]"
        priceLabel.text = data.lprice.addPriceUnit()
        
        guard let imageURL = URL(string: data.image) else {return}
        productImageView.kf.setImage(with: imageURL)
    }
}
