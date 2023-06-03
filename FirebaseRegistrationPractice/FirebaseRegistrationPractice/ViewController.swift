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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

