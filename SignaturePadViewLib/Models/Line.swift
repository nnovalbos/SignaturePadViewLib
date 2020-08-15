//
//  Line.swift
//  SignaturePadViewLib
//
//  Created by Nicolas Novalbos on 05/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import Foundation
import CoreGraphics

class Line: NSObject {
    
    let points: CGRect
    let originPoint : CGPoint
    let endPoint:CGPoint
    
    
    init(withRect rect: CGRect ) {
        
        self.points = rect
        self.originPoint = self.points.origin
        self.endPoint = CGPoint(x: self.points.origin.x + self.points.size.width, y: self.points.origin.y + self.points.size.height)
    }
    
    func svgLine(withStrokeWidth width: CGFloat, withStrokeColor color: CGColor) -> String {
        
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat (0)
        
        if let rgbComponents = color.components {
            r = rgbComponents[0] * 255
            g = rgbComponents[1] * 255
            b = rgbComponents[2] * 255
        }
        
        return "<polyline points=\"\(originPoint.x), \(originPoint.y) \(endPoint.x), \(endPoint.y)\" fill=\"none\" style=\"stroke:rgb(\(r),\(g),\(b));stroke-width:\(width)\"/>"
    }
}
