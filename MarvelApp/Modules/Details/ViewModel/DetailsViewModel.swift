//
//  DetailsViewModel.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 22/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsViewModel {
    //MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    private(set) var character: Character
    let sectionHeaders = ["NAME", "DESCRIPTION", "COMICS", "SERIES", "STORIES", "EVENTS", "RELATED LINKS"]
    var comics: BehaviorRelay<[Comic]> = BehaviorRelay<[Comic]>(value: [])
    var series: BehaviorRelay<[SeriesResult]> = BehaviorRelay<[SeriesResult]>(value: [])
    var stories: BehaviorRelay<[Story]> = BehaviorRelay<[Story]>(value: [])
    var events: BehaviorRelay<[EventResult]> = BehaviorRelay<[EventResult]>(value: [])
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    let sections: Observable<[Section]>
    
    //MARK: - Intializer
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, forCharacter character: Character) {
        self.networkManager = networkManager
        self.character = character
        
        sections = Observable.combineLatest(comics, series, stories, events)
            .map { comics, series, stories, events -> [Section] in
                var sections: [Section] = []
                sections.append(.text(character.name))
                sections.append(.text(character.description))
                sections.append(.link(character.urls))
                return sections
            }
    }
    
    //MARK: - Private Functions
    private func fetchComics() {
        networkManager.fetchCharacterComics(forCharacterId: character.id, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.comics.accept(response.data.results)
                self.onSuccess.onNext(())
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        })
    }
    
    private func fetchSeries() {
        networkManager.fetchCharacterSeries(forCharacterId: character.id, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.series.accept(response.data.results)
                self.onSuccess.onNext(())
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        })
    }
    
    private func fetchStories() {
        networkManager.fetchCharacterStories(forCharacterId: character.id, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.stories.accept(response.data.results)
                self.onSuccess.onNext(())
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        })
    }
    
    private func fetchEvents() {
        networkManager.fetchCharacterEvents(forCharacterId: character.id, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.events.accept(response.data.results)
                self.onSuccess.onNext(())
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        })
    }
    
    //MARK: - Public Functions
    func fetchData() {
        showLoader.accept(true)
        if character.comics.available != 0 {
            fetchComics()
        }
        
        if character.series.available != 0 {
            fetchSeries()
        }
        
        if character.stories.available != 0 {
            fetchStories()
        }
        
        if character.events.available != 0 {
            fetchEvents()
        }
    }
    
    
}

enum Section {
    case text(String)
    case link([URLElement])
    case image
}
