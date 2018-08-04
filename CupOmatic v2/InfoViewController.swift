//
//  InfoViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 02.08.18.
//  Copyright © 2018 Rinson. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 9) {
            print("in openwebsite")
            UIApplication.shared.open(NSURL(string:"http://www.cupomatic.net/")! as URL)
            }
        
        
        if(indexPath.row == 10) {
            print("in send email")
            sendEmailOne()}
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.row].title
        cell.detailTextLabel?.text = sections[indexPath.row].description
        
        return cell
        
    }
    var sections: [(title: String, description: String)] = [
        ("Advanced mode","Adds sample collection, and tasting rounds to the session."),
        ("Voice prompts",        "Adds voice prompts."),
        ("Vibrate",         "If turned on, the phone vill vibrate for each action."),
        ("Main Timer",        "Is the large timer at the top of the main screen which shows the time since the start of the session."),
        ("Interval (Int)", "Shows the interval time between each action for each bowl."),
        ("Break (Br)", "The time at which you will break the crust on the cupping bowl. The arch progress bar labelled 'Br' indicates how many bowls should have been broken at that moment in time."),
        ("Sample (Sa)", "The point in time in which you take a coffee sample for testing (TDS etc.).The arch progress bar labelled 'Sa' indicates how many bowls should have been broken at that moment in time. Advance mode must be on to utilise this feature"),
        ("Rounds",  "The rounds will be called by the voice prompts. These are the points in which you should start the rounds of tasting. Advance mode must be on to utilise this feature."),
        ("Progress views", "These are the small circular progress views at the bottom of the screen. They indicate how many bowls the specific action should have already been performed on at that given moment."),
        ("Website", "Click here to visit 'www.cupomatic.net'."),
        ("Contact",    "For more information, and feedback, click here to email me: info@cupomatic.net"),
        ]
    
    //   Email Section
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue :
            print("Cancelled")
            
        case MFMailComposeResult.failed.rawValue :
            print("Failed")
            
        case MFMailComposeResult.saved.rawValue :
            print("Saved")
            
        case MFMailComposeResult.sent.rawValue :
            print("Sent")
            
        default: break
            
        }
        // Dismiss the mail compose view controller.
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func composeEmailButton(_ sender: Any) {
        sendEmailOne()
    }
    
    
    // Methord 1
    
    func sendEmailOne(){
        
        let mailConposeViewController = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailConposeViewController, animated: true, completion: nil)
        }else{
            self.showSendMailErrorAlert()
        }
    }
    
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailcomposerVC = MFMailComposeViewController()
        mailcomposerVC.mailComposeDelegate = self
        mailcomposerVC.setToRecipients(["info@cupomatic.net"])
        mailcomposerVC.setSubject("CupOmatic Feedback")
        mailcomposerVC.setMessageBody("You're so awesome!", isHTML: false)
        return mailcomposerVC
    }
    
    func showSendMailErrorAlert(){
        
        let sendMailErrorAlert = UIAlertController(title: "Could not send mail", message: "your device must have", preferredStyle: .alert)
        
        sendMailErrorAlert.show(self, sender: Any?.self)
    }
    
    
    func setUpNavBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Info"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25),NSAttributedStringKey.foregroundColor: UIColor.black]
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
