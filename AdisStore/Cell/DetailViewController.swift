//
//  DetailViewController.swift
//  AdisStore
//
//  Created by user on 11/4/24.
//

import UIKit

class DetailViewController: UIViewController {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Капучино"
        view.textColor = .black
        view.font = .systemFont(ofSize: 22)
        view.numberOfLines = 0
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.text = "250 с"
        view.textColor = .orange
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Бра́уни — шоколадное пирожное коричневого цвета,прямоугольные куски нарезанного шоколадного пирога."
        view.textColor = .black
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    
    
    var product: Product?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        if let product = self.product {
                fill(with: product)
            }
        
    }
    
    private func fill(with item: Product) {
        if let url = URL(string: item.strMealThumb) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        nameLabel.text = item.strMeal
        priceLabel.text = "\(item.idMeal) c"
    }
    
    
    
    private func setupConstraints(){
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(260)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(265)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
