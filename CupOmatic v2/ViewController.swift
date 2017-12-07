//
//  ViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
   
    
    var advancedMode = false
    
 
    var parentTimer : ParentTimer?
    var timerSegue = false
    var audio: Audio?
    
    
    @IBOutlet var mainTimerLabel: UILabel!
    
//   toolbar items
    
    @IBOutlet var bottomToolBar: UINavigationBar!
    @IBAction func settingsButton(_ sender: Any) {
    }
    
    @IBAction func infoButton(_ sender: Any) {
    }
    @IBAction func getReadyStopButton(_ sender: Any) {
        
        
      
        
        if parentTimer?.getMainTimerStatus() == false {
            performSegue(withIdentifier: "numberOfBowls", sender: self)
        } else {
            bottomToolBar.frame = CGRect(x: 0, y: view.frame.size.height - 44, width: view.frame.size.width, height: 375)
            parentTimer?.startTimer.invalidate()
            parentTimer?.invalidateMainTimer()
            parentTimer?.reset()
            parentTimer?.setMainTimerStatus(status: false)
            changeButton()
            
            
        }
    }
    @IBOutlet weak var getReadystop: UIButton!
    
    func changeButton(){

        if parentTimer?.getMainTimerStatus() == true {
            
        self.getReadystop.setTitle("Stop", for: UIControlState.normal)
        self.getReadystop.backgroundColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
            
        } else {
        
            getReadystop.setTitle("Get Ready ", for: UIControlState.normal)
            self.getReadystop.backgroundColor = UIColor(red: 10.0/255.0, green: 200.0/255.0, blue: 10.0/255.0, alpha: 1.0)
            
        }
    }
  

    @objc func start(){
        
        
        
        if parentTimer?.initiateMainTimer == true {
            parentTimer?.startStartTimer()
            parentTimer?.initiateMainTimer = false
            parentTimer?.setMainTimerStatus(status: true)
            
        }else{
            
                parentTimer?.invalidateMainTimer()
                parentTimer?.initiateMainTimer = true
                parentTimer?.setMainTimerStatus(status: false)
          
            }
    }
    
    // `timer outlets
    
    @IBOutlet weak var intervalProgress: MKMagneticProgress!
    @IBOutlet weak var pourProgress: MKMagneticProgress!
    @IBOutlet weak var breakProgress: MKMagneticProgress!
    @IBOutlet weak var sampleProgress: MKMagneticProgress!
 
    func updateProgressViews(){

        //intervalProgress
        
        if parentTimer?.intervalTimer.active == false {
            intervalProgress.percentLabelFormat = ""
            
        }else{
            intervalProgress.percentLabelFormat = parentTimer!.intervalTimer.getTimeLabel()
           
        }
        
        updateIntervalViews()
        
        pourProgress.percentLabelFormat = String(parentTimer!.timers[0].getBowlsPassed())
        pourProgress.setProgress(progress: parentTimer!.timers[0].getPercentage(), animated: true)

        breakProgress.percentLabelFormat = String(parentTimer!.timers[1].getBowlsPassed())
        breakProgress.setProgress(progress: parentTimer!.timers[1].getPercentage(), animated: true)

        sampleProgress.percentLabelFormat = String(parentTimer!.timers[2].getBowlsPassed())
        sampleProgress.setProgress(progress: parentTimer!.timers[2].getPercentage(), animated: true)

    }
    
    func updateIntervalViews(){
        
        
        if parentTimer?.intervalTimer.active == false {
        //    intervalProgress.percentLabelFormat = ""
            intervalProgress.setProgress(progress: 0.0, animated: false)
        }else{
       //     intervalProgress.percentLabelFormat = parentTimer!.intervalTimer.getTimeLabel()
            intervalProgress.setProgress(progress: (parentTimer?.intervalTimer.getIntervalPercentage())!, animated: false)
        }
        
      
    }
    
    
    func initialProgressView(){
        
        //intervalProgress
        
     
        intervalProgress.percentLabelFormat = ""
        intervalProgress.setProgress(progress: 0.0, animated: false)

        pourProgress.percentLabelFormat = String(parentTimer!.timers[0].getBowlsPassed() - 1)
        pourProgress.setProgress(progress: 0, animated: true)
        
        breakProgress.percentLabelFormat = String(parentTimer!.timers[1].getBowlsPassed())
        breakProgress.setProgress(progress: parentTimer!.timers[1].getPercentage(), animated: true)
        
        sampleProgress.percentLabelFormat = String(parentTimer!.timers[2].getBowlsPassed())
        sampleProgress.setProgress(progress: parentTimer!.timers[2].getPercentage(), animated: true)
        
    }
    
    
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    func setupGoStopButton(){
        getReadystop.layer.cornerRadius = 30.0
        getReadystop.layer.shadowOffset = CGSize(width: 2, height: 2)
        getReadystop.layer.shadowRadius = 2;
        getReadystop.layer.shadowOpacity = 0.5;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        advancedMode = (UserDefaults.standard.object(forKey: "advancedMode") != nil)
        print("Advanced made = \(advancedMode)")
        
        if parentTimer == nil{
            
        
            parentTimer = ParentTimer(viewController : self)

        }
        
        if timerSegue == true {
            
            bottomToolBar.frame = CGRect(x: 0, y: view.frame.size.height - 0, width: view.frame.size.width, height:0 )

            start()
        }
        
        setupGoStopButton()
        mainTimerLabel.text = parentTimer?.getMainTimerString(timerInput: (parentTimer?.mainTimer)! )
        intervalProgress.font = intervalProgress.font.withSize(50.0)
        
        initialProgressView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        changeButton()

    }


}

