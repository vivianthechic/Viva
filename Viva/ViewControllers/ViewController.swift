//
//  ViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/10/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpElements()
    }
    
    func setUpElements(){
        StyleUtilities.styleFilledButton(signUpButton)
        StyleUtilities.styleFilledButton(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

