//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 20/02/2024.
//

import Foundation
import RxSwift
import RxCocoa


class HomeViewModel {
    //MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    private(set) var characters = BehaviorRelay<[Character]>(value: [])
    private var allCharacters: [Character] = []
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var numberOfCharacters: Int {
        return allCharacters.count
    }
    
    //MARK: - Intializer
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    //MARK: - Support Functions
    
    func fetchData(withOffSet offSet: Int) {
        showLoader.accept(true)
        networkManager.fetchCharacters(withOffSet: offSet, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.allCharacters.append(contentsOf: response.data.results)
                self.characters.accept(self.allCharacters)
                self.onSuccess.onNext(())
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        })
    }

}
