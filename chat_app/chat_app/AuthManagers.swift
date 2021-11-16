//
//  AuthManagers.swift
//  chat_app
//
//  Created by Admin on 11/16/21.
//

import Foundation
import FirebaseAuth
class AuthManager {
    static let shared = AuthManager()
    func signUp(email: String, password: String, completions: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { results, error in
            if error != nil {
                completions(.failure(error as! Error))
            } else {
                completions(.success(true))
            }
        })
    }
    
    func login(email: String, password: String, completions: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { results, error in
            if error != nil {
                completions(.failure(error as! Error))
            } else {
                completions(.success(true))
            }
        })
    }
    
    func currentAuth() -> Bool {
        return FirebaseAuth.Auth.auth().currentUser != nil
    }
}
