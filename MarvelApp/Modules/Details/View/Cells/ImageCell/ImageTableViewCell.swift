//
//  ImageTableViewCell.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 22/02/2024.
//

import UIKit
import RxSwift


class ImageTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagesCollectionView.frame = contentView.bounds
    }
    
    //MARK: - Support Functions
    
    ///This is a support function to setup CollectionView UI
    private func setupCollectionView(with viewModel: DetailsViewModel) {
        //Set Collection delegate = self
        imagesCollectionView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        
        //Register Collection WalkThrough Cell
        imagesCollectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    //MARK: - Public Functions
    func configure(with viewModel: DetailsViewModel) {
        setupCollectionView(with: viewModel)
        bindCollectionView(with: viewModel)
    }
}
//MARK: - CollectionView Functions
extension ImageTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private func bindCollectionView(with viewModel: DetailsViewModel) {
        viewModel.comics.bind(to: imagesCollectionView.rx.items(cellIdentifier: ImageCollectionViewCell.identifier, cellType: ImageCollectionViewCell.self)) { section, comic, cell in
            print(section)
            cell.configure(forImage: comic.images[0].path + "." + comic.images[0].ext.rawValue, withTitle: comic.title)
            
        }.disposed(by: viewModel.disposeBag)
        
        imagesCollectionView.rx.modelSelected(Comic.self).subscribe { [weak self] comic in
            guard let self = self else { return }
            print("Model selected")
        }.disposed(by: viewModel.disposeBag)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.size.width / 3.5, height: contentView.frame.size.height)
    }

}
