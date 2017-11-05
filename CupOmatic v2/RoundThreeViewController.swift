//
//  RoundOneViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 05.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class RoundThreeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var dataBase = [[String]]()
    var minutes = ["0"]
    var minutesLabel = ["min"]
    var seconds = ["0"]
    var secondsLabel = ["sec"]
    var mins = 0
    var secs = 0
    var roundThreeTimeSeconds = 0
    var selection: String = ""
    var minutesResult = 0
    var secondsResult = 0
    var switchStatus = true
    
    @IBOutlet var roundThreePickerView: UIPickerView!
    @IBAction func roundThreeSwitch(_ sender: UISwitch){
        
        if (sender.isOn == true) {
            
            switchStatus = true
            print(switchStatus)
            
        }else{
            
            switchStatus = false
            print(switchStatus)
        }
        
        
    }
    
    
    
    
    
    func count() {
        
        var i = 0
        while (i < 59) {
            
            i += 1
            minutes.append(String(i))
            seconds.append(String(i))
        }
    }
    
    func updatePickerView(){
        
        dataBase.append(minutes)
        dataBase.append(minutesLabel)
        dataBase.append(seconds)
        dataBase.append(secondsLabel)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataBase.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataBase[component].count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataBase[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component)
        print(row)
        
        switch (component) {
        case 0:
            minutesResult = Int(dataBase[component][row])!
            print(minutesResult)
            
        case 2:
            secondsResult = Int(dataBase[component][row])!
            print(secondsResult)
            
        default:break
            
        }
        roundThreeTimeSeconds = (minutesResult * 60) + secondsResult
        UserDefaults.standard.set(minutesResult, forKey: "roundThreeMinutesResultSave")
        UserDefaults.standard.set(secondsResult, forKey: "roundThreeSecondsResultSave")
        UserDefaults.standard.set(roundThreeTimeSeconds, forKey: "roundThreeSettingSave")
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        roundThreeTimeSeconds = (minutesResult * 60) + secondsResult
        UserDefaults.standard.set(roundThreeTimeSeconds, forKey: "roundThreeSettingSave")
        UserDefaults.standard.set(minutesResult, forKey: "roundThreeMinutesResultSave")
        UserDefaults.standard.set(secondsResult, forKey: "roundThreeSecondsResultSave")
        print(roundThreeTimeSeconds)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Round Three settings"
        count()
        updatePickerView()
        
        minutesResult = UserDefaults.standard.object(forKey: "roundThreeMinutesResultSave") as! Int
        secondsResult = UserDefaults.standard.object( forKey: "roundThreeSecondsResultSave") as! Int
        roundThreeTimeSeconds = UserDefaults.standard.object(forKey: "roundThreeSettingSave") as! Int
        
        roundThreePickerView.selectRow(minutesResult, inComponent: 0, animated: true)
        roundThreePickerView.selectRow(secondsResult, inComponent: 2, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
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

