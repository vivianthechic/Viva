//
//  StyleUtilities.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import Foundation
import UIKit

class StyleUtilities {
    
    static func styleTextField(_ textfield:UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor(red: 0.02, green: 0.34, blue: 0.40, alpha: 1.00).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
        textfield.textColor = UIColor(red: 0.02, green: 0.34, blue: 0.40, alpha: 1.00)
    }
    
    static func styleFilledButton(_ button:UIButton){
        button.backgroundColor = UIColor(red: 0.02, green: 0.34, blue: 0.40, alpha: 1.00)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(red: 0.97, green: 0.96, blue: 0.79, alpha: 1.00)
    }
    
    static func styleHollowButton(_ button:UIButton){
        button.backgroundColor = UIColor(red: 0.39, green: 0.84, blue: 0.76, alpha: 1.00)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(red: 0.97, green: 0.96, blue: 0.79, alpha: 1.00)
    }
}
