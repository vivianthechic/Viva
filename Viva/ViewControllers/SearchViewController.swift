//
//  SearchViewController.swift
//  Viva
//
//  Created by Alyssa Tan on 9/12/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        findLocation()
    }
    
    func findLocation(){
        let url = URL(string: "https://api.mapbox.com/geocoding/v5/mapbox.places/Los%20Angeles.json?access_token=pk.eyJ1IjoiYWx5c3NhdGx5IiwiYSI6ImNrZXl1YjA3ODE5cTQyeWw5MXhneHNrYWYifQ.LvyPyfNVLi11Re0oNEpRmw")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
