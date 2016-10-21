//
//  LXTPhotoSrcManager.swift
//  MultiAlterPhoto
//
//  Created by john on 16/10/19.
//  Copyright © 2016年 lixiaotao. All rights reserved.
//

import UIKit
import Photos

class LXTPhotoSrcManager: NSObject {
    

    override init() {
        super.init()
        
    }
    
    //单例的写法
    static let sharedManager:LXTPhotoSrcManager = {
        let lxtManager = LXTPhotoSrcManager()
        return lxtManager
    }()
    
    func fetchAllPhotoResource()->([PHAsset]?){
        let fetchOption = PHFetchOptions()
        var assetArray = [PHAsset]()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        fetchOption.sortDescriptors = [sortDescriptor]
        let assetsFetchResult = PHAsset.fetchAssets(with: fetchOption)
        if assetsFetchResult.count == 0{
            return nil
        }
        for i in 0...assetsFetchResult.count - 1{
            let asset = assetsFetchResult[i]
            assetArray.append(asset)
        }
        
        return assetArray
    }
    

}
