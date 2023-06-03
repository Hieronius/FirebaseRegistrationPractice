//
//  AuthenticationManager.swift
//  FirebaseRegistrationPractice
//
//  Created by Арсентий Халимовский on 03.06.2023.
//

import Foundation

// The whole manager you manager interactions with the user
class AuthenticationManager {
    // seems like it's about log in
    func signInWithEmailPassword() async -> Bool {
        authentificationState = .authentificating
        await wait()
        authentificationState = .authentificated
        return true
    }
    // this mean to sign up
    func signUpWithEmailPassword() async -> Bool {
        authentificationState = .authentificating
        await wait()
        authentificationState = .authentificated
        return true
    }
    
    func signOut() {
        authenticationState = .unauthenticated
    }
    
    func deleteAccount() async -> Bool {
        authenticationState = .unauthenticated
    }
}
