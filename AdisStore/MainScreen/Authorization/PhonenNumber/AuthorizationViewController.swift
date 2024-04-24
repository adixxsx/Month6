//
//  AuthorizationViewController.swift
//  AdisStore
//
//  Created by user on 9/4/24.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    
    private let authorizationView = PhoneNumberView(frame: .zero)
    private let authService = AuthService.shared
        override func loadView() {
        super.loadView()
        view = authorizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didEntryTapped()
        didGoogleTapped()
    }
    
    private func didEntryTapped(){
        authorizationView.didEntryButtonTapped = { [weak self] in
            guard let self else { return }
            sendSms()
        }
    }
    
    private func didGoogleTapped(){
        authorizationView.didGoogleButtonTapped = { [weak self] in
            guard let self else { return }
            let vc = EmailViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func sendSms() {
            guard let text = authorizationView.phoneNumberTextField.text else { return }
            authService.sendSmsCode(with: text) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        let vc = PhoneNumberCodeViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    case .failure(let error):
                        print("Failed to send SMS: \(error.localizedDescription)")
                    }
                }
            }
        }
}
