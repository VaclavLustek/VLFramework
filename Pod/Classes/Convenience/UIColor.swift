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
    
    public class func randomColor() -> UIColor {
        
        let red: CGFloat = CGFloat(arc4random_uniform(256)) / CGFloat(255.0)
        let green: CGFloat = CGFloat(arc4random_uniform(256)) / CGFloat(255.0)
        let blue: CGFloat = CGFloat(arc4random_uniform(256)) / CGFloat(255.0)
        
        let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return color
    }
    
    public convenience init (hex: Int) {
        
        let red: CGFloat = CGFloat((hex >> 16) & 0xff) / 255
        let green: CGFloat = CGFloat((hex >> 08) & 0xff) / 255
        let blue: CGFloat = CGFloat((hex >> 00) & 0xff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
}



















