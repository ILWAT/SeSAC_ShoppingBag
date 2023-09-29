//
//  Extension+KingfisherWrapper.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 3/11/24.
//

import UIKit
import Kingfisher

extension KingfisherWrapper where Base: KFCrossPlatformImageView {
    @discardableResult
    public func setImageWithDownSampling(
        with resource: Resource?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        let itemWidth = UIScreen.main.bounds.width - (10 * 3)
        let itemHeight = UIScreen.main.bounds.height * 0.3
        let processor = DownsamplingImageProcessor(size: CGSize(width: itemWidth, height: itemHeight))
        
        var newOprions: KingfisherOptionsInfo = options ?? []
        
        newOprions.append(.processor(processor))
        
        return setImage(
            with: resource,
            placeholder: placeholder,
            options: newOprions,
            progressBlock: nil,
            completionHandler: completionHandler
        )
    }
}
