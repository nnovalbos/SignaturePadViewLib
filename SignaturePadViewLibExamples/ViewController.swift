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

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    let posibleColorValues: [String] = ["Black", "Red", "Blue", "Green", "Yellow"]
    
    let posibleStrokeWidthValues: [CGFloat] = [CGFloat(0.5), CGFloat(1), CGFloat(1.5),CGFloat(2),CGFloat(2.5),CGFloat(3), CGFloat(3.5), CGFloat(4), CGFloat(4.5),CGFloat(5)]
    
    private var onlyShape: Bool = false
    
    @IBOutlet weak var blackboard: BlackboardView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var catchImageButton: UIButton!
    @IBOutlet weak var imageSelector: UISegmentedControl!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var propertiesSelector: UIPickerView!
    
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
        
        self.propertiesSelector.dataSource = self
        self.propertiesSelector.delegate = self
        
        
        propertiesSelector.selectRow(4, inComponent: 0, animated: true)
        propertiesSelector.selectRow(0, inComponent: 2, animated: true)
        
        blackboard!.strokeWidth = posibleStrokeWidthValues[4]
        blackboard!.strokeColor = UIColor.black
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
    
    //MARK: - UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return 10
        }else if component == 2 {
            return 5
        }else {
            return 1
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(self.posibleStrokeWidthValues[row])"
        }else if component == 1 {
            return "width"
        }else if component == 2 {
            return "\(self.posibleColorValues[row])"
        }else {
            return "color"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 12)
            pickerLabel?.textAlignment = .center
        }
        
        if component == 0 {
            pickerLabel?.text = "\(posibleStrokeWidthValues[row])"
        }else if component == 1 {
            pickerLabel?.text = "width"
        }else if component == 2 {
            pickerLabel?.text = posibleColorValues[row]
        }else {
            pickerLabel?.text = "color"
        }
        
        pickerLabel?.textColor = UIColor.darkText
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            self.blackboard.strokeWidth = posibleStrokeWidthValues[row]
        }
        
        if component == 2 {

            switch posibleColorValues[row] {
            case "Black":
                self.blackboard.strokeColor = UIColor.black
            case "Red":
                self.blackboard.strokeColor = UIColor.red
            case "Blue":
                self.blackboard.strokeColor = UIColor.blue
            case "Green":
                self.blackboard.strokeColor = UIColor.green
            case "Yellow":
                self.blackboard.strokeColor = UIColor.yellow
            default:
                self.blackboard.strokeColor = UIColor.black
            }
        }
    }
    
}

