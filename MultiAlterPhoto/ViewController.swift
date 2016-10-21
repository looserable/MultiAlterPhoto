//
//  ViewController.swift
//  MultiAlterPhoto
//
//  Created by john on 16/10/18.
//  Copyright © 2016年 lixiaotao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TestDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "FirstPage"
    }

    @IBAction func selectImgClick(_ sender: AnyObject) {
        let lxtPicker = LXTPickerController()
        lxtPicker.setDelegate(self)
        self.view.backgroundColor = UIColor.white
        self.present(lxtPicker, animated: true) {
            
        }
    }
    
    func testMethod(toIndex index: Int) {
        print("..............\(index)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

