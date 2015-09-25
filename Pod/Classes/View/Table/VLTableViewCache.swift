//
//  VLTableViewCache.swift
//  Pods
//
//  Created by Václav Luštěk.
//
//

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Import

import UIKit


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Settings


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Constants


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Protocols

public protocol VLTableViewCacheDelegate {
    
    func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String
    func cellForIdentifier(identifier: String) -> UITableViewCell
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) -> Void
}


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Class

public class VLTableViewCache {
 
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    public var delegate: VLTableViewCacheDelegate
    
    private let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    private var sizingCells: Dictionary<String, UITableViewCell> = [:]
    private var heightCache: Dictionary<NSIndexPath, CGFloat> = [:]
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Init
    
    public init(delegate: VLTableViewCacheDelegate) {
        
        self.delegate = delegate
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Cache
    
    public func sizingCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = nil
        let identifier: String = self.delegate.cellIdentifierForIndexPath(indexPath)
        
        cell = self.sizingCells[identifier]
        if (cell == nil) {
            
            cell = self.delegate.cellForIdentifier(identifier)
            self.sizingCells[identifier] = cell
        }
        
        return cell as UITableViewCell!
    }
    
    public func cachedHeightForRowAtIndexPath(indexPath: NSIndexPath, isEstimate: Bool) -> CGFloat {
        
        // Create an immutable indexPath so they have the same hash everytime
        let immutableIndexPath: NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
        
        var cachedHeight: CGFloat? = self.heightCache[immutableIndexPath]
        
        if (cachedHeight > 0) {
            // The cached height is ok, we return it in the end
            
        } else if (isEstimate) {
            // There is no cached height, but this is an estimate, so we request a cached height for the first row (which will get calculated in case it isn't already)
            
            let firstIndexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            let height: CGFloat = self.cachedHeightForRowAtIndexPath(firstIndexPath, isEstimate: false)
            
            return height
            
        } else {
            // The height isn't cached yet and is not an estimate, we need to calculate it
            
            cachedHeight = self.calculatedHeightForRowAtIndexPath(indexPath)
            self.heightCache[immutableIndexPath] = cachedHeight
        }
        
        return cachedHeight as CGFloat!
    }
    
    private func calculatedHeightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        
        let cell: UITableViewCell = self.sizingCellForIndexPath(indexPath)
        self.delegate.configureCell(cell, atIndexPath: indexPath)
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        cell.bounds = CGRect(x: 0, y: 0, width: self.screenWidth, height: cell.bounds.size.height)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let height: CGFloat = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
        
        return height
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Invalidation
    
    public func invalidateCache() -> Void {
        
        self.heightCache = [:]
    }
    
    public func invalidateHeightAtIndexPath(indexPath: NSIndexPath) -> Void {
        
        let immutableIndexPath: NSIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
        self.heightCache.removeValueForKey(immutableIndexPath)
    }
    
}
