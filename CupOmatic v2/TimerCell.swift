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
        self.bowlsPassed = bowlCount
        self.iD = iD
    }
    
    func activate(){
        self.active = true
    }
    
    func decreaseTimer(){
      
        if (active){
            
            timePassed -= 1
            
            if (bowlsPassed == 0){
                
                timePassed = 0
                self.active = false

                
            }else if (timePassed == 0){
                bowlsPassed -= 1
                timePassed = interval
               
            }
        }
    }
//    
//    init(label: String){
//        self.label = label
//        self.timerSetting = 0
//        self.bowlCount = 0
//    }
  
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
    


}

