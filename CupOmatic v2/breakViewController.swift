//
//  breakViewController.swift
//  CupOmactic
//
//  Created by Andrew Johnson on 19.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class breakViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBAction func clearUserDefaultsButton(_ sender: Any) {
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
    }
    
    
    
    
    
    @IBOutlet var breakPickerView: UIPickerView!
    
    var audioCodes = Audio().getListOfCodes()
    
    var timeDataBase = [[String]]()
    var minutes = ["0"]
    var minutesLabel = ["min"]
    var seconds = ["0"]
    var secondsLabel = ["sec"]
    var mins = 0
    var secs = 0
    var breakTimeSeconds = 0
    
    func breakTime(mins: Int, secs: Int) -> Int {
        
        let time = (mins * 60) + secs
        
        return time
        
    }
    
    
    var selection: String = ""
    var minutesResult = 0
    var secondsResult = 0
    
    
    func count() {
        
        var i = 0
        while (i < 59) {
            
            i += 1
            minutes.append(String(i))
            seconds.append(String(i))
            
        }
    }
    
    func updatePickerView(){
        
        timeDataBase.append(minutes)
        timeDataBase.append(minutesLabel)
        timeDataBase.append(seconds)
        timeDataBase.append(secondsLabel)
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeDataBase.count    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeDataBase[component].count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeDataBase[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component)
        print(row)
        
        switch (component) {
        case 0:
            minutesResult = Int(timeDataBase[component][row])!
            print(minutesResult)
            
        case 2:
            secondsResult = Int(timeDataBase[component][row])!
            print(secondsResult)
            
        default:break
            
        }
        breakTimeSeconds = (minutesResult * 60) + secondsResult
        UserDefaults.standard.set(minutesResult, forKey: "breakMinutesResultSave")
        UserDefaults.standard.set(secondsResult, forKey: "breakSecondsResultSave")
        UserDefaults.standard.set(breakTimeSeconds, forKey: "breakSettingSave")
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        breakTimeSeconds = (minutesResult * 60) + secondsResult
        UserDefaults.standard.set(breakTimeSeconds, forKey: "breakSettingSave")
        UserDefaults.standard.set(minutesResult, forKey: "breakMinutesResultSave")
        UserDefaults.standard.set(secondsResult, forKey: "breakSecondsResultSave")
        print(breakTimeSeconds)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           self.navigationItem.title = "Break settings"
        
        minutesResult = UserDefaults.standard.object(forKey: "breakMinutesResultSave") as! Int
        secondsResult = UserDefaults.standard.object( forKey: "breakSecondsResultSave") as! Int
        breakTimeSeconds = UserDefaults.standard.object(forKey: "breakSettingSave") as! Int
        
        count()
        updatePickerView()
        breakPickerView.dataSource = self
        breakPickerView.delegate = self
       
        
        breakPickerView.selectRow(minutesResult, inComponent: 0, animated: true)
        breakPickerView.selectRow(secondsResult, inComponent: 2, animated: true)
       
        
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
