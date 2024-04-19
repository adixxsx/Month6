//
//  AuthorizationViewController.swift
//  AdisStore
//
//  Created by user on 9/4/24.
//

import UIKit

class AuthorizationViewController: UIViewController {
    private let authorizationView = AuthorizationView(frame: .zero)

        override func loadView() {
        super.loadView()
        view = authorizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didEntryTapped()
    }
    
    private func didEntryTapped(){
        authorizationView.didEntryButtonTapped = {
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
