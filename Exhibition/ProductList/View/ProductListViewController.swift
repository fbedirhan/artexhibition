//
//  ProductListViewController.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 1.08.2023.
//

import UIKit
import Combine

class ProductListViewController: BaseViewController {
    
    var collectionView: UICollectionView!
    private var viewModel: ProductListViewModel
    private var anyCancellable = Set<AnyCancellable>()
    private var adapter: ProductListAdapter?
    
    private(set) var data : [ArtObject]? {
        didSet {
            self.adapter?.items = data
            self.collectionView.reloadData()
        }
    }
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarForLargeTitle(title: "Art Gallery")
        setupCollectionView()
        bindViewModel()
        viewModel.getCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        adapter = ProductListAdapter(itemsInSection: viewModel.count, delegate: self)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: "ProductListCell")
        collectionView.register(ProductListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductListHeader")
    }
    
    private func bindViewModel() {
        
        self.viewModel.$artObjects
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

extension ProductListViewController: ProductListDelegate {
    
    func selectItem(item: ArtObject?) {
        let apiManager = APIManager()
        let repo = ProductDetailRepository(apiManager: apiManager)
        let vm = ProductDetailViewModel(repo: repo)
        let vc = ProductDetailViewController.get(artObjectId: item?.objectNumber, viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadMore(index: Int) {
        viewModel.loadMore(index: index)
    }
    
}
