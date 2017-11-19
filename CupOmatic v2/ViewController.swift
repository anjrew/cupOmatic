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
 
    var parentTimer : ParentTimer?
    var timerSegue = false
    var audio: Audio?
    
    @IBOutlet var mainTimerLabel: UILabel!
    
    @IBAction func getReadyStopButton(_ sender: Any) {
        
      
        
        if parentTimer?.getMainTimerStatus() == false {
            performSegue(withIdentifier: "numberOfBowls", sender: self)
        } else {
            
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
            print("YOYOYO")
            
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
    
    func updateProgressViews(tag:Int, progress: Float){
        
        intervalProgress.setProgress(progress: CGFloat(Int(parentTimer!.timers[0].interval)))
        
        
        
    }
    
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    func setupGoStopButton(){
        getReadystop.layer.cornerRadius = 8.0
        getReadystop.layer.shadowOffset = CGSize(width: 5, height: 5)
        getReadystop.layer.shadowRadius = 5;
        getReadystop.layer.shadowOpacity = 0.5;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
          print("chea")
        
        if parentTimer == nil{
            parentTimer = ParentTimer(viewController : self)

         //   NotificationCenter.default.addObserver(self, selector: #selector(start), name: NSNotification.Name(rawValue: "setButton"), object: nil)
        }
        
        if timerSegue == true {
            start()
        }
        
        setupGoStopButton()
        collectionViewHeader = (parentTimer?.getTitlesArray())!
        collectionViewBowlId = (parentTimer?.getBowlsArray())!
        collectionViewTimer = (parentTimer?.getTimersArray())!
        mainTimerLabel.text = parentTimer?.getMainTimerString(timerInput: (parentTimer?.mainTimer)! )
        intervalProgress.font = intervalProgress.font.withSize(25.0)
        
        
      

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

