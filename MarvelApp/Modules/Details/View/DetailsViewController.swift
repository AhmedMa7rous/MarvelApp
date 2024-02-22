//
//  DetailsViewController.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 21/02/2024.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {

    //MARK: - Outlet Connections
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    //MARK: - Properties
    private var viewModel: DetailsViewModel
    
    
    //MARK: - LifeCycle
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        viewModel.fetchData()
    }


    //MARK: - Action Connections
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - Support Functions
    //This function responsible for everything related with UI in the Initial state
    private func updateUi() {
        setupNavigationBar()
        setupTableView()
    }
    
    ///This is a support function to set up navigation bar UI
    private func setupNavigationBar() {
        //Hide Navigation Bar
        navigationController?.navigationBar.isHidden = true
    }
    
    ///This is a support function (support updateUi function) to setup TableView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupTableView() {
        //Set header for table view
        let tableViewHeader = TableViewHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 0.5))
        tableViewHeader.setImage(viewModel.character.thumbnail.path + "." + viewModel.character.thumbnail.ext.rawValue)
        detailsTableView.tableHeaderView = tableViewHeader
        
        //Set delegate = self
        //detailsTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        detailsTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        detailsTableView.dataSource = self
        
        //Register Cells
        detailsTableView.register(TextTableViewCell.nib, forCellReuseIdentifier: TextTableViewCell.identifier)
        detailsTableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.identifier)
        detailsTableView.register(LinkTableViewCell.nib, forCellReuseIdentifier: LinkTableViewCell.identifier)
        
        detailsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
    }
    
    private func createTextCell(withInfo info: String, for indexPath: IndexPath) -> UITableViewCell {
       guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell else { return UITableViewCell() }
        cell.configure(with: info)
        return cell
    }
    
    private func createLinkCell(withTitle title: String, for indexPath: IndexPath) -> UITableViewCell {
       guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: LinkTableViewCell.identifier, for: indexPath) as? LinkTableViewCell else { return UITableViewCell() }
        cell.configure(withTitle: title)
        return cell
    }
    
    private func createImageCell(with viewModel: DetailsViewModel, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel)
        return cell
    }
}

//MARK: - TableView Functions
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionHeaders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 6 {
            return viewModel.character.urls.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createTextCell(withInfo: viewModel.character.name, for: indexPath)
        case 1:
            return createTextCell(withInfo: viewModel.character.description, for: indexPath)
        case 6:
            print(indexPath.row)
            return createLinkCell(withTitle: viewModel.character.urls[indexPath.row].type.rawValue.capitalized, for: indexPath)
        default:
            return createImageCell(with: viewModel, for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 6 {
            if let url = URL(string: viewModel.character.urls[indexPath.row].url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.frame = CGRect(x: headerView.bounds.origin.x + 20, y: headerView.bounds.origin.y, width: 100, height: headerView.bounds.height)
            headerView.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            headerView.textLabel?.textColor = .red
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
