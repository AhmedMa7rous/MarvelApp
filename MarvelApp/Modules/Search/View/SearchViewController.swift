//
//  SearchViewController.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 20/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    private var viewModel: SearchViewModel

    //MARK: - LifeCycle
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        self.view.alpha = 0
        bindSearchBar()
        bindTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0) {
            self.view.alpha = 1
        }
        searchBar.becomeFirstResponder()
    }
    
    //MARK: - Support Functions
    //This function responsible for everything related with UI in the Initial state
    private func updateUi() {
        setupSearchController()
        setupTableView()
    }
    
    ///This is a support function (support updateUi function) to set up table view
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setupTableView() {
        searchTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        //Register Cells
        searchTableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
    }
    
    ///This is a support function  to set up search controller when tap on search button
    private func setupSearchController() {
        searchBar.placeholder = "Search"
        searchBar.delegate = self

        searchBar.barTintColor = .black
        
        // Change cancel button color to red
        // Get the cancel button from the search bar
        if let cancelButton = searchBar.cancelButton {
            cancelButton.setTitleColor(.red, for: .normal)
        }
        
        // Change search bar text color to black
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.tintColor = .black
            textFieldInsideSearchBar.textColor = .black
            textFieldInsideSearchBar.backgroundColor = .white
        }
    }
    
    private func bindSearchBar() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: viewModel.disposeBag)
    }
}

//MARK: - TableView Functions
extension SearchViewController: UITableViewDelegate {
    private func bindTableView() {
        viewModel.filteredCharactersObservable.bind(to: searchTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, character, cell) in
            cell.configure(with: character.thumbnail.path + "." + character.thumbnail.ext.rawValue, for: character.name)
        }.disposed(by: viewModel.disposeBag)
        
        searchTableView.rx.modelSelected(Character.self).subscribe { [weak self] character in
            guard let self = self else { return }
            let detailsViewmodel = DetailsViewModel(forCharacter: character)
            let vc = DetailsViewController(viewModel: detailsViewmodel)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}


//MARK: - UISearchBarDelegate Functions
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
