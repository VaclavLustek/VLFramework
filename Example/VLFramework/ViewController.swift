//
//  ViewController.swift
//  VLFramework
//
//  Created by Václav Luštěk.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Imports

import UIKit
import VLFramework
import AFNetworking
import Bolts


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Settings


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Constants

let cellRegular: String = "RegularCell"


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Class

class ViewController: VLAbstractTableVC {

    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Init
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Setup
    
    func setup() {
        
        self.isSectioned = false
        self.cellArray = []
        
        
        for i in 1...10 {
            
            let config: VLCellConfig = VLCellConfig()
            
            var text: String = String(format: "%d", i)
            let random: Int = Int(arc4random() % 40) + 2
            for _ in 1...random {
                
                text = text.stringByAppendingString(" xx")
            }
            
            config.titleText = text
            self.cellArray.append(config)
        }
        
        self.view.backgroundColor = UIColor.fromHSBA(10, 90, 80, 100)
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - UITableViewDataSource
    
    override func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
    
        return cellRegular
    }
    
    override func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let cell: VLBaseCell = cell as! VLBaseCell
        let config: VLCellConfig = self.cellArray[indexPath.row];
        
        cell.titleText = config.titleText
    }
}
