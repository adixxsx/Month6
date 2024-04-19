//
//  CategoryCell.swift
//  AdisStore
//
//  Created by user on 10/4/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let reuseId = "coffeeHouse_cell"
    
    
     let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    
     let tabsLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = UIColor.init(hex: "#C2C1C3")
        return view
    }()
    
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var isSelected: Bool {
            didSet {
                blueView.backgroundColor = isSelected ? UIColor.init(hex: "#283952") : .white
                tabsLabel.textColor = isSelected ? .white : UIColor.init(hex: "#C2C1C3")
            }
        }
    
    private func setupConstraints(){
 
        contentView.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            
            
        }
        
        blueView.addSubview(tabsLabel)
        tabsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
       
        
        
    }
    
    func fill(with label: String){
        tabsLabel.text = label
    }
    
   
}
