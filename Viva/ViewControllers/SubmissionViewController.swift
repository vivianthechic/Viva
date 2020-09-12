//
//  SubmissionViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit

//import FirebaseCore
//import FirebaseStore
//import FirebaseAnalytics

class SubmissionViewController: UIViewController {
    
    var db: Firestore;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // create a database collection for geolocation
    
    // create the button here
    @IBAction func didClickReportButton(_sender: AnyObject) {
        // Quickstart
        
        // Data Collection
        listenDocument()
    }
    
    private func listenDocument() {
        // [START] listen document
        db.collection("cities").document("SF")
        
        
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
