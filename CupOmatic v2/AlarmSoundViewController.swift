//
//  AlarmSoundViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 05.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import AudioToolbox
import AVFoundation
import UIKit

class AlarmSoundViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var alarmSelection = ["Index" : Int(), "Sound" : Int()]
    var audioService = Audio()
    var rowChoice = Int()
    
    @IBOutlet var alarmSoundPickerView: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return audioService.listOfCodes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        return String(audioService.listOfCodes[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AudioServicesPlaySystemSound(SystemSoundID(audioService.listOfCodes[row]))
        alarmSelection["Index"] = row
        alarmSelection["Sound"] = audioService.listOfCodes[row]
        UserDefaults.standard.set(alarmSelection, forKey: "alarmSoundSave")
        print(alarmSelection)
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        UserDefaults.standard.set(alarmSelection, forKey: "alarmSoundSave")
        
    }
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmSelection = UserDefaults.standard.object(forKey: "alarmSoundSave") as! [String : Int]
        alarmSoundPickerView.selectRow(alarmSelection["Index"]!, inComponent: 0, animated: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
