//
//  TimerCell.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class TimerCell{

    private var label = String()
    
    var timerSetting: Int
    var bowlCount: Int
    var active: Bool
    var interval: Int
    var timePassed : Int
    var bowlsPassed : Int
    var iD = String()
        
    init(label: String, interval: Int, timerSetting: Int, bowlCount:Int, iD: String){
       
        self.label = label
        self.bowlCount = bowlCount
        self.timerSetting = timerSetting
        self.active = false
        self.interval = interval
        self.timePassed = interval
        self.bowlsPassed = 0
        self.iD = iD
    }
    
    func activate(){
        self.active = true
    }
    
    func decreaseTimer(){
      
        if (active){
            
            timePassed -= 1
            
            if (bowlsPassed == bowlCount){
                
                timePassed = 0
                self.active = false

                
            }else if (timePassed == 0){
                bowlsPassed += 1
                timePassed = interval
               
            }
        }
    }
    
    func resetTimer(){
        timePassed = interval
        bowlsPassed = 0
    }

  
    func getLabel() -> String{
        return self.label
    }
    
    func getBowlCount() -> Int{
        return self.bowlCount
    }
    
    func getTimerSetting() -> Int{
        return self.timerSetting
    }
    
    func getBowlsPassed() -> Int{
        return self.bowlsPassed
    }
    
    func getTimePassed() -> Int{
        return self.timePassed
    }
    
    func getId() -> String{
        return self.iD
    }
    
    func getTimeUntil(mainTimerTime:Int) -> Int{
        return mainTimerTime - timePassed
    }
    
    func getDisplayTime(mainTimer: Int) -> Int {
        if mainTimer <= timerSetting {
            
            return timerSetting - mainTimer
            
            }else if(timerSetting == mainTimer){
            
            activate()
            return 0
            
            }else{
            
            return getTimePassed()
        
        }
        
      }
    
}

