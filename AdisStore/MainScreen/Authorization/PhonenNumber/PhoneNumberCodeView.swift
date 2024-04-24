//
//  PhoneNumberCodeView.swift
//  AdisStore
//
//  Created by user on 24/4/24.
//


import UIKit
import SnapKit

class PhoneNumberCodeView: UIView {

   
    let codeTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter the Code"
        view.textColor = .black
        view.backgroundColor = UIColor.init(hex: "#EDEDED")
        view.layer.cornerRadius = 25
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        let iconImageView = UIImageView(image: UIImage(systemName: "envelope.fill"))
        iconImageView.tintColor = UIColor.systemGray2
        iconImageView.frame = CGRect(x: 16, y: 16, width: 35, height: 24)
        leftContainerView.addSubview(iconImageView)
        view.leftView = leftContainerView
        view.leftViewMode = .always
        return view
    }()
    private let entryBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Sign In", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 25
        view.addTarget(self, action: #selector(entryBtnTapped), for: .touchUpInside)
        return view
    }()
    
    var didEntryBtnTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints(){
        addSubview(codeTF)
        
        codeTF.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(entryBtn)
        entryBtn.snp.makeConstraints { make in
            make.top.equalTo(codeTF.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   @objc
    private func entryBtnTapped(){
        didEntryBtnTapped?()
    }
}
