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
    
    func CreateLine(){
        lines.append(Line(withRect: CGRect(x: begin!.x, y: begin!.y, width: end!.x - begin!.x, height: end!.y - begin!.y)))
    }
    
    func UpdatePoints(){
        begin?.x = end!.x;
        begin?.y =  end!.y;
    }
    
    func Paint(){
        delegate?.DrawLines(lines: lines)
    }
    
    func ClearBlackboard(){
        lines = []
        delegate?.ClearBlackBoard()
    }
}
