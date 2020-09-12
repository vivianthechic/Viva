//
//  SubmissionViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class SubmissionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.image = UIImage(named: "submission_bg.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var datePicker: UIDatePicker?
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return dateFormatter
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
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(SubmissionViewController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SubmissionViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        dateTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func setUpElements(){
        loadingIndicator.alpha = 0
        errorLabel.alpha = 0
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
    
    func validateFields() -> String? {
        // Check all fields are filled in
        if streetTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            stateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            zipTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        loadingIndicator.alpha = 1
        
        let error = validateFields()
        if error != nil {
            // show error message
            showError(error!)
        } else {
            // Create cleaned versions of data
            let street = streetTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let city = cityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let state = stateTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let zip = zipTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let date = dateTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var story = storyTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if story == "(Optional)" {
                story = ""
            }
            addressToCoords(street: street, city: city, state: state, zip: zip, date: date, story: story)
        }
    }
    
    func showError(_ message:String) {
        loadingIndicator.alpha = 0
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func addressToCoords(street: String, city: String, state: String, zip: String, date: String, story: String) {
        let geocoder = CLGeocoder()
        let addr = street + ", " + city + ", " + state + " " + zip
        geocoder.geocodeAddressString(addr) { (placemarks, error) in
            guard let placemark = placemarks?.first?.location else {
                return
            }
            // Create doc
            let db = Firestore.firestore()
            let docData: [String: Any] = [
                "uid" : Auth.auth().currentUser?.uid,
                "date" : Timestamp(date: self.dateFormatter.date(from: date)!),
                "story" : story,
                "location" : GeoPoint(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
            ]
            db.collection("survivors").addDocument(data: docData) { (error) in
                if error != nil {
                    self.showError("Unable to save submission")
                } else {
                    self.showToast()
                }
            }
        }
    }
    
    func transitionToHome() {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "tabBC")
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    
    func showToast() {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-100, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor(red: 0.39, green: 0.84, blue: 0.76, alpha: 0.70)
        toastLabel.textColor = UIColor(red: 0.02, green: 0.34, blue: 0.40, alpha: 1.00)
        toastLabel.font = .systemFont(ofSize: 17.0)
        toastLabel.textAlignment = .center
        toastLabel.text = "Successfully submitted."
        toastLabel.alpha = 1
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {toastLabel.alpha = 0}) { (isCompleted) in
            toastLabel.removeFromSuperview()
            self.transitionToHome()
        }
    }
}
