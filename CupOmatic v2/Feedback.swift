//
//  Feedback.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 22.01.18.
//  Copyright © 2018 Rinson. All rights reserved.
//
//

import Foundation
import StoreKit


var runs = UserDefaults.standard.object(forKey: "runs")




let minimumRunCount = 5
let runIncrementerSetting =  UserDefaults.standard.object(forKey: "FeedbackIncrement Setting")  as! Int // UserDefauls dictionary key where we store number of runs

                    // Minimum number of runs that we should have until we ask for review

func incrementAppRuns() {                   // counter for number of runs for the app. You can call this from App Delegate

    let usD = UserDefaults()
    let runs = getRunCounts() + 1
    usD.setValuesForKeys([runIncrementerSetting: runs])
    usD.synchronize()
}

func getRunCounts () -> Int {               // Reads number of runs from UserDefaults and returns it.
    
    let usD = UserDefaults()
    let savedRuns = usD.value(forKey: runIncrementerSetting) as? Int
    
    var runs = 0
    if (savedRuns != nil) {
        
        runs = savedRuns as! Int
    }
    
    print("Run Counts are \(runs)")
    return runs
    
}

func showReview() {
    
    let runs = getRunCounts()
    print("Show Review")
    
    if (runs > minimumRunCount) {
        
        if #available(iOS 10.3, *) {
            print("Review Requested")
            SKStoreReviewController.requestReview()
            
        } else {
            // Fallback on earlier versions
        }
        
    } else {
        
        print("Runs are not enough to request review!")
        
    }
    
}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    incrementAppRuns()
    return true
}
