//
//  staticDisplayValues.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ParentTimer {
    var advancedMode = false
    var vibrate = false
    var interval = Int()
    var bowl = Int()
    var timerAlarms = Int()
    var timersIntervals = [Int]()
    var timer = Timer()
    var timers = [TimerCell]()
    var mainTimer = Int()
    var viewController : ViewController?
    var alarmSound = [String: Int]()
    var alarmWarning = 1
    var audio = Audio()
    var intervalTimer: IntervalTimer?
    
    //Start Timer
    var initiateMainTimer = true
    var startTimerSetting = 4
    var startTimer = Timer()
    var startTime = Int()
    var bowlSetting = Int ()
    var running = false
    
    init(viewController : ViewController){
        self.advancedMode = UserDefaults.standard.object(forKey: "advancedMode") as! Bool
        self.vibrate = UserDefaults.standard.object(forKey: "vibrate") as! Bool
        self.viewController = viewController
        isKeyPresentInUserDefaults()
        self.interval = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        self.bowl = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        self.startTimerSetting = 4
        self.intervalTimer = IntervalTimer(timeSetting: UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int, bowlSetting: (UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int))
        reset()
        
        intervalTimer?.setParentTimer(parentTimer: self)
        
        
        timersIntervals = [
            0,
            UserDefaults.standard.object(forKey: "breakSettingSave")  as! Int,
            UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "roundOneSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "roundTwoSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "roundThreeSettingSave") as! Int
        ]
        
        
        timers = [
            TimerCell(label: "Pour", interval: interval, timerSetting: 0, bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave" ) as! Int, iD: "pour"),
            TimerCell(label: "Break", interval: interval, timerSetting: timersIntervals[1], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int, iD: "break"),
            TimerCell(label: "Sample", interval: interval, timerSetting: timersIntervals[2], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int, iD: "roundOne"),
            TimerCell(label: "Round 1", interval: interval, timerSetting: timersIntervals[3], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int, iD: "roundTwo"),
            TimerCell(label: "Round 2", interval: interval, timerSetting: timersIntervals[4], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int, iD: "roundThree"),
            TimerCell(label: "Round 3", interval: interval, timerSetting: timersIntervals[5], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int, iD: "roundFour")
        ]
        
        
        
        alarmSound = UserDefaults.standard.object(forKey: "alarmSoundSave") as! [String : Int]
        
    }
    
    // Get Settings
    
    func getbowlSetting() -> Int {
        return bowlSetting
    }
    
    func getIntervalSetting() -> Int {
        return timers[0].timerSetting
    }
    
    func getBreakSetting() -> Int {
        return timers[1].timerSetting
    }
    
    func getSampleSetting() -> Int {
        return timers[2].timerSetting
    }
    
    func getFirstRoundSetting() -> Int {
        return timers[3].timerSetting
    }
    
    func getSecondRoundSetting() -> Int {
        return timers[4].timerSetting
    }
    
    func getThirdRoundSetting() -> Int {
        return timers[5].timerSetting
    }
    
    func shouldStartTimer(currentTime : Int){
        
        
    }
    
    
    func isKeyPresentInUserDefaults(){
        
        if (UserDefaults.standard.object(forKey: "isInitiated") == nil){
            
            UserDefaults.standard.set(false, forKey: "advancedMode")
            UserDefaults.standard.set(false, forKey: "vibrate")
            
            UserDefaults.standard.set(12, forKey: "numberOfBowlsSave")
            
            UserDefaults.standard.set(20, forKey: "intervalSettingSave")
            UserDefaults.standard.set(0, forKey: "minutesResultSave")
            UserDefaults.standard.set(20, forKey: "secondsResultSave")
            
            UserDefaults.standard.set(240, forKey: "breakSettingSave")
            UserDefaults.standard.set(4, forKey: "breakMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "breakSecondsResultSave")
            
            UserDefaults.standard.set(600, forKey: "sampleSettingSave")
            UserDefaults.standard.set(10, forKey: "sampleMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "sampleSecondsResultSave")
            
            UserDefaults.standard.set(780, forKey: "roundOneSettingSave")
            UserDefaults.standard.set(13, forKey: "roundOneMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "roundOneSecondsResultSave")
            
            UserDefaults.standard.set(1080, forKey: "roundTwoSettingSave")
            UserDefaults.standard.set(18, forKey: "roundTwoMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "roundTwoSecondsResultSave")
            
            UserDefaults.standard.set(1320, forKey: "roundThreeSettingSave")
            UserDefaults.standard.set(22, forKey: "roundThreeMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "roundThreeSecondsResultSave")
            
            UserDefaults.standard.set(["Index": 20, "Sound": 1336], forKey: "alarmSoundSave")
            
            UserDefaults.standard.set(4, forKey: "startTimerSetting")
            
            UserDefaults.standard.set(true, forKey: "isInitiated")
        }
    }
    
    
    
    // Main Timer
    
    @objc func increaseTimer(){
        
        mainTimer += 1
        
        viewController?.updateProgressViews()
        
        
        print(getMainIntervalPercentage())
        
        print(String(mainTimer) + " Main Timer")
        
        viewController?.mainTimerLabel.text = getMainTimerString(timerInput: mainTimer)
        
        
        
        // arrangeing viewcontroller toolbar depending on parent timer status
        
        if running == true{
            
            viewController?.navigationController?.setToolbarHidden(true, animated: true)
            
        }else{
            
            viewController?.navigationController?.setToolbarHidden(false, animated: true)
            
        }
        
        
        var i = 0
        
        for timer in timers{
            
            if advancedMode == false{
                
                if i < 2 {
                    
                    if (timers[i].getTimerSetting()) > mainTimer {
                        
                        print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time Until " + convertSecsmmss(timeInput: timers[i].getTimerSetting() - mainTimer))
                        
                        if (timers[i].getTimerSetting() - mainTimer == (alarmWarning + 1 )){
                            timer.playSound()
                        }
                        
                        if (timers[i].getTimerSetting() - mainTimer == (alarmWarning + 10 )){
                            audio.playGetReady()
                        }
                        
                    } else if (timers[i].getTimerSetting() == mainTimer){
                        
                        intervalTimer?.timer.invalidate()
                        intervalTimer?.reset()
                        intervalTimer?.startTimer()
                        timers[i].activate()
                        AudioServicesPlaySystemSound(SystemSoundID(1256))
                        vibrateProcess()
                        
                        
                        print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time passed " + convertSecsmmss(timeInput:(timers[i].getTimePassed())))
                        
                    } else {
                        
                        if(timers[i].getTimePassed() == alarmWarning){
                            AudioServicesPlaySystemSound(SystemSoundID(1256))
                            vibrateProcess()
                        }
                        
                        print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time passed " + convertSecsmmss(timeInput:(timers[i].getTimePassed())))
                    }
                    
                }
                
            }else{
            
            if (timers[i].getTimerSetting()) > mainTimer {
                
                print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time Until " + convertSecsmmss(timeInput: timers[i].getTimerSetting() - mainTimer))
                
                if (timers[i].getTimerSetting() - mainTimer == (alarmWarning + 1 )){
                    timer.playSound()
                }
                
                if (timers[i].getTimerSetting() - mainTimer == (alarmWarning + 10 )){
                    audio.playGetReady()
                }
                
            } else if (timers[i].getTimerSetting() == mainTimer){
                
                intervalTimer?.timer.invalidate()
                intervalTimer?.reset()
                intervalTimer?.startTimer()
                timers[i].activate()
                AudioServicesPlaySystemSound(SystemSoundID(1256))
                vibrateProcess()
                
                
                print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time passed " + convertSecsmmss(timeInput:(timers[i].getTimePassed())))
                
            } else {
                
                if(timers[i].getTimePassed() == alarmWarning){
                    AudioServicesPlaySystemSound(SystemSoundID(1256))
                    vibrateProcess()
                }
                
                print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time passed " + convertSecsmmss(timeInput:(timers[i].getTimePassed())))
                }
                
            }
            
            timer.decreaseTimer()
            
            i += 1
        }
        
    }
    
    func getMainIntervalPercentage() -> CGFloat{
        print("Interval time = \(String(describing: intervalTimer?.time)) - Bowl Count = \(String(describing: intervalTimer?.bowlAmount))")
        return intervalTimer!.getIntervalPercentage()
        
    }
    
    
    func startStartTimer(){
        
        startTimer.invalidate()
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
        
        running = true
        
    }
    
    func startMainTimer(){
        
        timer.invalidate()
        
        intervalTimer?.startTimer()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increaseTimer), userInfo: nil, repeats: true)
        
    }
    
    func getTitlesArray() -> [String] {
        
        
        var titlesArray = [String]()
        
        
        for timerCell in timers{
            
            titlesArray.append(timerCell.getLabel())
            
        }
        
        return titlesArray
        
    }
    
    func getBowlsArray() -> [String] {
        
        
        var bowlsArray = [String]()
        
        
        for bowlCell in timers{
            
            bowlsArray.append(String(bowlCell.getBowlsPassed()))
            
        }
        
        return bowlsArray
        
    }
    
    func getTimersArray() -> [String] {
        
        
        var timersArray = [String]()
        
        
        for timersCell in timers{
            
            timersArray.append(String(timersCell.getTimePassed()))
            
        }
        
        return timersArray
        
    }
    
    func getMainTime() -> Int {
        
        return mainTimer
        
    }
    
    func convertSecsmmss(timeInput: Int) -> String{
        
        let timeSecs = timeInput
        var timeString: String
        
        let minutes = timeSecs / 60
        let seconds = timeSecs % 60
        
        if minutes < 10 && seconds < 10{
            
            timeString = "0\(minutes):0\(seconds)"
            
        }else if minutes < 10 {
            
            timeString = "0\(minutes):\(seconds)"
            
        }else if seconds < 10 {
            
            timeString = "\(minutes):0\(seconds)"
            
            
        } else {
            
            timeString = "\(minutes):\(seconds)"
            
            
        }
        return timeString
    }
    
    func getMainTimerString(timerInput: Int) -> String{
        return convertSecsmmss(timeInput: timerInput)
    }
    
    func invalidateMainTimer(){
        timer.invalidate()
    }
    
    @objc func decreaseTimer(){
        
        if (startTime == startTimerSetting){
            
            viewController?.mainTimerLabel.text = "Ready"
            startTime -= 1
            
        }else{
            
            viewController?.mainTimerLabel.text = getMainTimerString(timerInput: startTime)
            print(startTime)
            startTime -= 1
            
            if (startTime >= 0){AudioServicesPlaySystemSound(SystemSoundID(1072))}
            
            
            
            if (startTime < 0){
                
                viewController?.mainTimerLabel.text = "GO!"
                timers[0].playSound()
                vibrateProcess()
                timers[0].activate()
                
            }
            
            if (startTime == -1){
                
                
                startTimer.invalidate()
                startMainTimer()
                
            }
        }
    }
    
    func reset(){
        
        invalidateMainTimer()
        startTime = startTimerSetting
        mainTimer = 0
        initiateMainTimer = true
        viewController?.mainTimerLabel.text = getMainTimerString(timerInput: mainTimer)
        resetAllTimers()
        intervalTimer?.invalidateIntervalTimer()
        running = false
        
    }
    
    
    func resetAllTimers(){
        for time in timers{
            time.resetTimer()
        }
    }
    
    func updateProgressBars(){
        
    }
    
    func setMainTimerStatus(status: Bool){
        
        running = status
        
    }
    
    func getMainTimerStatus() -> Bool{
        
        return running
        
    }
    
    func vibrateProcess(){
        
        if vibrate == true{
            
            AudioServicesPlaySystemSound(SystemSoundID(1020))
        }
    }
    
    
    
    
} 
