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
    
    @IBOutlet var startButton: UIButton!
    
    func setupStartButton(){
        startButton.layer.cornerRadius = 65.0
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
        UserDefaults.standard.set(numberOfBowls, forKey: "numberOfBowlsSave")
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
        bowlsPickerview.selectRow(numberOfBowls, inComponent: 0, animated: true)
        print(numberOfBowls)
        
        setupStartButton()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestViewController: ViewController = segue.destination as! ViewController
        DestViewController.timerSegue = true
     
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        UserDefaults.standard.set(numberOfBowls, forKey: "numberOfBowlsSave")
    

        
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
