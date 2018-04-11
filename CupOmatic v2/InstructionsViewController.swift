//
//  InstructionsViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 04.11.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class InstructionsViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBAction func resetuserDefaults(_ sender: Any) {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    func messageComposeViewController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
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
        
        self.dismiss(animated: true, completion: nil)
    }

    private func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

    
 
    @IBAction func composeEmailButton(_ sender: Any) {
        configureMailConposeViewController()
        sendEmailOne()
        showSendMailErrorAlert()
    }
    
    
// Methord 1
    
    func sendEmailOne(){
        
        let mailConposeViewController = MFMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailConposeViewController, animated: true, completion: nil)
        }else{
            self.showSendMailErrorAlert()
        }
    }
    
    func configureMailConposeViewController() -> MFMailComposeViewController {
        let mailcomposerVC = MFMailComposeViewController()
        mailcomposerVC.mailComposeDelegate = self
        mailcomposerVC.setToRecipients(["info@cupomatic.net"])
        mailcomposerVC.setSubject("Cupomatic Feedback")
        mailcomposerVC.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
        return mailcomposerVC
    }

    func showSendMailErrorAlert(){
        
        let sendMailErrorAlert = UIAlertController(title: "Could not send mail", message: "your device must have", preferredStyle: .alert)
        
        sendMailErrorAlert.show(self, sender: Any?.self)
    }
    
// Methord 2
    
    func sendEmailtwo() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@cupomatic.net"])
            mail.setSubject("Cupomatic Feedback")
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
            
        } else {
            // show failure alert
        }
    }
    
   
    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 1000
        
      //  self.navigationItem.title = "Instructions"


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
