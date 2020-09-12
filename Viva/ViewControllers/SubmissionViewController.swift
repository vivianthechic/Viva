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
    var docRef: DocumentReference!
    
    // Geotapped Button Response
    @IBAction func saveGeoTapped(_sender: UIButton!) {
        // create function for tapped button
        print("Button Tapped!")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //docRef = Firebase.firestore().collection("sample data").document("sampleData/inspiration");

        // Do any additional setup after loading the view.
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
