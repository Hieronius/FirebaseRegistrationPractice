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
    
    private var customCleanButton = CleaningButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    // MARK: - IBActions
    
    @objc private func cleanRegistrationEmailTextField() {
        registrationEmailTextField.text = ""
        registrationEmailTextField.resignFirstResponder()
        print("text has been deleted")
    }
    
    // MARK: CREATE NEW ACCOUNT
    
    // Creation of new account
    // Method working correctly
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
        Task {
            // check to prevent nil in login/pass fields
            let email = registrationEmailTextField.text ?? ""
            let password = registrationPasswordTextField.text ?? ""
            let repeatPassword = registrationRepeatPasswordTextField.text ?? ""
            
            if password == repeatPassword {
                
                // create account via Firebase
                // probably we use weak self to make a link to the current view controller you have data from
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                    
                    // check is there a data for account creation
                    guard let strongSelf = self else { return }
                    
                    
                    // MARK: EMAIL VERIFICATION
                    // this code is really working
                    Auth.auth().currentUser?.sendEmailVerification()
                    
                    
                    
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
                    // 1. Add Alert controller here
                    print("Account has been created")
                    
                    // MARK: Force user to logout after registration.
                    let firebaseAuth = FirebaseAuth.Auth.auth()
                    
                    // implement error handling while you wan't log out. Seems like it's need because there can be nil instead of user. (First loading of the app for example)
                    do {
                        try firebaseAuth.signOut()
                        print("User has been logged out after registration")
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    
                }
            } else {
                // 2. Add Alert controller here
                print("Wrong password")
            }
        }
        
        
    }
    
    // MARK: LOGIN TO THE APP
    
    @IBAction func logInButtonAction(_ sender: UIButton) {
        Task {
            // run code asynchronously even in synchronous method of UIButton
            // It's still running in the main thread but in the background
            // Firebae guides provides info that almost all of their API is asynchronous, so i will try to use Tasks for these purposes
            
            // check to find a nil or define a default values
            let email = self.logInEmailTextField.text ?? ""
            let password = self.logInPasswordTextField.text ?? ""
                
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] resutl, error in
                    guard let result = self else { return }
                    
                    // MARK: Check is user email verified
                    if Auth.auth().currentUser?.isEmailVerified == true {
                    
                    guard error == nil else {
                        print("wrong login or password")
                        return
                    }
                    print("Welcome to the app!")
                    print("User is verified")
                    self?.isUserLoggedIn.isHidden = false
                    print(FirebaseAuth.Auth.auth().currentUser)
                    print(FirebaseAuth.Auth.auth().currentUser?.email)
                    
                    // MARK: There should be segue into the Lock/Main Screen
                        
                } else {
                    // 3. Alert controller - emain need to be verified
                    print("User still need to verify email")
                }
                    
                // we should see if user log in was successful
                
            }
        }
    }
    
    // MARK: RESET PASSWORD
    
    @IBAction func resetPasswordButtonAction(_ sender: UIButton) {
        
        let email = resetPasswordEmailTextField.text ?? ""

        FirebaseAuth.Auth.auth().sendPasswordReset(withEmail: email)
        print("Email with a link to change your password has been send")
    }
    
    // MARK: LOGOUT FROM THE APP
    
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
    
    // MARK: DELETE ACCOUNT
    
    @IBAction func deleteAccoutButtonAction(_ sender: UIButton) {
        FirebaseAuth.Auth.auth().currentUser?.delete()
        print("Your account has been deleted")
    }
    
    // MARK: - Private Methods
    func setupUI() {
        setupSignUpEmailTextField()
        setupCleaningButton()
    }
    
    func setupSignUpEmailTextField() {
        // registrationEmailTextField.clearButtonMode = .whileEditing
        let textFieldPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60)
        
         registrationEmailTextField.bounds.inset(by: textFieldPadding)
        
    }
    
    private func setupCleaningButton() {
        registrationEmailTextField.rightView = customCleanButton
        registrationEmailTextField.rightViewMode = .whileEditing
        addActionToCleaningButton()

        
    }
    
    private func addActionToCleaningButton() {
        customCleanButton.addTarget(self, action: #selector(cleanRegistrationEmailTextField), for: .touchUpInside)
    }
    
}

