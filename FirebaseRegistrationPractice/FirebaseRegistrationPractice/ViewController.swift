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
    
    // this outlet should change it's state each time when the state of the user authorisation has been changed. But something wrong for the time being.
    // Let's come back when i will be on the stage of making button "Log Out" in the "Settings View Controller"
    @IBOutlet weak var isUserLoggedIn: UILabel!
    
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
            
            // section to try to implement email verification
            let actionCodeSettings = ActionCodeSettings()
            // actionCodeSettings.url = URL(string: "https://www.localhost.com")
            // actionCodeSettings.url = URL(string: "http://localhost/")
            // actionCodeSettings.url = URL(string: "https://www.noreply@fir-practice-461ed.firebaseapp.com")
            // actionCodeSettings.url = URL(string: "https://myapp.com")
             actionCodeSettings.url = URL(string: "https://fir-practice-461ed.firebaseapp.com")
            // actionCodeSettings.url = URL(string: "https://hieronius.page.link/email-link-login")
            actionCodeSettings.handleCodeInApp = true
            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
            
            // section to try to send an email for verification
            FirebaseAuth.Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) {
                error in
                if let error = error {
                    // self.showMessagePrompt(error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                // The link was successfully sent. Inform the user.
                // Save the email locally so you don't need to ask the user for it again
                UserDefaults.standard.set(email, forKey: "Email")
                // self.showMessagePrompt("Check your email for link")
                print("Check your email for link")
            }
            
            // is not print a message and exit the method
            guard error == nil else {
                print("Account creation failed")
                // error handling for allert controller if user trying to use email which is already exist in the system
                if error?.localizedDescription == "The email address is already in use by another account." {
                    print("Email already in use")
                }
                return
            }
            // we should see this message if account has been created
            print("Account has been created")
        }
        
        
    }
    
    @IBAction func logInButtonAction(_ sender: UIButton) {
        // check to find a nil or define a default values
        let email = logInEmailTextField.text ?? ""
        let password = logInPasswordTextField.text ?? ""
        // actually log in to the app and define self as the same viewController where you got user data
        // using strongSelf it's just a way to check is there a nil in "self" property or not.
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] resutl, error in
            guard let result = self else { return }
            
            guard error == nil else {
                print("wrong login or password")
                return
            }
            // we should see if user log in was successful
            print("Welcome to the app!")
            self!.isUserLoggedIn.isHidden = false
            print(FirebaseAuth.Auth.auth().currentUser)
            print(FirebaseAuth.Auth.auth().currentUser?.email)
        }
    }
    
    @IBAction func resetPasswordButtonAction(_ sender: UIButton) {
        print(FirebaseAuth.Auth.auth().currentUser)
        print(FirebaseAuth.Auth.auth().currentUser?.email)
    }
    
    // MARK: Should change a state of user authorisation
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        // define an instance of FirebaseAuthorisation module
        let firebaseAuth = FirebaseAuth.Auth.auth()
        
        // implement error handling while you wan't log out. Seems like it's need because there can be nil instead of user. (First loading of the app for example)
        do {
            try firebaseAuth.signOut()
            self.isUserLoggedIn.isHidden = true
            print("User has been logged out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
    @IBAction func deleteAccoutButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - Private Methods
    
    
}

