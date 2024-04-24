//
//  EmailView.swift
//  AdisStore
//
//  Created by user on 24/4/24.
//


import UIKit
import SnapKit

class EmailView: UIView {
    
    private let signInLabel: UILabel = {
        let view = UILabel()
        view.text = "Sign in"
        view.font = .systemFont(ofSize: 34)
        view.textColor = .black
        return view
    }()
    
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        let iconImageView = UIImageView(image: UIImage(systemName: "person.fill"))
        iconImageView.tintColor = UIColor.systemGray2
        iconImageView.frame = CGRect(x: 16, y: 16, width: 24, height: 24)
        leftContainerView.addSubview(iconImageView)
        tf.leftView = leftContainerView
        tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(checkChangedTF), for: .editingChanged)
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        tf.isSecureTextEntry = true
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        let iconImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
        iconImageView.tintColor = UIColor.systemGray2
        iconImageView.frame = CGRect(x: 16, y: 16, width: 24, height: 24)
        leftContainerView.addSubview(iconImageView)
        tf.leftView = leftContainerView
        tf.leftViewMode = .always
        let rightContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        let rightView = UIButton(type: .system)
        rightView.tintColor = UIColor.systemGray2
        rightView.frame = CGRect(x: 5, y: 13, width: 44, height: 30)
        rightView.addTarget(self, action: #selector(rightViewBtnTapped), for: .touchUpInside)
        rightView.setImage(UIImage(named: "eyeIcon"), for: .normal)
        rightContainerView.addSubview(rightView)
        tf.rightView = rightContainerView
        tf.rightViewMode = .always
        tf.addTarget(self, action: #selector(checkChangedTF), for: .editingChanged)
        return tf
    }()
    
    let entryBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(entryBtnTapped), for: .touchUpInside)
        return button
    }()
    
    var didEntryBtnTapped: (() -> Void)?
    var didChangedTF: (() -> Void)?
    var didRightViewBtnTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(signInLabel)
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        addSubview(emailTF)
        emailTF.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(passwordTF)
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(emailTF.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailTF)
            make.height.equalTo(emailTF)
            
        }
        
        addSubview(entryBtn)
        entryBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailTF)
            make.height.equalTo(emailTF)
        }
    }
    
    @objc
    private func entryBtnTapped(){
        didEntryBtnTapped?()
    }
    
    @objc
    private func checkChangedTF(){
        didChangedTF?()
    }
    
    @objc
    private func rightViewBtnTapped(){
        didRightViewBtnTapped?()
    }
}
