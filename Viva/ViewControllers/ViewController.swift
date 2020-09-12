//
//  ViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/10/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // extra setup
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        // end setup
        db = Firestore.firestore();
        
        setUpElements()
    }
    
    override func didRecieveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpElements(){
        StyleUtilities.styleFilledButton(signUpButton)
        StyleUtilities.styleHollowButton(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

