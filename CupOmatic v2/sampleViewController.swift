//
//  sampleViewController.swift
//  CupOmactic
//
//  Created by Andrew Johnson on 18.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class sampleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var switchStatus = true
    
    @IBAction func sampleSwitch(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
            
            switchStatus = true
            print(switchStatus)
            
        }else{
            
            switchStatus = false
            print(switchStatus)
        }
    }
    
    
    @IBOutlet var samplePickerView: UIPickerView!
    var dataBase = [[String]]()
    var minutes = ["1"]
    var mins = 1
    var sampleTimeSeconds = 0
    
    func sampleTime(mins: Int, secs: Int) -> Int {
        
        let time = mins * 60
        
        return time
        
    }
    
    
    var selection: String = ""
    var minutesResult = 0
    var secondsResult = 0
    
    
    func count() {
        
        var i = 1
        while (i < 59) {
            
            i += 1
            minutes.append(String(i))

        }
    }
    
    func updatePickerView(){
        
        dataBase.append(minutes)
     
    
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataBase.count    }
    
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
        sampleTimeSeconds = minutesResult * 60
        UserDefaults.standard.set(minutesResult, forKey: "sampleMinutesResultSave")
        
        UserDefaults.standard.set(sampleTimeSeconds, forKey: "sampleSettingSave")

        
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        sampleTimeSeconds = minutesResult * 60
        UserDefaults.standard.set(sampleTimeSeconds, forKey: "sampleSettingSave")
        UserDefaults.standard.set(minutesResult, forKey: "sampleMinutesResultSave")
    
        print(sampleTimeSeconds)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Sample settings"

        
        minutesResult = UserDefaults.standard.object(forKey: "sampleMinutesResultSave") as! Int
        sampleTimeSeconds = UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int
        
        count()
        updatePickerView()
        samplePickerView.dataSource = self
        samplePickerView.delegate = self
    
        
            
        samplePickerView.selectRow(minutesResult, inComponent: 0, animated: true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
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
