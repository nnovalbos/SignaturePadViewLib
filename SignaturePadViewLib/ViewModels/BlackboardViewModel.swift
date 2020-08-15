//
//  BlackboardViewModel.swift
//  SignaturePadViewLib
//
//  Created by Nicolas Novalbos on 05/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import Foundation
import CoreGraphics

class BlackboardViewModel {
    
    var lines: [Line] = []
    var begin: CGPoint?
    var end: CGPoint?
    
    var delegate : IBlackboardDelegate?
    
    func createLine(){
        
        if let beginPoint = self.begin, let endPoint = self.end {
            lines.append(Line(withRect: CGRect(x: beginPoint.x, y: beginPoint.y, width: endPoint.x - beginPoint.x, height: endPoint.y - beginPoint.y)))
        }
    }
    
    func updatePoints(){
        
        if let endPoint = self.end {
            begin?.x = endPoint.x
            begin?.y = endPoint.y
        }
    }
    
    func paint(){
        delegate?.DrawLines(lines: lines)
    }
    
    func clearBlackboard(){
        lines = []
        delegate?.ClearBlackBoard()
    }
}
