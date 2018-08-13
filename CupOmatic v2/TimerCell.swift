//
//  TimerCell.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit
import AVFoundation

class TimerCell{

    private var label = String()
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var timerSetting: Int
    var bowlCount: Int
    var active: Bool
    var interval: Int
    var timePassed : Int
    var bowlsPassed : Int
    var iD = String()
    var player: AVAudioPlayer?
        
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
        
        bowlsPassed += 1
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
        self.active = false
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
    
    func getPercentage()-> CGFloat{

        return CGFloat(Float(bowlsPassed) / Float(bowlCount))
        
    }
    
    func getBowlsPassedString(numberOfBowls: Int) -> String {
        
        return String(getBowlsPassed())
    
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
    
    func playSound(){
        
        print("Try Audio")
        guard let url = Bundle.main.url(forResource: label, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
}

