//
//  ViewController.swift
//  AdisStore
//
//  Created by user on 5/4/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let splashView = MainView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTappedButton()
    }
    
    private func didTappedButton(){
        splashView.didAuthorizationButtonTapped = {
            let vc = AuthorizationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
