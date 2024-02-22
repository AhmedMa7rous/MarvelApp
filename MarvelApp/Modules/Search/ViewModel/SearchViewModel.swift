//
//  SearchViewModel.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 20/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    //MARK: - Properties
    private var searchableCharacters: BehaviorRelay<[Character]>
    let searchText = BehaviorRelay<String>(value: "")
    private let filteredCharacters = BehaviorRelay<[Character]>(value: [])
    var disposeBag: DisposeBag = DisposeBag()
    
    
    //MARK: - Initializer
    init(allCharacters: BehaviorRelay<[Character]> = BehaviorRelay<[Character]>(value: [Character]())) {
        self.searchableCharacters = allCharacters
        updateFilteredCharacters()
    }
    
    //MARK: - Private Methods
    private func updateFilteredCharacters() {
        // Subscribe to searchText changes and update filteredCharacters
        searchText
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // debounce to avoid rapid search updates
            .subscribe(onNext: { [weak self] searchText in
                guard let self = self else { return }
                if searchText.isEmpty {
                    self.filteredCharacters.accept([]) // When search text is empty, clear the filtered characters
                } else {
                    let filtered = self.searchableCharacters.value.filter { $0.name.lowercased().starts(with: searchText.lowercased()) }
                    self.filteredCharacters.accept(filtered) // Update filtered characters based on search text
                }
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - Public Methods
    /// Observable for the filtered characters
    var filteredCharactersObservable: Observable<[Character]> {
        return filteredCharacters.asObservable()
    }
    
    /// Set the characters to be filtered
    func setAllCharacters(_ characters: [Character]) {
        searchableCharacters.accept(characters)
    }
}

