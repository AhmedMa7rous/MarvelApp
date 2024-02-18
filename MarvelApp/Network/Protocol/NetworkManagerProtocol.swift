//
//  NetworkManagerProtocol.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation


protocol NetworkManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<Characters, APIError>) -> Void)
    func fetchCharacterComics(forCharacterId characterId: Int, completion: @escaping (Result<Comics, APIError>) -> Void)
    func fetchCharacterSeries(forCharacterId characterId: Int, completion: @escaping (Result<Series, APIError>) -> Void)
    func fetchCharacterStories(forCharacterId characterId: Int, completion: @escaping (Result<Stories, APIError>) -> Void)
    func fetchCharacterEvents(forCharacterId characterId: Int, completion: @escaping (Result<Events, APIError>) -> Void)
}
