# CustomTimer
iGolaCustomTimer集常规定时器、倒计时、间隔不等定时器于一身

### 懒加载定时器

```swift
    /// 倒计时
    lazy var coutDownTimer = iGolaCustomTimer()

    /// 常规定时器
    lazy var timer = iGolaCustomTimer()

    /// 间隔不等定时器
    lazy var unequalTimer = iGolaCustomTimer()
```

### 开启倒计时

```swift
    coutDownTimer.startCountDownTimer(totalTime: 10) { (isOver) in
        if isOver{
            self.coutDownLabel.text = "倒计时结束了"
        }else{
            self.coutDownLabel.text = self.formatDate.string(from: Date())
        }
    }
```

### 暂停倒计时

```swift
    coutDownTimer.suspendTimer()
```
### 恢复倒计时

```swift
    coutDownTimer.resumeCountDownTimer()
```
### 取消倒计时，一旦取消则无法恢复，需要重新startCountDownTimer

```swift
    coutDownTimer.cancelTimer()
```


### 开启规定时器

```swift
    timer.startTimer(duration: 2) {
        self.timerLabel.text = self.formatDate.string(from: Date())
    }
```

### 暂停规定时器

```swift
    timer.suspendTimer()
```
### 恢复规定时器

```swift
    timer.resumeTimer()
```
### 取消规定时器，一旦取消则无法恢复，需要重新startCountDownTimer

```swift
    timer.cancelTimer()
```


### 开启间隔不等定时器

```swift
    unequalTimer.startUnEqualTimer(timeArray: timeArray) { (isOver) in
        if isOver{
            self.unequalLabel.text = self.formatDate.string(from: Date()) + "结束了"
        }else{
            self.unequalLabel.text = self.formatDate.string(from: Date())
            self.index += 1
        }
    }
```

### 暂停间隔不等定时器

```swift
   unequalTimer.suspendTimer() 
```
### 恢复间隔不等定时器

```swift
    unequalTimer.resumeUnequalTimer()
```
### 取消间隔不等定时器，一旦取消则无法恢复，需要重新startCountDownTimer

```swift
    unequalTimer.cancelTimer()
```
