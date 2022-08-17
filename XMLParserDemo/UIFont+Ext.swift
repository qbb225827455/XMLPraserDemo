//
//  UIFont+Ext.swift
//  XMLParserDemo
//
//  Created by 陳鈺翔 on 2022/8/17.
//

import UIKit

extension UIFont {
    
    class func rounded(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            
            font = UIFont(descriptor: descriptor, size: size)
        
        } else {
            
            font = systemFont
        
        }
        
        return font
    }
}
