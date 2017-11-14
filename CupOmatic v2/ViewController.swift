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
    var audio: Audio?
    
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
        parentTimer?.resetAllTimers()
        parentTimer?.updateUI()
    
        
    }
    
    // `timer outlets
    
    @IBOutlet var pourTimeLabel: UILabel!
    @IBOutlet var pourBowlLabel: UILabel!
    
    @IBOutlet var breakLabel: UILabel!
    @IBOutlet var breakTimeLabel: UILabel!
    @IBOutlet var breakBowLabel: UILabel!
    
    @IBOutlet var sampleLabel: UILabel!
    @IBOutlet var sampleTimeLabel: UILabel!
    @IBOutlet var sampleBowlLabel: UILabel!
    
    @IBOutlet var roundOneLabel: UILabel!
    @IBOutlet var roundOneTimeLabel: UILabel!
    @IBOutlet var roundOneBowlLabel: UILabel!
    
    @IBOutlet var roundTwoLabel: UILabel!
    @IBOutlet var roundTwoTimeLabel: UILabel!
    @IBOutlet var roundTwoBowlLabel: UILabel!
    
    @IBOutlet var roundThreeLabel: UILabel!
    @IBOutlet var roundThreeTimeLabel: UILabel!
    @IBOutlet var roundThreeBowlLabel: UILabel!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // parentTimer?.isKeyPresentInUserDefaults()
        parentTimer = ParentTimer(viewController : self)

        collectionViewHeader = (parentTimer?.getTitlesArray())!
        collectionViewBowlId = (parentTimer?.getBowlsArray())!
        collectionViewTimer = (parentTimer?.getTimersArray())!
        mainTimerLabel.text = parentTimer?.getMainTimerString(timerInput: (parentTimer?.mainTimer)! )
        
   //     let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
   //     label.center = CGPoint(x: 160, y: 285)
   //     label.textAlignment = .center
   //     label.text = "I'am a test label"
   //     self.view.addSubview(label)
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

