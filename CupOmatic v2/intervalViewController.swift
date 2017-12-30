//
//  intervalViewController.swift
//  CupOmactic
//
//  Created by Andrew Johnson on 18.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class intervalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 
    var intervalTime = 20
    

    @IBOutlet var intervalPickerView: UIPickerView!
    
    var dataBase = [[String]]()
    var minutes = ["0"]
    var minutesLabel = ["min"]
    var seconds = ["0"]
    var secondsLabel = ["sec"]
    var settingsViewController = SettingsViewController()
    
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
        intervalTime = (minutesResult * 60) + secondsResult
        UserDefaults.standard.set(intervalTime, forKey: "intervalSettingSave")
        UserDefaults.standard.set(minutesResult, forKey: "minutesResultSave")
        UserDefaults.standard.set(secondsResult, forKey: "secondsResultSave")
    }
    
    @IBAction func setButton(_ sender: Any) {
        intervalTime = (minutesResult * 60) + secondsResult
        UserDefaults.standard.set(intervalTime, forKey: "intervalSettingSave")
        print(intervalTime)
        //settingsViewController.reloadSettingsTableView()

        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let settingsViewController = segue.destination as? SettingsViewController{
                
                settingsViewController.intervalSetting = intervalTime
                            }
        }
        
        
    }
    
        
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Interval settings"

        
        intervalTime = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        minutesResult = UserDefaults.standard.object(forKey: "minutesResultSave") as! Int
        secondsResult = UserDefaults.standard.object(forKey: "secondsResultSave") as! Int
        
        count()
        updatePickerView()
        intervalPickerView.dataSource = self
        intervalPickerView.delegate = self
 
        intervalPickerView.selectRow(minutesResult, inComponent: 0, animated: true)
        intervalPickerView.selectRow(secondsResult, inComponent: 2, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
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
