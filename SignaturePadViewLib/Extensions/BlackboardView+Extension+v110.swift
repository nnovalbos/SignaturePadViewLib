//
//  BlackboardView+Extension+v110.swift
//  SignaturePadViewLib
//
//  Created by Nicolas Novalbos on 15/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import Foundation
import UIKit

extension BlackboardView
{
    // MARK: - API Functions

    /// Returns a String representing the drawn shape
    ///
    /// - Parameters:
    ///   - adjust: Indicates whether when capturing the image, the limits are adjusted to the area delimited by the shape drawn (true) or the limits are adjusted to BlackboardView size (false)
    public func getSVG(adjustToShape adjust: Bool)-> String {
        
        var beginX = CGFloat(0)
        var beginY = CGFloat(0)
        var width = self.bounds.maxX
        var height = self.bounds.maxY
        
        if adjust{
            
            let offset = strokeWidth / 2
            beginX = getMinX() - offset
            width = getMaxX() - beginX + 2 * offset
            beginY = getMinY() - offset
            height = getMaxY() - beginY + 2 * offset
        }
        
           var svgStr = String("<svg viewBox=\"\(beginX) \(beginY) \(width) \(height)\" width=\"\(width)\" height=\"\(height)\" xmlns=\"http://www.w3.org/2000/svg\">")
       
           for line in lines {
               svgStr.append(line.svgLine(withStrokeWidth: strokeWidth, withStrokeColor: strokeColor.cgColor))
           }

           svgStr.append("</svg>")
           
           return svgStr;
       }
    
    /// Returns a UIImage representing the drawn shape
    ///
    /// - Parameters:
    ///   - adjust: Indicates whether when capturing the image, the limits are adjusted to the area delimited by the shape drawn (true) or the limits are adjusted to BlackboardView size (false)
    public func getImage(adjustToShape adjust: Bool) -> UIImage? {
        
        let color = self.backgroundColor
        self.backgroundColor=UIColor.clear
        
        let bounds = adjust ? generateShapeFrame() : self.bounds
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        
        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        
        self.backgroundColor = color;
        
        return image;
        
    }
    
    //MARK: - Private functions
    
    private func generateShapeFrame() -> CGRect {
        
        let minX = getMinX()
        let maxX = getMaxX()
        let minY = getMinY()
        let maxY = getMaxY()
        let offset = strokeWidth / 2
        return CGRect(x: minX - offset , y: minY - offset , width: maxX - minX + 2 * offset, height: maxY - minY + 2 * offset)
    }
    
    private func getMinX() -> CGFloat {
        
        return lines.map({CGFloat.minimum($0.originPoint.x, $0.endPoint.x)})
            .reduce(CGFloat(MAXFLOAT), { CGFloat.minimum($0, $1) })
    }
    
    private func getMaxX() -> CGFloat {

        return lines.map({CGFloat.maximum($0.originPoint.x, $0.endPoint.x)})
            .reduce(0, { CGFloat.maximum($0, $1) })
    }
    
    private func getMinY() -> CGFloat {
        
        return lines.map({CGFloat.minimum($0.originPoint.y, $0.endPoint.y)})
            .reduce(CGFloat(MAXFLOAT), { CGFloat.minimum($0, $1) })
    }
    
    private func getMaxY() -> CGFloat {
        
        return lines.map({CGFloat.maximum($0.originPoint.y, $0.endPoint.y)})
            .reduce(0, { CGFloat.maximum($0, $1) })
    }
}
