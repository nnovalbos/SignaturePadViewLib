//
//  CGColor+Extension.swift
//  SignaturePadViewLib
//
//  Created by Nicolas Novalbos on 15/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGColor {

    func rgbColor() -> [CGFloat] {
        
        var rgb: [CGFloat] = [0,0,0]
        
        if let rgbComponents = components, let model = colorSpace?.model{
            
            switch model {
            case .rgb:
                
                rgb[0] = rgbComponents[0] * 255
                rgb[1] = rgbComponents[1] * 255
                rgb[2] = rgbComponents[2] * 255
                
            case .monochrome:
                
                rgb[0] = rgbComponents[0] * 255
                rgb[1] = rgbComponents[0] * 255
                rgb[2] = rgbComponents[0] * 255
                
            default:
                print("Warning! Default black color used")
            }
        }
        
        return rgb
    }
}
