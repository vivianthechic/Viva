//
//  SubmissionViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit

import Firebase
import FirebaseCore
import FirebaseFirestore
//import FirebaseAnalytics

// constant
let quoteText = "My experience..."
let quoteAuthor = "The author is..."

// SubmissionViewController
class SubmissionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Outlets & Properties
    @IBOutlet var safetyButton: [UIButton]!
    @IBOutlet var geolocationButton: [UIButton]!

    // Document Reference
    var survivordata: Firestore!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var storyTextView: UITextView!
    var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.image = UIImage(named: "submission_bg.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //docRef = Firebase.firestore().collection("sample data").document("sampleData/inspiration");

        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        titleLabel.clipsToBounds = true
        titleLabel.layer.cornerRadius = 25.0
        StyleUtilities.styleTextView(storyTextView)
        StyleUtilities.styleTextField(streetTextField)
        StyleUtilities.styleTextField(cityTextField)
        StyleUtilities.styleTextField(stateTextField)
        StyleUtilities.styleTextField(zipTextField)
        StyleUtilities.styleTextField(dateTextField)
        StyleUtilities.styleFilledButton(submitButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // create a database collection for geolocation
    
    @IBOutlet weak var geoView:UIView!
    
    // create the button here
    @IBAction func didClickReportButton(_sender: AnyObject) {
        // Quickstart
        
        
        // Data Collection
        //listenDocument()
    }
    
//    private func createDocument() {
//        // [START add document]
//            // add a document with a generated ID
//        //var ref : DocumentReference? = nil;
//
//        survivordata = survivordata.collection("users").addDocument(data: [
//            "first" : "Andrea",
//            "last"  : "Tongsak",
//            "born"  : 2001
//        ]) {
//            err in if let err = err {
//                print("Error adding document: \(err)") } else {
//                print("Document added with ID: : \(ref!.documentID)") {
//                }
//            }
//
//        }
//    }

    private func getCollection() {
        // user the data to get a collection
        survivordata.collection("survivors").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print ("Error getting documents");
            }
        }
        
    }
    
    private func listenDocument() {
        // [START] listen document
        survivordata.collection("cities").document("SF")


    }
    
    @IBAction func submitTapped(_ sender: Any) {
        
    }
    
}
