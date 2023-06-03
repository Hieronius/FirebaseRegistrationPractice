//
//  ViewController.swift
//  FirebaseRegistrationPractice
//
//  Created by Арсентий Халимовский on 03.06.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // MARK: Registration Block
    
    @IBOutlet weak var registrationEmailTextField: UITextField!
    @IBOutlet weak var registrationPasswordTextField: UITextField!
    @IBOutlet weak var registrationRepeatPasswordTextField: UITextField!
    
    // MARK: Authorisation Block
    
    
    @IBOutlet weak var logInEmailTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    // MARK: Reset Password Block
    
    @IBOutlet weak var resetPasswordEmailTextField: UITextField!
    
    // MARK: Check of the current user authorisation state block
    
    @IBOutlet weak var logOutButtonView: UIButton!
    @IBOutlet weak var deleteAccountButtonView: UIButton!
    
    // MARK: - Private Properties
    
    private var currentUserState: AuthenticationState?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    
    // Creation of new account
    // Method working correctly
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        // check to prevent nil in login/pass fields
        let email = registrationEmailTextField.text ?? ""
        let password = registrationPasswordTextField.text ?? ""
        
        // create account via Firebase
        // probably we use weak self to make a link to the current view controller you have data from
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            // check is there a data for account creation
            guard let strongSelf = self else { return }
            
            // is not print a message and exit the method
            guard error == nil else {
                print("Account creation failed")
                return
            }
            // we should see this message if account has been created
            print("Account has been created")
        }
        
        
    }
    
    @IBAction func logInButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func resetPasswordButtonAction(_ sender: UIButton) {
    }
    
    // MARK: Should change a state of user authorisation
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func deleteAccoutButtonAction(_ sender: UIButton) {
    }
    
    
}

