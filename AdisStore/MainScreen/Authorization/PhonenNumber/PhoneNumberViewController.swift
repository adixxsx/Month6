//
//  PhoneNumberViewController.swift
//  AdisStore
//
//  Created by user on 24/4/24.
//


import UIKit

class PhoneNumberCodeViewController: UIViewController {
    
    private let phoneNumberCodeView = PhoneNumberCodeView(frame: .zero)
    private let authService = AuthService.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = phoneNumberCodeView
        didEntryTapped()
    }
    
    
    
    private func didEntryTapped(){
        phoneNumberCodeView.didEntryBtnTapped = { [ weak self ] in
            guard let self else { return }
           signIn()
        }
    }
    
    
    private func signIn() {
        guard let text = phoneNumberCodeView.codeTF.text else { return }
        authService.signInWithPhoneNumber(with: text) { result in
            switch result {
            case .success(let success):
                self.authService.authorize()
                let vc  = TabBarController()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
