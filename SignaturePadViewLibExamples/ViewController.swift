//
//  ViewController.swift
//  SignaturePadViewLibExamples
//
//  Created by Nicolas Novalbos on 05/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import UIKit
import SignaturePadViewLib

class ViewController: UIViewController {
    
    private var onlyShape: Bool = false
    
    @IBOutlet weak var blackboard: BlackboardView!
    
    @IBOutlet weak var signatureImage: UIImageView!
    
    @IBAction func ClearBlackboard(){
        blackboard.clear()
    }
    
    @IBAction func AdjustChanged(_ sender: Any) {
        let sw = sender as! UISwitch
        
        onlyShape = sw.isOn
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackboard.strokeColor = UIColor.black
    }
    
    @IBAction func getSignatureImage(_ sender: Any) {
        if let signature = blackboard.getImage(adjustToShape: onlyShape) {
            signatureImage.image = signature
        }
        
        print(blackboard.getSVG(adjustToShape: onlyShape))
    }
}

