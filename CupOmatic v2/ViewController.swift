//
//  ViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var collectionViewHeader = [String]()
    var collectionViewBowlId = [String]()
    var collectionViewTimer = [String]()
    
    @IBOutlet var startStopButton: UIButton!
    
    var parentTimer : ParentTimer?
    
    @IBOutlet var mainTimerLabel: UILabel!
    
    @IBAction func startButton(_ sender: Any) {
        
        if parentTimer?.initiateMainTimer == true {
        
            if (parentTimer!.mainTimer > 0){
            
            parentTimer?.startMainTimer()
            parentTimer?.initiateMainTimer = false
            startStopButton.setImage(UIImage(named: "Stop"), for: UIControlState.normal)
            
            }else{
            
            parentTimer?.startStartTimer()
            parentTimer?.initiateMainTimer = false
            
            startStopButton.setImage(UIImage(named: "Stop"), for: UIControlState.normal)
           
        }
            }else{
                
                parentTimer?.invalidateMainTimer()
                parentTimer?.initiateMainTimer = true
                startStopButton.setImage(UIImage(named: "Start"), for: UIControlState.normal)
            }
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
    parentTimer?.reset()
    startStopButton.setImage(UIImage(named: "Start.png"), for: UIControlState.normal)
        
    }
    
    @IBOutlet var label: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var bowlLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // parentTimer?.isKeyPresentInUserDefaults()
        parentTimer = ParentTimer(viewController : self)
        
        collectionViewHeader = (parentTimer?.getTitlesArray())!
        collectionViewBowlId = (parentTimer?.getBowlsArray())!
        collectionViewTimer = (parentTimer?.getTimersArray())!
        mainTimerLabel.text = parentTimer?.getMainTimerString(timerInput: (parentTimer?.mainTimer)! )
        
      
// update timers
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true

    }


}

