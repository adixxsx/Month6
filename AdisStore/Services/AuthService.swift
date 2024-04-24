//
//  AuthService.swift
//  AdisStore
//
//  Created by user on 24/4/24.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    private init(){}
     
     
    func authorize(){
        let date = Date()
        guard  let oneMinuteLater = Calendar.current.date(byAdding: .second,
                                                          value: 30,
                                                          to: date)
        else{ return }
        UserDefaults.standard.set(oneMinuteLater, forKey: "session")
    }
    
    
    func sendSmsCode(with phoneNumber: String,completion: @escaping (Result<Void, Error>) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error{
                    completion(.failure(error))
                }
                if let verificationID {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    completion(.success(()))
                }
                
            }
    }
    
    func signInWithPhoneNumber(
        with verificationCode: String,
        completion: @escaping (
            Result<
            AuthDataResult,
            Error
            >
        ) -> Void
    ) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID,
                                                                 verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func signIWithEmail(
        with email: String,
        with password: String,
        completion: @escaping (
            Result<Void,
            Error
            >
        ) -> Void
    ){
        Auth.auth().signIn(withEmail: email,password: password){ [weak self] authResult,error in
            guard let strongSelf = self  else { return }
            if let authResult{
                strongSelf.authorize()
                completion(.success(()))
            }
            if let error{
                completion(.failure(error))
            }
            
        }
        
        
        
        
        
        
    }
}
