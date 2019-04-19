//
//  iGolaCustomTimer.swift
//  CustomTimer
//
//  Created by guan_xiang on 2019/4/18.
//  Copyright © 2019 iGola_iOS. All rights reserved.
//  定时器开启后，如果不要记得取消
//  定时器开启后，如果不要记得取消
//  定时器开启后，如果不要记得取消
//  定时器开启后，如果不要记得取消
//  定时器开启后，如果不要记得取消

import UIKit

extension iGolaCustomTimer{
    
    /// 倒计时
    ///
    /// - Parameters:
    ///   - totalTime: 总时间差值
    ///   - handler: 每隔一秒及结束后的回调，通过 isOver 判断是结束时的回调还是每隔一秒的回调
    public func startCountDownTimer(totalTime : TimeInterval, handler: @escaping (_ isOver : Bool) -> ()){
        self.isOver = false
        
        self.handler = handler
        
        endTime = Date().timeIntervalSince1970 + totalTime
        
        self.totalTime = totalTime
        
        // 开始倒计时
        start()
    }
    
    /// 恢复倒计时
    public func resumeCountDownTimer(){
        guard let _ = handler else {
            assertionFailure("大佬，取消过的定时器是无法恢复的")
            return
        }
        
        isOver = false
        start()
    }
    
    /// 定时器
    ///
    /// - Parameters:
    ///   - duration: 定时器间隔时间
    ///   - handler: 定时器回调
    public func startTimer(duration : TimeInterval, handler : @escaping () -> ()){
        self.isOver = false
        
        timerHandler = handler
        
        self.duration = duration
        
        endTime = Date().timeIntervalSince1970 + duration
        
        bengin()
    }
    
    /// 恢复间隔相等定时器
    public func resumeTimer(){
        guard let _ = timerHandler else {
            assertionFailure("大佬，取消过的定时器是无法恢复的")
            return
        }
        
        isOver = false
        endTime = NSDate().timeIntervalSince1970 + duration
        bengin()
    }
    
    /// 时间间隔不等定时器
    ///
    /// - Parameters:
    ///   - timeArray: 时间间隔数组
    ///   - handler: 每次间隔点回调，当isOver = true时为最后一次回调，其他次回调都为false
    public func startUnEqualTimer(timeArray : [TimeInterval], handler : @escaping (_ isOver : Bool)->()){
        self.isOver = false
        
        if timeArray.count == 0 { return }
        
        self.timeArray = timeArray
        
        self.handler = handler
        
        self.beginTime = Date().timeIntervalSince1970
        
        endTime = Date().timeIntervalSince1970 + (timeArray.first ?? 0.0)
        
        unequalTimerStart()
    }
    
    /// 恢复间隔不等定时器
    public func resumeUnequalTimer(){
        guard let _ = handler else {
            assertionFailure("大佬，取消过的定时器是无法恢复的")
            return
        }
        
        isOver = false
        
        let now = Date().timeIntervalSince1970
        
        let duration = timeArray.reduce(0, +)
        
        let tempTime = beginTime + duration
        
        if now >= tempTime{
            // 定时器过期结束
            isOver = true
            handler?(true)
            return
        }
        
        // 获取当前时间在时间数组中的index
        for (index, number) in timeArray.enumerated(){
            if number + beginTime > now{
                self.index = index
                endTime = number + beginTime
                break
            }
        }
        
        unequalTimerStart()
    }

    /// 暂停倒计时、间隔相等定时器、间隔不等定时器
    public func suspendTimer(){
        isOver = true
    }
    
    /// 取消倒计时、间隔相等定时器、间隔不等定时器, 一旦取消则无法恢复
    public func cancelTimer(){
        isOver = true
        handler = nil
        timerHandler = nil
    }
    
}


class iGolaCustomTimer{
    /// 时间格式
    private lazy var formatDate : DateFormatter = {
        let format = DateFormatter()
        format.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.isLenient = true
        return format
    }()
    
    /// 结束时间
    private var endTime : TimeInterval = 0
    
    /// 倒计时、定时器 是否终止
    private var isOver : Bool = false
    
    //MARK: - 倒计时
    /// 倒计时总时间差值
    private var totalTime : TimeInterval = 0
    
    /// 倒计时回调
    private var handler : ((_ isOver : Bool) -> ())?
    
    
    //MARK: - 定时器(时间间隔相等)
    /// 定时器回调
    private var timerHandler : (()->())?
    /// 定时器间隔时间
    private var duration : TimeInterval = 1
    /// 当前数组索引
    private var index : Int = 0
    
    
    //MARK: - 特殊定时器(时间间隔不相等)
    private var timeArray : [TimeInterval] = []
    /// 开始时间
    private var beginTime : TimeInterval = 0
    
    
    deinit {
        print("\(self.self)释放了")
    }
    
    // 开启间隔不等定时器
    private func unequalTimerStart(){
        DispatchQueue.global().async {
            while !self.isOver {
                /** 误差0.01秒以内 */
                usleep(5 * 10000)
                let now = Date().timeIntervalSince1970
                if self.endTime - now <= 0{
                    self.index += 1
                    if self.timeArray.count - 1 >= self.index{
                        self.endTime = now + self.timeArray[self.index]
                        DispatchQueue.main.async {
                            self.handler?(self.isOver)
                        }
                    }else{
                        // 定时器结束
                        self.isOver = true
                        DispatchQueue.main.async {
                            self.handler?(self.isOver)
                        }
                    }
                }
            }
        }
    }
    
    
    // 定时器
    private func bengin(){
        DispatchQueue.global().async {
            while !self.isOver {
                /** 误差0.01秒以内 */
                usleep(5 * 10000)
                
                let currentTime = Date().timeIntervalSince1970
                if self.endTime - currentTime <= 0 {
                    self.endTime += self.duration
                    DispatchQueue.main.async {
                        self.timerHandler?()
                    }
                }
            }
        }
    }
    
    // 倒计时
    private func start(){
        DispatchQueue.global().async {
            while !self.isOver {
                /** 误差0.01秒以内 */
                usleep(5 * 10000)
                if self.totalTime > 0{
                    self.calculateTime()
                }else{
                    // 倒计时结束
                    self.isOver = true
                    DispatchQueue.main.async {
                        self.handler?(self.isOver)
                        self.handler = nil
                    }
                }
            }
        }
    }
    
    // 倒计时计算
    private func calculateTime(){
        let currentTime = Date().timeIntervalSince1970
        let tempString = formatDate.string(from: Date(timeIntervalSinceReferenceDate: endTime - currentTime))
        let endString = formatDate.string(from: Date(timeIntervalSinceReferenceDate: totalTime))
        
        if endString != tempString {
            totalTime = endTime - currentTime
            
            if totalTime <= 1{
                // 倒计时结束
                self.isOver = true
                DispatchQueue.main.async {
                    self.handler?(self.isOver)
                    self.handler = nil
                }
            }else{
                DispatchQueue.main.async {
                    self.handler?(self.isOver)
                }
            }
        }
    }
}
