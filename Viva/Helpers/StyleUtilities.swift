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
        
    }
    
    static func styleFilledButton(_ button:UIButton){
        button.backgroundColor = UIColor(red: 0.75, green: 0.88, blue: 0.92, alpha: 1.00)
        button.layer.cornerRadius = 0.25
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 0.25
        button.tintColor = UIColor.black
    }
}
