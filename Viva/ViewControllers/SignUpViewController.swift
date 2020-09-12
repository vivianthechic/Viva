//
//  SignUpViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.image = UIImage(named: "login_bg.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.insertSubview(imageView, at: 0)
               NSLayoutConstraint.activate([
                   imageView.topAnchor.constraint(equalTo: view.topAnchor),
                   imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        setUpElements()
    }
    
    func setUpElements(){
        //Hide error label and loading
        errorLabel.alpha = 0
        loadingIndicator.alpha = 0
        
        //Style elements
        StyleUtilities.styleTextField(firstNameTextField)
        StyleUtilities.styleTextField(lastNameTextField)
        StyleUtilities.styleTextField(emailTextField)
        StyleUtilities.styleTextField(passwordTextField)
        StyleUtilities.styleFilledButton(signUpButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Check fields and validate data is correct
    // If correct, method returns nil
    // Otherwise, return error message
    func validateFields() -> String? {
        
        // Check all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        // Check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if FormUtilities.validatePassword(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        loadingIndicator.alpha = 1
        // Validate fields
        let error = validateFields()
        if error != nil {
            // show error message
            showError(error!)
        } else {
            // Create cleaned versions of data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                if err != nil {
                    self.showError("error creating user")
                } else {
                    // User created successfully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid":result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    
                    //Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        loadingIndicator.alpha = 0
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "tabBC")
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
}
