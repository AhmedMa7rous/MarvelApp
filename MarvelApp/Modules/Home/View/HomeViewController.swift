//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 19/02/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var charactersTableView: UITableView!
    
    
    //MARK: - Properties
    #warning("Must remove this array and changed it with acual data source")
    var names = ["Alice", "Bob", "Charlie", "David", "Emma", "Alice", "Bob", "Charlie", "David", "Emma", "Alice", "Bob", "Charlie", "David", "Emma"]
    var filteredNames: [String] = []
    var searchController: UISearchController!
    var isSearching = false
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi() 
    }
    
    
    //MARK: - Action Connections
    
    @objc func searchButtonTapped() {
        isSearching = true
        charactersTableView.reloadData()
        if searchController == nil {
            setupSearchController()
        }
        navigationItem.titleView = searchController.searchBar
        navigationItem.rightBarButtonItem = nil
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    
    //MARK: - Support Functions
    //This function responsible for everything related with UI in the Initial state
    private func updateUi() {
        setupNavigationBar()
        setupTableView()
    }
    
    ///This is a support function to set up navigation bar UI
    private func setupNavigationBar() {
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
    
    ///This is a support function (support updateUi function) to set up table view
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setupTableView() {
        //Set Delegate & Data source
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        
        //Register Cells
        charactersTableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        charactersTableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
    }
    
    ///This is a support function  to set up search controller when tap on search button
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
    
        // Change cancel button color to red
        searchController.searchBar.tintColor = .black
        
        // Change search bar background color to white
        searchController.searchBar.barTintColor = .red
        
        // Change search bar text color to black
        if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = .white
        }
    }
}

//MARK: - TableView Functions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredNames.count : names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = isFiltering() ? filteredNames[indexPath.row] : names[indexPath.row]
        
        // Dequeue the correct cell based on its identifier
        let cellIdentifier = isSearching ? SearchTableViewCell.identifier : HomeTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Cast the cell to the appropriate type
        if let homeCell = cell as? HomeTableViewCell {
            // Configure HomeTableViewCell
            homeCell.configure(with: "", for: name)
        } else if let searchCell = cell as? SearchTableViewCell {
            // Configure SearchTableViewCell
            searchCell.configure(with: "", for: name)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isSearching ? 80 : (0.23 * view.frame.size.height)
    }
    
}

//MARK: - UISearchBarDelegate Functions
extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        charactersTableView.reloadData()
        navigationItem.titleView = nil
        setupNavigationBar()
    }
    
    func isFiltering() -> Bool {
        guard let searchController = searchController else { return false }
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredNames = names.filter { $0.lowercased().contains(searchText.lowercased()) }
        charactersTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
}
