//
//  ViewController.swift
//  CupOmatic v2
//
//  Created by Andrew Johnson on 31.10.17.
//  Copyright © 2017 Rinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionViewHeader = [String]()
    var collectionViewBowlId = [String]()
    var collectionViewTimer = [String]()
    
    var parentTimer = ParentTimer()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionViewHeader.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        
        let cellHeader = cell.viewWithTag(1) as! UILabel
        cellHeader.text = collectionViewHeader[indexPath.row]
        
        let cellCup = cell.viewWithTag(2) as! UILabel
        cellCup.text = collectionViewBowlId[indexPath.row]
        
        let cellTimer = cell.viewWithTag(3) as! UILabel
        cellTimer.text = collectionViewTimer[indexPath.row]
        
        return cell
    
 
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewHeader = parentTimer.getTitlesArray()
        collectionViewBowlId = parentTimer.getBowlsArray()
        collectionViewTimer = parentTimer.getTimersArray()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

