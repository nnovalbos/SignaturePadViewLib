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
    
    @IBOutlet weak var blackboard: BlackboardView!
    
    @IBOutlet weak var signatureImage: UIImageView!
    
    @IBAction func ClearBlackboard(){
        blackboard.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getSignatureImage(_ sender: Any) {
        if let signature = blackboard.getImage() {
            signatureImage.image = signature
        }
    }
}

