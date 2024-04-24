//
//  ShoppingCartViewController.swift
//  AdisStore
//
//  Created by user on 11/4/24.
//


import UIKit
import SnapKit


class ShoppingCartViewController: UIViewController {
    
    private lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 0, height: 0)
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    
    private let categoryLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 24)
        view.textColor = .black
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refreshProducts), for: .valueChanged)
        view.attributedTitle = NSAttributedString(string: "Loading...")
        return view
    }()
    
    private lazy var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 32, height: 89)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 24
        cv.refreshControl = refreshControl
        return cv
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        return view
    }()
    
    
    
    private var selectedCategoryIndex = 0
    private var products: [Productt] = []
    private var categories: [Category] = []
    private let networkLayer = NetworkLayer()
    private var selectedCategory: Category? {
        didSet{
            fetchProducts(by: selectedCategory!)
        }
    }
    private var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading{
                    self.activityIndicator.startAnimating()
                    self.refreshControl.beginRefreshing()
                } else {
                    self.activityIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupConstraints()
        fetchCategories()
        fetchProductsPagination()
    }
    
    private func setupCollectionView() {
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.showsVerticalScrollIndicator = false
        verticalCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
    }
    
    private func setupConstraints(){
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(32)
            make.horizontalEdges.equalToSuperview().inset(16)        }
        
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(verticalCollectionView)
        verticalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
    }
    

    
    private func selectFirstDefaultCategory() {
        if !categories.isEmpty  {
            let defaultIndexPath = IndexPath(item: 0, section: 0)
            horizontalCollectionView.selectItem(at: defaultIndexPath, animated: true, scrollPosition: .left)
            if let cell = horizontalCollectionView.cellForItem(at: defaultIndexPath) as? CategoryCell {
                cell.blueView.backgroundColor = .blue
                
            }
            if let firstCategory = categories.first {
                categoryLabel.text = firstCategory.strCategory
            }
        }
    }
    
    
    
    
    private func fetchCategories(){
        isLoading = true
        networkLayer.fetchCategorys(){ [weak self] result in
            guard let self else { return }
            isLoading = false
            switch result {
            case .success(let categories):
                DispatchQueue.main.async{
                    self.categories = categories
                    self.horizontalCollectionView.reloadData()
                    self.selectedCategory = categories.first
                    self.selectFirstDefaultCategory()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    private func fetchProducts(by category: Category){
     
    }
    
    private var page = 1
    
    private func fetchProductsPagination(){
        isLoading = true
        networkLayer.fetchProductsPagination(with: page, limit: 10){ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                DispatchQueue.main.async{
                    self.isLoading = false
                    self.products = products
                    self.verticalCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    @objc
    private func refreshProducts(){
       fetchProductsPagination()
    }
    

    
    
}


extension ShoppingCartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == horizontalCollectionView {
            
            selectedCategoryIndex = indexPath.row
            verticalCollectionView.reloadData()
            
            categoryLabel.text =  categories[indexPath.row].strCategory
           
            
            let category = categories[indexPath.row]
            selectedCategory = category
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.blueView.backgroundColor = UIColor(hex: "#283952")
                cell.tabsLabel.textColor = .white
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else {
            return
        }
        cell.blueView.backgroundColor = .white
        cell.tabsLabel.textColor = UIColor.init(hex: "#C2C1C3")
    }
    
    
}


extension ShoppingCartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return categories.count
        } else if collectionView == verticalCollectionView {
            return products.count
            
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId,
                                                          for: indexPath) as? CategoryCell
            let categoryProduct = categories[indexPath.row].strCategory
            cell?.fill(with: categoryProduct)
            
            return cell ?? CategoryCell()
            
        } else if collectionView == verticalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId,
                                                          for: indexPath) as? ProductCell
            let product = products[indexPath.row]
            cell?.fill2(with: product)
            
            
           
          
          
            
            
            cell?.didDecrease = { [weak self] in
                guard let self else {return}
                if cell?.counter ?? 1 <= 1{
                    cell?.counter = 1
                }else{
                    cell?.counter -= 1
                }
            }
            cell?.didIncrease = { [weak self] in
                guard let self else {return}
                cell?.counter += 1
            }
        
            
            return cell ?? ProductCell()
        } else {
            return UICollectionViewCell()
        }
        
        
    }
}



extension ShoppingCartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView {
            let categoryProduct = categories[indexPath.row].strCategory
            let labelWidth = categoryProduct.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]).width
            let blueViewWidth = labelWidth + 20
            return CGSize(width: blueViewWidth, height: 32)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 89)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == products.count - 1 {
            print("i am the last cell")
            page += 1
            fetchProductsPagination()
        }
        print("I am here to show end of collection")
    }
}
