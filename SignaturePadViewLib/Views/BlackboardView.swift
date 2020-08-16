//
//  BlackboardView.swift
//  SignaturePadViewLib
//
//  Created by Nicolas Novalbos on 05/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import Foundation
import UIKit

open class BlackboardView: UIView, IBlackboardDelegate {
    
    var lines: [Line] = []
    var vm: BlackboardViewModel = BlackboardViewModel()
    private var currentContext: CGContext?
    
    @IBInspectable open var strokeColor:UIColor = UIColor.black
    @IBInspectable open var strokeWidth:CGFloat = 3.0
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        vm.delegate = self
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        vm.delegate = self
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            vm.begin = touch.location(in: self)
            vm.end = touch.location(in: self)
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            vm.end = touch.location(in: self)
            vm.createLine()
            vm.updatePoints()
            vm.paint()
        }
    }
    
    
    open override func draw(_ rect: CGRect) {
        
        self.currentContext = UIGraphicsGetCurrentContext();
        let context = self.currentContext;
        context?.setStrokeColor(self.strokeColor.cgColor);
        context?.setLineWidth(self.strokeWidth)
        
        for line in lines {
            let beginLine = line.points.origin;
            context?.move(to: beginLine)
            context?.addLine(to: CGPoint(x: line.points.origin.x + line.points.size.width, y: line.points.origin.y + line.points.size.height))
        }
        
        context?.strokePath()
    }
    
    // MARK: - API Functions
    
    open func clear(){
        self.vm.clearBlackboard()
    }
    
    @available(*, deprecated, renamed: "getImage(adjustToShape:)")
    open func getImage() -> UIImage? {
        
        let color = self.backgroundColor
        self.backgroundColor=UIColor.clear
        
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        let img = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        
        self.backgroundColor = color;
        
        return img;
    }

    // MARK: - IBlackboardDelegate methods
    
    func DrawLines(lines: [Line]) {
        
        self.lines = lines
        setNeedsDisplay()
    }
    
    func ClearBlackBoard() {
        lines = []
        setNeedsDisplay()
    }

}
