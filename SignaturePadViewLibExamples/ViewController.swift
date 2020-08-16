//
//  ViewController.swift
//  SignaturePadViewLibExamples
//
//  Created by Nicolas Novalbos on 05/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import UIKit
import SignaturePadViewLib
import WebKit

class ViewController: UIViewController {
    
    private var onlyShape: Bool = false
    
    @IBOutlet weak var blackboard: BlackboardView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var catchImageButton: UIButton!
    @IBOutlet weak var imageSelector: UISegmentedControl!
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func ClearBlackboard(){
        
        blackboard.clear()
        webView.load(URLRequest(url: URL(string: "about:blank")!))
    }
    
    @IBAction func AdjustChanged(_ sender: Any) {
        let sw = sender as! UISwitch
        onlyShape = sw.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.layer.borderWidth = 3
        webView.layer.borderColor = UIColor.systemTeal.cgColor
        
        clearButton.layer.cornerRadius = 5
        catchImageButton.layer.cornerRadius = 5
        
        imageSelector.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        imageSelector.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)

    }
    
    @IBAction func getSignatureImage(_ sender: Any) {
        
        imageSelector.selectedSegmentIndex == 0 ? generateAndLoadImage() : generatAndLoadSvg()
    }
    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func generateAndLoadImage(){
        
        if let signature = blackboard.getImage(adjustToShape: onlyShape) {
            if let data = signature.pngData() {
                let filename = getDocumentsDirectory().appendingPathComponent("signature.png")
                try? data.write(to: filename)
            }
            
            let url = URL(string:"\(getDocumentsDirectory())signature.png")!
            webView.loadFileURL(url, allowingReadAccessTo: getDocumentsDirectory())
        }
    }
    
    func generatAndLoadSvg(){
        
        let svgStr = blackboard.getSVG(adjustToShape: onlyShape)
        if let data = svgStr.data(using: .utf8) {
            let filename = getDocumentsDirectory().appendingPathComponent("signature.svg")
            try? data.write(to: filename)
        }
        
        let url = URL(string:"\(getDocumentsDirectory())signature.svg")!
        webView.loadFileURL(url, allowingReadAccessTo: getDocumentsDirectory())
    }
}

