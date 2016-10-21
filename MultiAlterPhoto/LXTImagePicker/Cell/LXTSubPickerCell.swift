//
//  PickerImgCollectionViewCell.swift
//  MultiAlterPhoto
//
//  Created by john on 16/10/18.
//  Copyright © 2016年 lixiaotao. All rights reserved.
//

import UIKit


let SELECT_WIDTH = CGFloat(22)

class LXTSubPickerCell: UICollectionViewCell {
    
    public var selectBtn:UIImageView?
    
    //懒加载
    lazy var imgVC:UIImageView = {
        let imgVC = UIImageView()
        
        return imgVC
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cellWidth  = self.frame.size.width
        
        //图片展示的imageView
        self.imgVC = UIImageView(frame:CGRect(x:0, y: 0, width: cellWidth, height: cellWidth))
        self.imgVC.contentMode = .scaleAspectFill
        self.imgVC.clipsToBounds = true

        
        //是否是选中状态的imageView
        self.selectBtn = UIImageView(frame: CGRect(x:cellWidth - SELECT_WIDTH - 6 , y: 6, width: SELECT_WIDTH, height: SELECT_WIDTH))
        self.selectBtn?.layer.cornerRadius = SELECT_WIDTH/2
        self.selectBtn?.backgroundColor = UIColor.white

        
        self.addSubview(self.imgVC)
        self.addSubview(self.selectBtn!)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
