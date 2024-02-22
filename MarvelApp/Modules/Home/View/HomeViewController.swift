//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 19/02/2024.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headerView: UIView!
    
    
    //MARK: - Properties
    var viewModel = HomeViewModel()
    var searchController: UISearchController?
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindActivityIndicator()
        viewModel.fetchData(withOffSet: 0)
        updateUi()
        bindTableView()
        
    }
    
    
    //MARK: - Action Connections
    
    @objc func searchButtonTapped() {
        let searchViewModel = SearchViewModel(allCharacters: viewModel.characters)
        let vc = SearchViewController(viewModel: searchViewModel)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    
    //MARK: - Support Functions
    //This function responsible for everything related with UI in the Initial state
    private func updateUi() {
        headerView.isHidden = true
        showLoader(forCell: false)
        setupNavigationBar()
        setupTableView()
        setupObservables()
    }
    
    ///This is a support function (support updateUi function) to set up table view
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setupTableView() {
        charactersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
        charactersTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        //Register Cells
        charactersTableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
    }
    
    ///This is a support function (support updateUi function) to change UI according to data network call
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupObservables() {
        
        viewModel.onSuccess.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.showLoader.accept(false)
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.navigationController?.navigationBar.isHidden = false
                self.headerView.isHidden = false
            }
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.onError.subscribe { [weak self] error in
            guard let self = self else { return }
            self.viewModel.showLoader.accept(true)
            self.activityIndicator.isHidden = false
            self.navigationController?.navigationBar.isHidden = true
            self.headerView.isHidden = true
        }.disposed(by: viewModel.disposeBag)
    }
    
    ///This is a support function to set up activityIndicator  UI
    private func bindActivityIndicator() {
        navigationController?.navigationBar.isHidden = true
        viewModel.showLoader
            .asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: viewModel.disposeBag)
    }
        
    ///This is a support function to set up navigation bar UI
    private func setupNavigationBar() {
        //Hide Navigation Bar in the initial state
        navigationController?.navigationBar.isHidden = false
        // Create a UIImageView with marvel image
        let imageView = UIImageView(image: UIImage(named: "icn-nav-marvel"))
        
        // Set the content mode and size for the image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        // Set the image view as the title view for the navigation item
        navigationItem.titleView = imageView
        
        // change background color
        navigationController?.navigationBar.backgroundColor = UIColor.black

        // Create a custom UIButton with an image
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icn-nav-search"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        // Create a UIBarButtonItem with the custom UIButton
        let customBarButtonItem = UIBarButtonItem(customView: button)
        
        // Set the custom UIBarButtonItem as the right bar button item
        navigationItem.rightBarButtonItem = customBarButtonItem
        
    }
    
    private func showLoader(forCell: Bool) {
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Remove existing constraints
        activityIndicator.removeConstraints(activityIndicator.constraints)
        
        // Remove from superview
        activityIndicator.removeFromSuperview()
        
        // Create new constraints based on the condition
        if forCell {
            view.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                activityIndicator.widthAnchor.constraint(equalToConstant: 40),
                activityIndicator.heightAnchor.constraint(equalToConstant: 40)
            ])
        } else {
            view.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.widthAnchor.constraint(equalToConstant: 40),
                activityIndicator.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        activityIndicator.isHidden = false
    }
    
}

//MARK: - TableView Functions
extension HomeViewController: UITableViewDelegate {
    private func bindTableView() {
        viewModel.characters.bind(to: charactersTableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { (row, character, cell) in
            cell.configure(with: character.thumbnail.path + "." + character.thumbnail.ext.rawValue, for: character.name)
        }.disposed(by: viewModel.disposeBag)
        
        charactersTableView.rx.modelSelected(Character.self).subscribe { [weak self] character in
            guard let self = self else { return }
            let detailsViewmodel = DetailsViewModel(forCharacter: character)
            let vc = DetailsViewController(viewModel: detailsViewmodel)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 3.85 //(0.23 * view.frame.size.height)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Check if the displayed cell is the last cell
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        //print(indexPath.row)
        if indexPath.row == lastRow - 4 {
            showLoader(forCell: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                self.viewModel.fetchData(withOffSet: self.viewModel.numberOfCharacters)
            }
            
        }
    }
    
}
