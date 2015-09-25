//
//  UIColor.swift
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

extension UIColor {
 
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Init
    
    public class func fromHSBA(hue: Int, _ saturation: Int, _ brightness: Int, _ alpha: Int) -> UIColor {
        
        let hueFloat: CGFloat = CGFloat(hue) / 360.0
        let saturationFloat: CGFloat = CGFloat(saturation) / 100.0
        let brightnessFloat: CGFloat = CGFloat(brightness) / 100.0
        let alphaFloat: CGFloat = CGFloat(alpha) / 100.0
        
        let color: UIColor = UIColor(hue: hueFloat, saturation: saturationFloat, brightness: brightnessFloat, alpha: alphaFloat)
        
        return color
    }
    
}



















