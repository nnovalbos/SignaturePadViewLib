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
        
        let rgbValues = color.rgbColor()
        
        return "<polyline points=\"\(originPoint.x), \(originPoint.y) \(endPoint.x), \(endPoint.y)\" fill=\"none\" style=\"stroke:rgb(\(rgbValues[0]),\(rgbValues[1]),\(rgbValues[2]));stroke-width:\(width)\"/>"
    }
}

