//
//  MainView.swift
//  AdisStore
//
//  Created by user on 9/4/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    private let mainImageCofee: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mainImage")
        return view
    }()
    
    private let authorizationButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Войти", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 25
        view.addTarget(self, action: #selector(authorizationBtnTapped), for: .touchUpInside)
        return view
    }()
    
    private let regisrationButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitleColor(UIColor.systemGray3, for: .normal)
        view.setTitle("Регистрация", for: .normal)
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var didAuthorizationButtonTapped: (() -> Void)?
    
    private func setupConstraints(){
        backgroundColor = .white
        addSubview(mainImageCofee)
        mainImageCofee.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(234)
            make.horizontalEdges.equalToSuperview().inset(102)
            make.width.equalTo(170)
            make.height.equalTo(80)
        }
        
        addSubview(authorizationButton)
        authorizationButton.snp.makeConstraints { make in
            make.top.equalTo(mainImageCofee.snp.bottom).offset(98)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        addSubview(regisrationButton)
        regisrationButton.snp.makeConstraints { make in
            make.top.equalTo(authorizationButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    @objc
    private func authorizationBtnTapped(){
        didAuthorizationButtonTapped?()
    }
}

