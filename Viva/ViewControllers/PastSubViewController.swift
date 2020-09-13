//
//  PastSubViewController.swift
//  Viva
//
//  Created by Zhang, Vivian on 9/12/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import Firebase

class PastSubViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements(){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if(user != nil){
            db.collection("survivors").whereField("uid", isEqualTo: user?.uid).getDocuments { (querySnapshot, err) in
                if err != nil {
                    print("Error getting docs")
                } else {
                    let docs = querySnapshot!.documents
                    if docs.count == 0 {
                        let label = PaddingLabel()
                        label.text = "You have no submissions."
                        StyleUtilities.styleLabel(label)
                        self.stackView.addArrangedSubview(label)
                    } else {
                        for doc in docs {
                            let date = doc.get("dateString") as! String
                            let loc = doc.get("locString") as! String
                            let story = doc.get("story") as! String
                            self.addToStack(date: date, loc: loc, story: story)
                        }
                    }
                }
            }
        } else {
            self.transitionToHome()
        }
    }
    
    func addToStack(date: String, loc: String, story: String){
        let label = PaddingLabel()
        let s = story == "" ? "No story." : story
        label.text = "\(date)\n\n\(loc)\n\n\(s)"
        StyleUtilities.styleLabel(label)
        stackView.addArrangedSubview(label)
    }

    func transitionToHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "firstVC")
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
}
