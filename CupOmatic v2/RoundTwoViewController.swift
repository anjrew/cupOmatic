//
//  RoundOneViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 05.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class RoundTwoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var dataBase = [[String]]()
    var minutes = ["0"]
    var mins = 0
    var roundTwoTimeSeconds = 0
    var selection: String = ""
    var minutesResult = 0
    var switchStatus = true
    
    @IBOutlet var roundTwoPickerView: UIPickerView!
    @IBAction func roundTwoSwitch(_ sender: UISwitch){
        
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

        }
    }
    
    func updatePickerView(){
        
        dataBase.append(minutes)
     
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
   
        default:break
            
        }
        roundTwoTimeSeconds = minutesResult * 60
        UserDefaults.standard.set(minutesResult, forKey: "roundTwoMinutesResultSave")
        UserDefaults.standard.set(roundTwoTimeSeconds, forKey: "roundTwoSettingSave")
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        roundTwoTimeSeconds = minutesResult * 60
        UserDefaults.standard.set(roundTwoTimeSeconds, forKey: "roundTwoSettingSave")
        UserDefaults.standard.set(minutesResult, forKey: "roundTwoMinutesResultSave")
        print(roundTwoTimeSeconds)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Round two settings"
        count()
        updatePickerView()
        
        minutesResult = UserDefaults.standard.object(forKey: "roundTwoMinutesResultSave") as! Int
        roundTwoTimeSeconds = UserDefaults.standard.object(forKey: "roundTwoSettingSave") as! Int
        
        roundTwoPickerView.selectRow(minutesResult, inComponent: 0, animated: true)
        
        
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

