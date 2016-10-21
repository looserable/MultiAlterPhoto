//
//  LXTPickerViewController.swift
//  MultiAlterPhoto
//
//  Created by john on 16/10/19.
//  Copyright © 2016年 lixiaotao. All rights reserved.
//

import UIKit
import Photos
protocol TestDelegate {
    func testMethod(toIndex index:Int)
}

class LXTPickerController: UIViewController{

    var delegate:TestDelegate?
    var lxtPickerImgVC:LXTSubPickerController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.view.backgroundColor = UIColor.white
        

    }
    
    func setDelegate(_ delegate:TestDelegate){
        self.delegate = delegate
        self.lxtPickerImgVC?.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lxtPickerImgVC = LXTSubPickerController()
//        self.lxtPickerImgVC?.view.setNeedsDisplay()
        
        //1,初始化一个数组
        var assetArray = [PHAsset]()
        
        //2,验证权限，如果是第一次，请求权限。
        let authorStatus = PHPhotoLibrary.authorizationStatus()
        switch authorStatus {
        case .denied       :
            print("denied")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                if status == .authorized {
                    // 用户同意
                    //请求原始的相册资源数据
                    assetArray = LXTPhotoSrcManager.sharedManager.fetchAllPhotoResource()!
                    if assetArray.count != 0{
                        self.lxtPickerImgVC?.setArray(array: assetArray)
                    }
                    
                }else if status == .denied{
                    print("denied")
                }
            })
        case .restricted    : break
        case .authorized    :
            //请求原始的相册资源数据
            assetArray = LXTPhotoSrcManager.sharedManager.fetchAllPhotoResource()!
            if assetArray.count != 0{
                self.lxtPickerImgVC?.setArray(array: assetArray)
            }
            
        }
        
        
        
        let lxtNav = UINavigationController(rootViewController: self.lxtPickerImgVC!)
        lxtNav.view.frame = self.view.bounds;
        
        self.addChildViewController(lxtNav)
        self.view.addSubview(lxtNav.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
