//
//  SettingsViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 04.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let attrs = [
        NSAttributedStringKey.foregroundColor: UIColor.black,
        NSAttributedStringKey.font: UIFont(name: "Arial", size: 30)
    ]
    
    var parentTimer : ParentTimer?
    @IBOutlet var saveChangesButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var settingsTableViewOutlet: UITableView!
    var identitys = [String]()
    var tableViewCells = ["Advanced Mode","Interval","Break", "Sample","First Round","Second Round","Third Round","Vibrate"]
    var tableViewDetails = ["","","","","","","","","","",""]
    var tableSegues = ["advancedMode","interval","break","sample","roundOne","roundTwo","roundThree","vibrate"]
    
// Setting Variables
    
    var bowlSetting = Int()
    var intervalSetting = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
    var breakSetting = Int()
    var sampleSetting = Int()
    var roudnOneSetting = Int()
    var roundTwoSetting = Int()
    var roundThreeSetting = Int()
    var alarmSoundDic = [String: Int]()
    var alarmSound = Int()
    var alarmWarning = 3
    var actionSound = Int()
    var vibrate = true
    var advancedMode = false
    
    let advancedSwitch = UISwitch()
    @objc func advancedSwitchSwitchStateDidChange(_ sender:UISwitch!){
    
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            advancedMode = true
            UserDefaults.standard.set(true, forKey: "advancedMode")
            self.tableView.reloadData()
            print("Advanced mode = \(advancedMode)")
           
        }else{
            print("UISwitch state is now Off")
            advancedMode = false
            UserDefaults.standard.set(false, forKey: "advancedMode")
            self.tableView.reloadData()
            print("Advanced mode = \(advancedMode)")
            }
    }
    
    
    let vibrateSwitch = UISwitch()
    @objc func vibrateSwitchSwitchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            vibrate = true
            UserDefaults.standard.set(true, forKey: "vibrate")
            self.tableView.reloadData()
            print("Vibrate mode = \(vibrate)")
            
        }else{
            print("UISwitch state is now Off")
            vibrate = false
            UserDefaults.standard.set(false, forKey: "vibrate")
            self.tableView.reloadData()
            print("Vibrate mode = \(vibrate)")
    
        }
    }
    
    func reloadSettingsTableView(){
    
    //    settingsTableViewOutlet.reloadData()
        
    }
    
    func convertSecsmmss(timeInput: Int) -> String{
        
        let timeSecs = timeInput
        var timeString: String
        
        let minutes = timeSecs / 60
        let seconds = timeSecs % 60
        
        if minutes < 10 && seconds < 10{
            
            timeString = "0\(minutes):0\(seconds)"
            
        }else if minutes < 10 {
            
            timeString = "0\(minutes):\(seconds)"
            
        }else if seconds < 10 {
            
            timeString = "\(minutes):0\(seconds)"
            
            
        } else {
            
            timeString = "\(minutes):\(seconds)"
            
            
        }
        return timeString
    }
    
   

    override func viewDidLoad() {
       super.viewDidLoad()

        self.navigationItem.title = "Settings"
      
        
       //Switch assignments
        advancedSwitch.tag = 1
        advancedSwitch.addTarget(self, action: #selector(advancedSwitchSwitchStateDidChange), for: .valueChanged)
        
        vibrateSwitch.tag = 2
        vibrateSwitch.addTarget(self, action: #selector(vibrateSwitchSwitchStateDidChange), for: .valueChanged)
        

        vibrate = UserDefaults.standard.object(forKey: "vibrate") as! Bool
        advancedMode = UserDefaults.standard.object(forKey: "advancedMode") as! Bool
        print("Advanced mode = \(advancedMode)")
        print("vibrate mode = \(vibrate)")
        
        
        bowlSetting = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        intervalSetting = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        breakSetting = UserDefaults.standard.object(forKey: "breakSettingSave") as! Int
        sampleSetting = UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int
        roudnOneSetting = UserDefaults.standard.object(forKey: "roundOneSettingSave") as! Int
        roundTwoSetting = UserDefaults.standard.object(forKey: "roundTwoSettingSave") as! Int
        roundThreeSetting = UserDefaults.standard.object(forKey: "roundThreeSettingSave") as! Int
        
        alarmSoundDic = UserDefaults.standard.object(forKey: "alarmSoundSave") as! [String : Int]
        alarmSound = alarmSoundDic["Sound"]!

        tableViewDetails[1] = convertSecsmmss(timeInput: intervalSetting)
        tableViewDetails[2] = convertSecsmmss(timeInput: breakSetting)
        tableViewDetails[3] = convertSecsmmss(timeInput: sampleSetting)
        tableViewDetails[4] = convertSecsmmss(timeInput: roudnOneSetting)
        tableViewDetails[5] = convertSecsmmss(timeInput: roundTwoSetting)
        tableViewDetails[6] = convertSecsmmss(timeInput: roundThreeSetting)
       
        

        identitys = ["bowlsViewController","intervalViewController","breakViewController","sampleViewController",
                     "firstRoundViewController","secondRoundViewController","thirdRoundViewController"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.advancedSwitch.isOn = UserDefaults.standard.object(forKey: "advancedMode") as! Bool
        self.vibrateSwitch.isOn = UserDefaults.standard.object(forKey: "vibrate") as! Bool
    
        saveChangesButton.layer.cornerRadius = 20.0
        saveChangesButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        saveChangesButton.layer.shadowRadius = 2;
        saveChangesButton.layer.shadowOpacity = 0.5;
        
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
      

        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath)

 
        if indexPath.row == 0 {
                switchCell.textLabel!.text = "Adanced Mode"
                switchCell.accessoryView = advancedSwitch
                return switchCell
            
        }else if indexPath.row == 7 {
            switchCell.textLabel!.text = "Vibrate"
            switchCell.accessoryView = vibrateSwitch
            return switchCell
            
            
        } else {
            
            if advancedMode == true{
                cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
                cell.backgroundColor = self.view.backgroundColor
                cell.textLabel?.text = tableViewCells[indexPath.row]
                cell.detailTextLabel?.text = tableViewDetails[indexPath.row]
                return cell
            }else{
                if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6){
                    cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
                    cell.backgroundColor = self.view.backgroundColor
                    cell.textLabel?.text = tableViewCells[indexPath.row]
                    cell.detailTextLabel?.text = "Disabled"
                    return cell
                }else{
                    cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
                    cell.backgroundColor = self.view.backgroundColor
                    cell.textLabel?.text = tableViewCells[indexPath.row]
                    cell.detailTextLabel?.text = tableViewDetails[indexPath.row]
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if advancedMode == false{
            if (indexPath.row < tableSegues.count - 1 && indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 5 && indexPath.row != 6){
                performSegue(withIdentifier: tableSegues[indexPath.row], sender: self)
            }
        }else{
            if (indexPath.row < tableSegues.count - 1 && indexPath.row != 0){
            performSegue(withIdentifier: tableSegues[indexPath.row], sender: self)
            }
        }
    }
    
    
    func getAlarmwarning() -> Int {
        return alarmWarning
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
