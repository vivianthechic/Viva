//
//  SubmissionViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
//import FirebaseAnalytics

class SubmissionViewController: UIViewController {
    
    var survivordata: Firestore!
    @IBOutlet weak var titleLabel: UILabel!
    var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.image = UIImage(named: "submission_bg.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // create a database collection for geolocation
    
    @IBOutlet weak var someView:UIView!
    
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
