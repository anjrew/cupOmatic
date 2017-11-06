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
    
    var interval = Int()
    var bowl = Int()
    var timerAlarms = Int()
    var timersIntervals = [Int]()
    var timer = Timer()
    var timers = [TimerCell]()
    var mainTimer = Int()
    var viewController : ViewController?
    var alarmSound = [String: Int]()
    var alarmWarning = 3
    
    
    
    //Start Timer
    var initiateMainTimer = true
    var startTimerSetting = 4
    var startTimer = Timer()
    var startTime = Int()
    var bowlSetting = Int ()
    
   
    
    
    init(viewController : ViewController){
       
        self.viewController = viewController
        isKeyPresentInUserDefaults()
        self.interval = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        self.bowl = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        self.startTimerSetting = 4
        reset()
        
        
        timersIntervals = [
            0,
            UserDefaults.standard.object(forKey: "breakSettingSave")  as! Int,
            UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "roundOneSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "roundTwoSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "roundThreeSettingSave") as! Int
        ]
        
//        timerAlarams = [
//        
//        ]
        
        timers = [
            TimerCell(label: "Pour", interval: interval, timerSetting: 0, bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Break", interval: interval, timerSetting: timersIntervals[1], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Sample", interval: interval, timerSetting: timersIntervals[2], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Round 1", interval: interval, timerSetting: timersIntervals[3], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Round 2", interval: interval, timerSetting: timersIntervals[4], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Round 3", interval: interval, timerSetting: timersIntervals[5], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int)
        ]
        
        timers[0].activate()
        
        alarmSound = UserDefaults.standard.object(forKey: "alarmSoundSave") as! [String : Int]
        
        print("HERE")
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
        
        //   if timerStart.contains(where: currentTime){
        
        
        
        //       }
        
    }
    
    
    func isKeyPresentInUserDefaults(){
        
        if (UserDefaults.standard.object(forKey: "isInitiated") == nil){
            
            UserDefaults.standard.set(12, forKey: "numberOfBowlsSave")
            
            UserDefaults.standard.set(5, forKey: "intervalSettingSave")
            UserDefaults.standard.set(0, forKey: "minutesResultSave")
            UserDefaults.standard.set(20, forKey: "secondsResultSave")
            
            UserDefaults.standard.set(60, forKey: "breakSettingSave")
            UserDefaults.standard.set(240, forKey: "breakMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "breakSecondsResultSave")
            
            UserDefaults.standard.set(120, forKey: "sampleSettingSave")
            UserDefaults.standard.set(10, forKey: "sampleMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "sampleSecondsResultSave")
            
            UserDefaults.standard.set(180, forKey: "roundOneSettingSave")
            UserDefaults.standard.set(13, forKey: "roundOneMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "roundOneSecondsResultSave")
            
            UserDefaults.standard.set(200, forKey: "roundTwoSettingSave")
            UserDefaults.standard.set(18, forKey: "roundTwoMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "roundTwoSecondsResultSave")
            
            UserDefaults.standard.set(300, forKey: "roundThreeSettingSave")
            UserDefaults.standard.set(22, forKey: "roundThreeMinutesResultSave")
            UserDefaults.standard.set(0, forKey: "roundThreeSecondsResultSave")
            
            UserDefaults.standard.set(["Index": 20, "Sound": 1336], forKey: "alarmSoundSave")
            
            UserDefaults.standard.set(4, forKey: "startTimerSetting")
            
            UserDefaults.standard.set(true, forKey: "isInitiated")
            
        }
    }
    
    // Reloading data in the containerview
    
    //    func refeshContainerview(collectionViewSection: [String]){
    //
    //        for n in collectionViewSection {
    //
    //            collectionViewSection[n].reloadItemsAtIndexPaths(n)
    //        }
    //
    //    }
    
    @objc func increaseTimer(){
        
        mainTimer += 1
        print(String(mainTimer) + " Main Timer")
        
        viewController?.mainTimerLabel.text = getMainTimerString(timerInput: mainTimer)
        viewController?.timeLabel.text = convertSecsmmss(timeInput: timers[0].getTimePassed())
        viewController?.bowlLabel.text = String(timers[0].getBowlsPassed())
        //      Checking to initiate timer
        
        var i = 0
        
        for timer in timers{
            
            if (timers[i].getTimerSetting()) > mainTimer {
                
                print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time Until " + convertSecsmmss(timeInput: timers[i].getTimerSetting() - mainTimer))
                if (timers[i].getTimerSetting() - mainTimer == alarmWarning){
                    AudioServicesPlaySystemSound(SystemSoundID(alarmSound["Sound"]!))
                }
                
            } else if (timers[i].getTimerSetting() == mainTimer){
                
                timers[i].activate()
                timers[i].bowlsPassed -= 1
                
                print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time passed " + convertSecsmmss(timeInput:(timers[i].getTimePassed())))
                
            } else {
                
                if(timers[i].getTimePassed() == alarmWarning){AudioServicesPlaySystemSound(SystemSoundID(alarmSound["Sound"]!)) }
                print("Label " + timers[i].getLabel() + " - Bowls passed " + String(timers[i].getBowlsPassed()) + " - Time passed " + convertSecsmmss(timeInput:(timers[i].getTimePassed())))
                
            }
            
            timer.decreaseTimer()
            
            
            
            i += 1
            
        }
        
        viewController?.collectionViewBowlId = (getBowlsArray())
        viewController?.collectionViewTimer = (getTimersArray())
        
        
        
        
        
    }
    
    
    func startStartTimer(){
        
        startTimer.invalidate()
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
        
        
    }
    
    func startMainTimer(){
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increaseTimer), userInfo: nil, repeats: true)
        
        
    }
    
    func getTitlesArray() -> [String] {
        
        
        var titlesArray = [String]()
        
        
        for timerCell in timers{
            //    print(timerCell.getLabel())
            
            titlesArray.append(timerCell.getLabel())
            
        }
        
        return titlesArray
        
    }
    
    func getBowlsArray() -> [String] {
        
        
        var bowlsArray = [String]()
        
        
        for bowlCell in timers{
            // print(String(bowlCell.getBowlsPassed()) + " Bowls passed")
            
            bowlsArray.append(String(bowlCell.getBowlsPassed()))
            
        }
        
        return bowlsArray
        
    }
    
    func getTimersArray() -> [String] {
        
        
        var timersArray = [String]()
        
        
        for timersCell in timers{
            //   print(timersCell.getTimerSetting())
            
            timersArray.append(String(timersCell.getTimePassed()))
            
        }
        
        return timersArray
        
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
            
            viewController?.mainTimerLabel.text = "Countdown"
            startTime -= 1
        }else{
            viewController?.mainTimerLabel.text = getMainTimerString(timerInput: startTime)
            print(startTime)
            startTime -= 1
            
        
        
            if (startTime < 0){
                
                viewController?.mainTimerLabel.text = "GO!"
                AudioServicesPlaySystemSound(SystemSoundID(alarmSound["Sound"]!))
                
            }
        
            if (startTime == -1){
                
             
                startTimer.invalidate()
                startMainTimer()
                
            }
        }
    }
    
    func reset(){
        //relate all to settings
        
        invalidateMainTimer()
        startTime = startTimerSetting
        mainTimer = 0
        initiateMainTimer = true
        viewController?.mainTimerLabel.text = getMainTimerString(timerInput: mainTimer)
        
    }
}











