//
//  ProductDetailViewController.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation
import UIKit
import Combine

class ProductDetailViewController: BaseViewController {
    
    ///product detail view controller proporites
    let artObjectName = UILabel()
    let artObjectMaker = UILabel()
    let productDescriptionLabel = UILabel()
    let artObjectImageView = UIImageView()
    var viewModel: ProductDetailViewModel
    
    private var anyCancellable = Set<AnyCancellable>()
    var artObjectId: String? = nil
    
    private(set) var data : ArtObjectDetail? {
        didSet {
            setDetail()
        }
    }
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func get(artObjectId: String? = nil, viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        let controller = ProductDetailViewController(viewModel: viewModel)
        controller.artObjectId = artObjectId
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.getCollectionDetail(artObjectId: artObjectId)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        /// setup art object image view
        artObjectImageView.translatesAutoresizingMaskIntoConstraints = false
        artObjectImageView.contentMode = .scaleAspectFit
        view.addSubview(artObjectImageView)
        
        /// setup art object name label
        artObjectName.translatesAutoresizingMaskIntoConstraints = false
        artObjectName.font = UIFont.boldSystemFont(ofSize: 18)
        artObjectName.numberOfLines = 0
        view.addSubview(artObjectName)
        
        /// setup art object maker label
        artObjectMaker.translatesAutoresizingMaskIntoConstraints = false
        artObjectMaker.font = UIFont.systemFont(ofSize: 18)
        artObjectMaker.textColor = .blue
        view.addSubview(artObjectMaker)
        
        /// setup art object description label
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionLabel.numberOfLines = 0
        view.addSubview(productDescriptionLabel)
        
        /// setup constraints
        NSLayoutConstraint.activate([
            artObjectImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            artObjectImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artObjectImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            artObjectImageView.heightAnchor.constraint(equalToConstant: 400),
            
            artObjectName.topAnchor.constraint(equalTo: artObjectImageView.bottomAnchor, constant: 20),
            artObjectName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artObjectName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            artObjectMaker.topAnchor.constraint(equalTo: artObjectName.bottomAnchor, constant: 8),
            artObjectMaker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: artObjectMaker.bottomAnchor, constant: 20),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    /// set product detail page with using data
    private func setDetail() {
        self.artObjectMaker.text = data?.principalOrFirstMaker
        self.productDescriptionLabel.text = data?.artObjectDescription
        self.artObjectName.text = data?.title
        self.artObjectImageView.load(url: data?.webImage?.url ?? "")
    }
    
    /// bind view model
    private func bindViewModel() {
        
        self.viewModel.$artObjectDetail
            .dropFirst()
            .sink {[weak self] result in
                guard let self = self else { return }
                self.data = result
            }
            .store(in: &anyCancellable)
        
        viewModel.$progress
            .dropFirst()
            .sink { [weak self] result in
                guard let self = self else { return }
                self.progress(status: result ?? false)
            }
            .store(in: &anyCancellable)
        
        self.viewModel.$error
            .dropFirst()
            .sink {[weak self] result in
                guard let self = self else { return }
                self.showErrorAlert(message: result?.localizedDescription)
            }
            .store(in: &anyCancellable)
    }
}
