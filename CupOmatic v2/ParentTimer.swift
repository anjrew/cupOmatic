//
//  staticDisplayValues.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class ParentTimer {
    
    var interval = Int() //= UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
    var bowl = Int() //= UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
    var timersIntervals = [Int]()
    var timer = Timer()
    var timers = [TimerCell]()
    var mainTimer = Int()
    var viewController : ViewController?
    
    init(){
        
    }
    
    init(viewController : ViewController){
        self.viewController = viewController
        isKeyPresentInUserDefaults()
        self.interval = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        self.bowl = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        self.startTimer()
        
        
        timersIntervals = [
            0,
            UserDefaults.standard.object(forKey: "breakSettingSave")  as! Int,
            UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int,
            UserDefaults.standard.object(forKey: "round1SettingSave") as! Int,
            UserDefaults.standard.object(forKey: "round2SettingSave") as! Int,
            UserDefaults.standard.object(forKey: "round3SettingSave") as! Int
        ]
        
        timers = [
            TimerCell(label: "Pour", interval: interval, timerSetting: 0, bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Break", interval: interval, timerSetting: timersIntervals[1], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Sample", interval: interval, timerSetting: timersIntervals[2], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Round 1", interval: interval, timerSetting: timersIntervals[3], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Round 2", interval: interval, timerSetting: timersIntervals[4], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int),
            TimerCell(label: "Round 3", interval: interval, timerSetting: timersIntervals[5], bowlCount: UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int)
        ]
        
        timers[0].activate()
        
        
        print("HERE")
    }
    
    func shouldStartTimer(currentTime : Int){
        
        //   if timerStart.contains(where: currentTime){
        
        
        
        //       }
        
    }
    
    
    func isKeyPresentInUserDefaults(){
        
        if (UserDefaults.standard.object(forKey: "isInitiated") == nil){
            
            UserDefaults.standard.set(12, forKey: "numberOfBowlsSave")
            
            UserDefaults.standard.set(20, forKey: "intervalSettingSave")
            
            UserDefaults.standard.set(240, forKey: "breakSettingSave")
            
            UserDefaults.standard.set(600, forKey: "sampleSettingSave")
            
            UserDefaults.standard.set(660, forKey: "round1SettingSave")
            
            UserDefaults.standard.set(1080, forKey: "round2SettingSave")
            
            UserDefaults.standard.set(1320, forKey: "round3SettingSave")
            
            UserDefaults.standard.set(true, forKey: "isInitiated")
            
        }
    }
    
    
    
    @objc func decreaseTimer(){
       
        mainTimer += 1
        print(mainTimer)
        viewController?.mainTimerLabel.text = getMainTimerString()
        for timer in timers{
            timer.decreaseTimer()
        }
        
        viewController?.collectionViewBowlId = (getBowlsArray())
        viewController?.collectionViewTimer = (getTimersArray())
      //  viewController?.reloadData()
    }
    
    func startTimer(){
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
        
        
    }
    
    func getTitlesArray() -> [String] {
        
        
        var titlesArray = [String]()
        
        
        for timerCell in timers{
            print(timerCell.getLabel())
            
            titlesArray.append(timerCell.getLabel())
            
        }
        
        return titlesArray
        
    }
    
    func getBowlsArray() -> [String] {
        
        
        var bowlsArray = [String]()
        
        
        for bowlCell in timers{
            print(bowlCell.getBowlCount())
            
            bowlsArray.append(String(bowlCell.getBowlsPassed()))
            
        }
        
        return bowlsArray
        
    }
    
    func getTimersArray() -> [String] {
        
        
        var timersArray = [String]()
        
        
        for timersCell in timers{
            print(timersCell.getTimerSetting())
            
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
    
    func getMainTimerString() -> String{
      return convertSecsmmss(timeInput: mainTimer)
    }
    
    
    
    
    
}











