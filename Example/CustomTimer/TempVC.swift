//
//  TempVC.swift
//  CustomTimer
//
//  Created by guan_xiang on 2019/4/19.
//  Copyright © 2019 iGola_iOS. All rights reserved.
//

import UIKit

class TempVC: UIViewController {

    lazy var timer = iGolaCustomTimer()
    
    deinit {
        timer.cancelTimer()
        print("\(self.self)释放了")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
        
        print(Date())
        timer.startUnEqualTimer(timeArray: [3,3,2,2,1,3,2]) { (isOver) in
            if isOver{
                print("结束\(Date())")
            }else{
                print(Date())
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.dismiss(animated: true, completion: nil)
    }

}
