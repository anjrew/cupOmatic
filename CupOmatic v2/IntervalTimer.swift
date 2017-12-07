//
//  IntervalTimer.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 19.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import Foundation
import UIKit

class IntervalTimer {

  
    
    var timeSetting: Int
    var bowlSetting: Int
    var timer = Timer()
    var bowlAmount: Int
    var time: Int
  //  var second: Float
    var active: Bool
    var timeUnit = 10
    var parentTimer : ParentTimer?
    
    func setParentTimer (parentTimer : ParentTimer){
        self.parentTimer = parentTimer
    }
    
    @objc func decreaseTimer(){
        
        if bowlAmount > 0 {
              time -= 1
  //          second -= 1
            
            
//            if second.truncatingRemainder(dividingBy: 1) == 0{
//
//                    time -= 1
//
                   if time == 0{
//
                        time = timeSetting
                        bowlAmount -= 1
//                        second = Float(timeSetting * 1)
                    }
//            }

        }else if (bowlAmount == 0) {
        
            invalidateIntervalTimer()
            //time = 0
            reset()
                    
        }else{
            print("YOU SHOULDNT BE HERE")
            //bowlAmount -= 1
        }
        
        parentTimer?.viewController?.updateIntervalViews()
    }
    
    
    
    func startTimer(){
        active = true
        bowlAmount -= 1
       
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0 / Double(timeUnit)), target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
    
    }
    
    init(timeSetting: Int, bowlSetting: Int) {
            self.timeSetting = timeSetting * timeUnit
            self.bowlSetting = bowlSetting
            self.time = self.timeSetting
            self.bowlAmount = bowlSetting
            self.active = true
          //  self.second = Float(timeSetting * 1)
        }
    
    func invalidateIntervalTimer(){
        timer.invalidate()
        active = false

    }
    
    func reset(){
        
        bowlAmount = bowlSetting
        time = timeSetting
        active = false
       
        
    }
    
    func queryActive() -> Bool{
    
        return active
    
    }
    
    func getTimeLabel() -> String{
        return String(Int(trunc(( Double(time) / Double(timeUnit) ) )) )
        
    }
    
//    func getseconds() -> Float{
//
//        return second
//
//    }
    
    func getIntervalPercentage() -> CGFloat {
        
       // return CGFloat((Float(timeSetting * 1) - getseconds() ) / Float(timeSetting * 1))
        if(time == 0 ){
            return 0
        }
        return CGFloat(Double(timeSetting - time) / Double(timeSetting))
    }
    
    func setBowlAmount(){
        
        
    }
}

