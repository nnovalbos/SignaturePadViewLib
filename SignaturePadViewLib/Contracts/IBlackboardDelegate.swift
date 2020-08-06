//
//  IBlackboardDelegate.swift
//  SignaturePadViewLib
//
//  Created by Nicolas Novalbos on 05/08/2020.
//  Copyright © 2020 Nicolás Novalbos. All rights reserved.
//

import Foundation

protocol IBlackboardDelegate {
    
  func DrawLines(lines:[Line])
  func ClearBlackBoard()
}
