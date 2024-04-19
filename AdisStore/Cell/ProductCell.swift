//
//  ProductCell.swift
//  AdisStore
//
//  Created by user on /4/24.
//

import UIKit

class ProductCell: UICollectionViewCell {
    static let reuseId = "product_cell"
    
    private let ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cappuccinoIcon")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Капучино"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.text = "140 c"
        view.font = .systemFont(ofSize: 14)
        view.textColor = UIColor.init(hex: "#FF8B5B")
        return view
    }()
    
    private let decreaseBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("-", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        view.backgroundColor = UIColor(hex: "#EDEDED")
        view.layer.cornerRadius = 14
        
        return view
    }()
    
    private let countLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16,weight: .bold)
        view.text = "1"
        view.textColor = .black
        view.backgroundColor = .white
        return view
    }()
    
    private let increaseBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("+", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 13
        view.alignment = .center
        return view
    }()
    
    //var counter: Int = 1
    
    var didDecrease: (() -> Void)?
    var didIncrease: (() -> Void)?
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints(){
        contentView.addSubview(ImageView)
        ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(89)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(ImageView.snp.trailing).offset(16)
        }
        
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(ImageView.snp.trailing).offset(16)
        }
        contentView.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.trailing.equalToSuperview()
            make.height.equalTo(28)
        }
        
        horizontalStackView.addArrangedSubview(decreaseBtn)
        horizontalStackView.addArrangedSubview(countLabel)
        horizontalStackView.addArrangedSubview(increaseBtn)
        
        decreaseBtn.addTarget(self,
                              action: #selector(decreaseBtnTapped),
                              for: .touchUpInside)
        
        increaseBtn.addTarget(self,
                              action: #selector(increaseBtnTapped),
                              for: .touchUpInside)
    }
    
    
    func fill(with model: Product){
        nameLabel.text = model.strMeal
        if let url = URL(string: model.strMealThumb) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.ImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        priceLabel.text = "\(model.idMeal) c"
    }
    
    
    var counter: Int = 1 {
        didSet{
            countLabel.text = "\(counter)"
        }
    }
    @objc
    private func decreaseBtnTapped(){
        didDecrease?()
        
    }
    @objc
    private func increaseBtnTapped(){
        didIncrease?()
    }
    
    
    
}
