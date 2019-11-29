//
//  utilities.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/7/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation
import UIKit

func makeAlert(title: String, message: String) -> UIAlertController{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
    return alert
}

func makeRandomId() -> String{
    let first = Int.random(in: 0...9)
    let second = Int.random(in: 0...9)
    let therd = Int.random(in: 0...9)
    return String(first) + String(second) + String(therd)
}
