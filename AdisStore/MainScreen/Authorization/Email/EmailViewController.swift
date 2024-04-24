//
//  EmailViewController.swift
//  AdisStore
//
//  Created by user on 24/4/24.
//

import UIKit

class EmailViewController: UIViewController {
    
    private let emailView = EmailView(frame: .zero)
    private let authService = AuthService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = emailView
        view.backgroundColor = .systemBackground
        didEntryBtnTApped()
        didChangedTF()
        didRightViewBtnTapped()
    }
    
    
    private func didChangedTF(){
        emailView.didChangedTF = { [weak self] in
            guard let self else {return}
            check()
        }
    }
    private func didRightViewBtnTapped(){
        emailView.didRightViewBtnTapped = { [weak self] in
            guard let self = self else { return }
            self.emailView.passwordTF.isSecureTextEntry.toggle()
            let eyeIconImage = self.emailView.passwordTF.isSecureTextEntry ? UIImage(named: "eyeIcon") : UIImage(named: "eyeSlashIcon")
            self.emailView.passwordTF.rightView?.subviews.compactMap { $0 as? UIButton }.first?.setImage(eyeIconImage, for: .normal)
        }
        
    }
    
    
    private func check() {
        if emailView.emailTF.text?.isEmpty ?? true {
            emailView.emailTF.attributedPlaceholder = NSAttributedString(string: "Please fill out", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            emailView.emailTF.layer.borderWidth = 1
            emailView.emailTF.layer.borderColor = UIColor.red.cgColor
        } else {
            emailView.emailTF.layer.borderWidth = 0
            emailView.emailTF.layer.borderColor = UIColor.black.cgColor
        }
        
        if emailView.passwordTF.text?.isEmpty ?? true {
            emailView.passwordTF.attributedPlaceholder = NSAttributedString(string: "Please fill out", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            emailView.passwordTF.layer.borderWidth = 1
            emailView.passwordTF.layer.borderColor = UIColor.red.cgColor
        } else {
            emailView.passwordTF.layer.borderWidth = 0
            emailView.passwordTF.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    private func didEntryBtnTApped(){
        emailView.didEntryBtnTapped = { [weak self] in
            guard let self else {return}
            guard let email = emailView.emailTF.text else {return}
            guard let password = emailView.passwordTF.text else {return}
            signIn()
            if email.isEmpty || password.isEmpty{
                check()
            }
        }
        
    }
    
    
    
    private func signIn(){
        guard let email = emailView.emailTF.text, let password = emailView.passwordTF.text else { return }
        
        authService.signIWithEmail(with: email, with: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let vc = TabBarController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
