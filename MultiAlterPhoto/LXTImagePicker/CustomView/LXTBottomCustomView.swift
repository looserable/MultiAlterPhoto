//
//  LXTBottomCustomView.swift
//  MultiAlterPhoto
//
//  Created by john on 16/10/19.
//  Copyright © 2016年 lixiaotao. All rights reserved.
//

import UIKit

protocol BottomViewDelegate {
    func preview()
    func finish()
}

class LXTBottomCustomView: UIView {
    
    public var delegate:BottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let preViewBtn = UIButton(type: .custom)
        preViewBtn.frame = CGRect(x: 5, y: 5, width:40, height: 30)
        preViewBtn.backgroundColor = UIColor.white
        preViewBtn.setTitleColor(UIColor.lightGray, for: .normal)
        preViewBtn.setTitle("预览", for: .normal)
        preViewBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        preViewBtn.tag = 1000
        
        let finishBtn   = UIButton(type: .custom)
        finishBtn.frame = CGRect(x: SCREEN_WIDTH - 40 - 5, y: 5, width:40, height: 30)
        finishBtn.backgroundColor = UIColor.white
        finishBtn.setTitleColor(UIColor.lightGray, for: .normal)
        finishBtn.setTitle("完成", for: .normal)
        finishBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        finishBtn.tag = 1001
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.3))
        lineView.backgroundColor = UIColor.lightGray
        self.addSubview(lineView)
        
        self.addSubview(preViewBtn)
        self.addSubview(finishBtn)
        
        self.backgroundColor = UIColor.white
        
    }
    
    func buttonClick(sender:UIButton){
        if sender.tag == 1000{
            self.delegate?.preview()
        }else if sender.tag == 1001{
            self.delegate?.finish()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
