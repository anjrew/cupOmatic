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
    
    init(label: String, timerSetting: Int, bowlCount:Int){
       
        self.label = label
        self.bowlCount = bowlCount
        self.timerSetting = timerSetting
        
        
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

}

