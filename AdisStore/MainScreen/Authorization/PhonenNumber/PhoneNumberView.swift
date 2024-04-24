//
//  AuthorizationView.swift
//  AdisStore
//
//  Created by user on 9/4/24.
//

import UIKit
import SnapKit

class PhoneNumberView: UIView {
    
    private let mainImageCofee: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mainImage")
        return view
    }()
    
    private let entryLabel: UILabel = {
        let view = UILabel()
        view.text = "Вход"
        view.font = .systemFont(ofSize: 34)
        view.textColor = .black
        return view
    }()
    
     let phoneNumberTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "enter your phone number"
        view.textColor = .black
        view.backgroundColor = UIColor.systemGray3
        view.layer.cornerRadius = 25
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        let iconImageView = UIImageView(image: UIImage(systemName: "phone"))
        iconImageView.tintColor = UIColor.systemGray2
        iconImageView.frame = CGRect(x: 16, y: 16, width: 24, height: 24)
        leftContainerView.addSubview(iconImageView)
        view.leftView = leftContainerView
        view.leftViewMode = .always
        return view
    }()
    
    private let entryButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Войти", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 25
        view.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private let googleButton: UIButton = {
        let view = UIButton()
        view.setTitle("Google", for: .normal)
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 16
        view.setTitleColor(.black, for: .normal)
        view.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var didEntryButtonTapped: (() -> Void)?
    var didGoogleButtonTapped: (() -> Void)?
    
    private func setupConstraints(){
        backgroundColor = .white
        addSubview(mainImageCofee)
        mainImageCofee.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(155)
            make.horizontalEdges.equalToSuperview().inset(102)
            make.height.equalTo(80)
            make.width.equalTo(170)
        }
        
        addSubview(entryLabel)
        entryLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageCofee.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(entryLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        addSubview(entryButton)
        entryButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        addSubview(googleButton)
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(entryButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(50)
           
            
        }
    }
    
    @objc
    private func entryButtonTapped(){
        didEntryButtonTapped?()
    }
    
    @objc
    private func googleButtonTapped(){
        didGoogleButtonTapped?()
    }


}
