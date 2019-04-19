//
//  ViewController.swift
//  CustomTimer
//
//  Created by guan_xiang on 2019/4/18.
//  Copyright © 2019 iGola_iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        iGolaCustomTimer().startCountDownTimer(totalTime: 10) { (isOver) in

//        }
        
        
       
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let VC = TempVC()
        self.present(VC, animated: true, completion: nil)
    }

}

