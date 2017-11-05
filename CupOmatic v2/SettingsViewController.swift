//
//  SettingsViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 04.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var parentTimer : ParentTimer?
    
    @IBOutlet var settingsTableViewOutlet: UITableView!
    var identitys = [String]()
    var tableViewCells = ["Number of bowls","Interval","Break", "Sample","First Round","Second Round","Third Round","Alarm sound","Alarm Warning","Action Sound","Vibrate"]
    var tableViewDetails = ["","","","","","","","","","",""]
    var tableSegues = ["bowls","interval","break","sample","roundOne","roundTwo","roundThree","alarmSound","alarmWarning","actionSound"]
    
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

        

//        tableViewDetails.append(String(describing: parentTimer?.getbowlSetting()))
//        tableViewDetails.append(String(parentTimer!.convertSecsmmss(timeInput: parentTimer!.getIntervalSetting())))
//        tableViewDetails.append(String(parentTimer!.convertSecsmmss(timeInput: parentTimer!.getBreakSetting())))
//        tableViewDetails.append(String(parentTimer!.convertSecsmmss(timeInput: parentTimer!.getSampleSetting())))
//        tableViewDetails.append(String(parentTimer!.convertSecsmmss(timeInput: parentTimer!.getFirstRoundSetting())))
//        tableViewDetails.append(String(parentTimer!.convertSecsmmss(timeInput: parentTimer!.getSecondRoundSetting())))
//        tableViewDetails.append(String(parentTimer!.convertSecsmmss(timeInput: parentTimer!.getThirdRoundSetting())))
        
        bowlSetting = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        intervalSetting = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        breakSetting = UserDefaults.standard.object(forKey: "breakSettingSave") as! Int
        sampleSetting = UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int
        roudnOneSetting = UserDefaults.standard.object(forKey: "roundOneSettingSave") as! Int
        roundTwoSetting = UserDefaults.standard.object(forKey: "roundTwoSettingSave") as! Int
        roundThreeSetting = UserDefaults.standard.object(forKey: "roundThreeSettingSave") as! Int
        
        alarmSoundDic = UserDefaults.standard.object(forKey: "alarmSoundSave") as! [String : Int]
        alarmSound = alarmSoundDic["Sound"]!
        
            //        alarmWarning = UserDefaults.standard.object(forKey: "alarmWarningSave") as! Int
//        actionSound = UserDefaults.standard.object(forKey: "actionSoundSave") as! Int
//
        tableViewDetails[0] = String(bowlSetting)
        tableViewDetails[1] = convertSecsmmss(timeInput: intervalSetting)
        tableViewDetails[2] = convertSecsmmss(timeInput: breakSetting)
        tableViewDetails[3] = convertSecsmmss(timeInput: sampleSetting)
        tableViewDetails[4] = convertSecsmmss(timeInput: roudnOneSetting)
        tableViewDetails[5] = convertSecsmmss(timeInput: roundTwoSetting)
        tableViewDetails[6] = convertSecsmmss(timeInput: roundThreeSetting)
        tableViewDetails[7] = String(alarmSound)
        tableViewDetails[8] = "Alarm warning"
        tableViewDetails[9] = "Action Sound"
        tableViewDetails[10] = "Vibrate Switch"

        identitys = ["bowlsViewController","intervalViewController","breakViewController","sampleViewController","firstRoundViewController","secondRoundViewController","thirdRoundViewController"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        bowlSetting = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        intervalSetting = UserDefaults.standard.object(forKey: "intervalSettingSave") as! Int
        breakSetting = UserDefaults.standard.object(forKey: "breakSettingSave") as! Int
        sampleSetting = UserDefaults.standard.object(forKey: "sampleSettingSave") as! Int
        roudnOneSetting = UserDefaults.standard.object(forKey: "roundOneSettingSave") as! Int
        roundTwoSetting = UserDefaults.standard.object(forKey: "roundTwoSettingSave") as! Int
        roundThreeSetting = UserDefaults.standard.object(forKey: "roundThreeSettingSave") as! Int
        //
        tableViewDetails[0] = String(bowlSetting)
        tableViewDetails[1] = convertSecsmmss(timeInput: intervalSetting)
        tableViewDetails[2] = convertSecsmmss(timeInput: breakSetting)
        tableViewDetails[3] = convertSecsmmss(timeInput: sampleSetting)
        tableViewDetails[4] = convertSecsmmss(timeInput: roudnOneSetting)
        tableViewDetails[5] = convertSecsmmss(timeInput: roundTwoSetting)
        tableViewDetails[6] = convertSecsmmss(timeInput: roundThreeSetting)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = tableViewCells[indexPath.row]
        cell.detailTextLabel?.text = tableViewDetails[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        //        self.navigationController?.pushViewController(viewController!, animated: true)
        performSegue(withIdentifier: tableSegues[indexPath.row], sender: self)
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
