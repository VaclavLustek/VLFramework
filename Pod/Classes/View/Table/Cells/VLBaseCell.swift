//
//  VLBaseCell.swift
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
// MARK: - Class

public class VLBaseCell: UITableViewCell {
 
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    public var titleText: String? = nil {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    public var subtitleText: String? = nil {
        didSet {
            self.subtitleLabel.text = subtitleText
        }
    }
    
    
    @IBOutlet private weak var mainIV: UIImageView!
    
    public var mainImage: UIImage? = nil {
        didSet {
            self.mainIV.image = mainImage;
        }
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Layout
    
    public override var bounds: CGRect {
        didSet {
            self.contentView.bounds = bounds
        }
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.contentView.setNeedsUpdateConstraints()
        self.contentView.updateConstraintsIfNeeded()
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        
        if let titleLabel: UILabel = self.titleLabel {
            titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(titleLabel.bounds)
        }
        if let subtitleLabel: UILabel = self.subtitleLabel {
            subtitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(subtitleLabel.bounds)
        }
    }
}



















