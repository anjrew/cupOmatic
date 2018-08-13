//
//  bowlsViewController.swift
//  CupOmactic
//
//  Created by Andrew Johnson on 18.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class bowlsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var numberOfBowls:Int = 0
    var bowls = ["1"]
    var selection: String = ""
    
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var startButton: UIButton!
    
    func setupStartButton(){
        startButton.layer.cornerRadius = 50.0
        startButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        startButton.layer.shadowRadius = 2;
        startButton.layer.shadowOpacity = 0.5;
        
    }
    
    
    func count() {
        
        var i = 1
        while (i < 100) {
            
            i += 1
            bowls.append(String(i))
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bowls.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bowls[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = bowls[row]
        numberOfBowls = Int(bowls[row])!
        print(numberOfBowls)
    }
    
    
    
    @IBOutlet var bowlsPickerview: UIPickerView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Bowl Settings"
        numberOfBowls = UserDefaults.standard.object(forKey: "numberOfBowlsSave") as! Int
        
        count()
        bowlsPickerview.dataSource = self
        bowlsPickerview.delegate = self
        bowlsPickerview.selectRow(numberOfBowls - 1, inComponent: 0, animated: true)
        popupView.layer.cornerRadius = 10
        print(numberOfBowls)
        
        setupStartButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: ViewController = segue.destination as! ViewController
        DestViewController.timerSegue = true
        DestViewController.bowlSetting = numberOfBowls
    }
    
    @IBAction func setButton(_ sender: Any) {
        NotificationCenter.default.post(name:.saveBowlsNumber, object: self)
        UserDefaults.standard.set(numberOfBowls, forKey: "numberOfBowlsSave")
   
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
