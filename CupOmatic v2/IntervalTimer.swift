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
    var second: Float
    var active: Bool
    
    @objc func decreaseTimer(){
        
        if bowlAmount > 0 {
            
            second -= 1
            
            
            if second.truncatingRemainder(dividingBy: 1) == 0{
                
                    time -= 1
            
                    if time == 0{
                        
                        time = timeSetting
                        bowlAmount -= 1
                        second = Float(timeSetting * 1)
                    }
            }

        }else if (bowlAmount == 0) {
    
            invalidateIntervalTimer()
            time = 0
            reset()
                    
        }else{

            bowlAmount -= 1
        }
    }
    
    
    func startTimer(){

    active = true
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
    
    }
    
    init(timeSetting: Int, bowlSetting: Int) {
            self.timeSetting = timeSetting
            self.bowlSetting = bowlSetting
            self.time = timeSetting
            self.bowlAmount = bowlSetting
            self.active = true
            self.second = Float(timeSetting * 1)
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
    
    func getseconds() -> Float{
        
        return second
        
    }
    
    func getIntervalPercentage() -> CGFloat {
        
        return CGFloat((Float(timeSetting * 1) - getseconds() ) / Float(timeSetting * 1))
        
    }
    
    func setBowlAmount(){
        
        
    }
}

