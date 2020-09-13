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
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func findLocation(location: String){
        let theLocation = location.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "Nothing"
        if(theLocation != "Nothing"){
            let urlString = String(format: "https://api.mapbox.com/geocoding/v5/mapbox.places/%@.json?access_token=pk.eyJ1IjoiYWx5c3NhdGx5IiwiYSI6ImNrZXl1YjA3ODE5cTQyeWw5MXhneHNrYWYifQ.LvyPyfNVLi11Re0oNEpRmw",theLocation)
            let url = URL(string: urlString)!
            
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Please Try Again", message: "Try entering a different location", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let features = dataDictionary["features"] as! [[String:Any]]
                    let coor = features[0]["geometry"] as! [String:Any]
                    let coordinates = coor["coordinates"]! as! [Any]
                    let logtitude = coordinates[0] as! Double
                    let latitude = coordinates[1] as! Double
                    print(logtitude,latitude)
                    
                    let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBC") as! UITabBarController
                    
                    let naviViewController = tabBarController.viewControllers?[0] as! UINavigationController
                    let homeViewController = naviViewController.viewControllers[0] as! HomeViewController
                    homeViewController.myLatitude = latitude
                    homeViewController.myLongtitude = logtitude
                    homeViewController.trackUser = false
                    self.view.window?.rootViewController = tabBarController
                    self.view.window?.makeKeyAndVisible()
                }
            }
            task.resume()
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        if(searchTextField.text != ""){
            findLocation(location: searchTextField.text!)
        }else{
            let alert = UIAlertController(title: "Text Field Is Empty", message: "Please enter in a place to search", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
