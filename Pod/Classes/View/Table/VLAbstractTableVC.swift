//
//  VLAbstractTableVC.swift
//  Pods
//
//  Created by Václav Luštěk.
//
//

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Imports

import UIKit


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Settings


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Constants


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Class

public class VLAbstractTableVC: UIViewController {

    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    @IBOutlet public weak var tableView: UITableView!
    
    public var isSectioned: Bool = false
    public var sectionArray: Array<Array<AnyObject>> = []
    public var cellArray: Array<AnyObject> = []
    
    private var heightCache: VLTableViewCache!
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Init
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.heightCache = VLTableViewCache(delegate: self)
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View lifecycle
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        self.abstractSetup()
    }
    
    override public func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Setup
    
    func abstractSetup() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - UITableViewDataSource

extension VLAbstractTableVC: UITableViewDataSource {
    
    public func dataObjectForIndexPath(indexPath: NSIndexPath) -> AnyObject {
        // Return a config based on whether the table is sectioned or not
        
        let dataobject: AnyObject
        if (self.isSectioned) {
            dataobject = self.sectionArray[indexPath.section][indexPath.row]
        } else {
            dataobject = self.cellArray[indexPath.row]
        }
        return dataobject
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the count based on whether the table is sectioned or not
        
        let count: Int
        if (self.isSectioned) {
            count = self.sectionArray.count
        } else {
            count = 1
        }
        return count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the count based on whether the table is sectioned or not
        
        let count: Int
        if (self.isSectioned) {
            count = self.sectionArray[section].count
        } else {
            count = self.cellArray.count
        }
        return count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier: String = self.cellIdentifierForIndexPath(indexPath)
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell!
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
}


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - VLTableViewCache

extension VLAbstractTableVC: VLTableViewCacheDelegate {
    
    public func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        
        preconditionFailure("This method must be overridden")
    }
    
    public func cellForIdentifier(identifier: String) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell!
        return cell
    }
    
    public func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> Void {
        
        // Override is recommended
    }
}


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - UITableViewDelegate

extension VLAbstractTableVC: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let height: CGFloat = self.heightCache.cachedHeightForRowAtIndexPath(indexPath, isEstimate: true)
        return height
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let height: CGFloat = self.heightCache.cachedHeightForRowAtIndexPath(indexPath, isEstimate: false)
        return height
    }
}