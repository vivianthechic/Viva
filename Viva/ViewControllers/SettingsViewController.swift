//
//  SettingsViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        // Style elements
        StyleUtilities.styleHStack(self.nameStackView)
        StyleUtilities.styleHStack(self.emailStackView)
        StyleUtilities.styleHollowButton(self.logoutButton)
        
        // Load name and email
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if(user != nil){
            db.collection("users").whereField("uid", isEqualTo: user?.uid).getDocuments { (querySnapshot, err) in
                if err != nil {
                    print("Error getting docs")
                } else {
                    let doc = querySnapshot!.documents[0]
                    self.nameLabel.text = (doc.get("firstName") as! String).lowercased() + " " + (doc.get("lastName") as! String).lowercased()
                    self.emailLabel.text = user?.email
                }
            }
        } else {
            transitionToHome()
        }
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
