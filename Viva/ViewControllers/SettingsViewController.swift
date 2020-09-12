//
//  SettingsViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        // Style elements
        StyleUtilities.styleFilledButton(logoutButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            transitionToHome()
        } catch {
            print("Error signing out")
        }
    }
    
    func transitionToHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "firstVC")
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
}
