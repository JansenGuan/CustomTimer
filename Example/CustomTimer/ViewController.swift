//
//  ViewController.swift
//  CustomTimer
//
//  Created by guan_xiang on 2019/4/18.
//  Copyright © 2019 iGola_iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var formatDate : DateFormatter = {
        let format = DateFormatter()
        format.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        format.dateFormat = "HH:mm:ss"
        format.isLenient = true
        return format
    }()
    
    /// 倒计时
    lazy var coutDownTimer = iGolaCustomTimer()
    
    /// 常规定时器
    lazy var timer = iGolaCustomTimer()
    
    /// 间隔不等定时器
    lazy var unequalTimer = iGolaCustomTimer()
    

    @IBOutlet weak var coutDownLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var unequalLabel: UILabel!
    
    private var totalTime : TimeInterval = 10
    
    private var count : Int = 0
    
    private var timeArray : [TimeInterval] = [3,4,2,4,1,3,2]
    
    
    private var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coutDownLabel.text = "\(totalTime)"

        timerLabel.text = "第\(self.count)次(间隔2s)"
        
        
        unequalLabel.text = "第\(self.count)次(间隔2s)"
        
       
    }
    
    @IBAction func startCoutDownAction(_ sender: UIButton) {
        
        coutDownTimer.startCountDownTimer(totalTime: totalTime) { (isOver) in
            if isOver{
                self.totalTime = 10
                self.coutDownLabel.text = "倒计时结束了"
            }else{
                self.totalTime -= 1
                self.coutDownLabel.text = self.formatDate.string(from: Date())
            }
        }
        
    }
    
    @IBAction func startTimerAction(_ sender: UIButton) {
        timer.startTimer(duration: 2) {
            self.count += 1
            self.timerLabel.text = self.formatDate.string(from: Date())
        }
    }
    
    @IBAction func startUnequalTimerAction(_ sender: UIButton) {
        
        unequalTimer.startUnEqualTimer(timeArray: timeArray) { (isOver) in
            if isOver{
                self.unequalLabel.text = self.formatDate.string(from: Date()) + "结束了"
            }else{
                self.unequalLabel.text = self.formatDate.string(from: Date())
                self.index += 1
            }
        }
        
    }

    
    @IBAction func suspendCoutDownTime(_ sender: Any) {
        
        coutDownTimer.suspendTimer()
    }
    
    @IBAction func resumeCoutDownTime(_ sender: Any) {
        
        coutDownTimer.resumeCountDownTimer()
    }
    
    @IBAction func cancelCoutDownTime(_ sender: Any) {
        
        coutDownTimer.cancelTimer()
    }
    
    
    
    @IBAction func suspendTime(_ sender: Any) {
        
        timer.suspendTimer()
    }
    
    @IBAction func resumeTime(_ sender: Any) {
        
        timer.resumeTimer()
    }
    
    @IBAction func cancelTime(_ sender: Any) {
        
        timer.cancelTimer()
    }
    
    
    @IBAction func suspendUnequalTime(_ sender: Any) {
        
        unequalTimer.suspendTimer()
    }
    
    @IBAction func resumeUnequalTime(_ sender: Any) {
        unequalTimer.resumeUnequalTimer()
    }
    
    @IBAction func cancelUnequalTime(_ sender: Any) {
        unequalTimer.cancelTimer()
    }
}

