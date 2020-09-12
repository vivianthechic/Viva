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
//import FirebaseFirestoreSwift

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.image = UIImage(named: "main_bg.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // extra setup
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        // end setup
        //db = Firestore.firestore();
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

