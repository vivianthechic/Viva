//
//  FormUtilities.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import Foundation

class FormUtilities{
    
    static func validatePassword(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[A-Za-z])(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
        return passwordTest.evaluate(with: password)
    }
}
