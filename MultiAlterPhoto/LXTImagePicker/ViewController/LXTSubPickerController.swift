//
//  LXTImagePickerViewController.swift
//  MultiAlterPhoto
//
//  Created by john on 16/10/18.
//  Copyright © 2016年 lixiaotao. All rights reserved.
//

import UIKit
import Photos


//TODO:1，navigatioItem的自定义，2，黑色背景的去除。3，本类的相关代理的设置。4，cell 中选中btn的UI处理以及逻辑处理。


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let LINE_SPACE = 3
//let ITEM_WIDTH = (SCREEN_WIDTH - CGFloat(LINE_SPACE) * 6)/4
let ITEM_WIDTH = (Int(SCREEN_WIDTH) - 5 * LINE_SPACE)/4


class LXTSubPickerController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,BottomViewDelegate{
    

    public var vTitle    :String?
//    var assetArray       :[PHAsset]?
    var delegate         :TestDelegate?
    
    lazy var collectionView:UICollectionView = {
        
        
        //2,初始化collectionview的布局
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:ITEM_WIDTH , height:ITEM_WIDTH)

        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = CGFloat(LINE_SPACE)
        
        //3,初始化collectionview
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 40), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LXTSubPickerCell.classForCoder(), forCellWithReuseIdentifier: "collectCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: CGFloat(LINE_SPACE), left: CGFloat(LINE_SPACE), bottom: CGFloat(LINE_SPACE), right: CGFloat(LINE_SPACE))
        
        return collectionView
    }()
    
    lazy var assetArray:[PHAsset] = {
        let assetArray:[PHAsset] = [PHAsset]()
        return assetArray
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.assetArray = [PHAsset]()
    }
    
    func setArray(array withArray:[PHAsset]){
        self.assetArray = withArray
        self.collectionView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //1，设置ViewController的navigationBar
        self.initNav()
    
        
        //2，添加collectionView到父视图
        self.view.addSubview(self.collectionView)
        
        //3,为collectionview添加tap 手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        self.collectionView.addGestureRecognizer(tap)
        
        //4,添加底部的视图
        let bottomView = LXTBottomCustomView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 40, width: SCREEN_WIDTH, height: 40))
        bottomView.delegate = self
        self.view.addSubview(bottomView)
    
//        //5，刷新collectionview视图
//        self.collectionView.reloadData()
    }
    
    
//------------------------collectionviewDelegate----------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! LXTSubPickerCell
//        collectCell.selectBlock = {(index) in
//            print("&&&&&&&&&&&&&\(index)*************")
//        }
       
        let size = CGSize(width: 150, height: 150)
        let asset = self.assetArray[indexPath.row]
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode:.aspectFill , options: nil) { (image, info) in
        collectCell.imgVC.image = image
        }
        
        print("============\(indexPath.row)")
        collectCell.tag = indexPath.row
        collectCell.backgroundColor = UIColor.white
        return collectCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.assetArray.count)
    }
    
//－－－－－－－－－－－－－导航栏相关－－－－－－－－－－－－－－－
    func initNav(){
        
        self.title = self.vTitle == nil ? "相册" : self.vTitle
        let rightBarItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelRightBarClick(sender:)))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    func cancelRightBarClick(sender:UIBarButtonItem){
        self.dismiss(animated: true) { 
            print("return to the present viewcontroller")
        }
    }
    
//--------------------手势处理－－－－－－－－－－－－－－－－－－－－－－
    func tapClick(tap:UITapGestureRecognizer){
        let location = tap.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        if indexPath != nil{
            let cell:LXTSubPickerCell = self.collectionView.cellForItem(at: indexPath!) as! LXTSubPickerCell
            let p = cell.selectBtn?.frame
            let s = tap.location(in: cell)
            if (p?.contains(s))!{
                self.delegate?.testMethod(toIndex: (indexPath?.row)!)
            }else{
                self.delegate?.testMethod(toIndex: 2222222222222)
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
//----------------------底部视图的相关代理方法-----------------------------
    func preview() {
        print("preview")
    }
    func finish() {
        print("finish")
    }

}


