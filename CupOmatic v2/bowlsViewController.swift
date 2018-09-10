//
//  bowlsViewController.swift
//  CupOmactic
//
//  Created by Andrew Johnson on 18.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

protocol BowlsPopupDelegate {
    func passBackData(timerSegue: Bool, bowlSetting: Int)
    
    
   
}

class bowlsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var numberOfBowls:Int = 0
    var bowls = ["1"]
    var selection: String = ""
    var delegate: BowlsPopupDelegate?
    
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
        popupView.center = self.view.center
        print(numberOfBowls)
        
        setupStartButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    @IBAction func setButton(_ sender: Any) {
        UserDefaults.standard.set(numberOfBowls, forKey: "numberOfBowlsSave")
        delegate?.passBackData(timerSegue: true, bowlSetting: numberOfBowls)
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
   
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
