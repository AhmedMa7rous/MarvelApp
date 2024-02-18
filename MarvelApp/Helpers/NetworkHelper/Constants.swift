//
//  Constants.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://gateway.marvel.com/v1/public"
    static let apiKey = "ddc27f36b1a7d9e775d398b61b44a7f0"
    static let ts = "1"
    static let hash = "54a568ac8aa64a8f866e7e11e8b23cda"
    static let parameters: [String: Any] = [
        "ts": ts,
        "apikey": apiKey,
        "hash": hash
    ]
    
    
    struct Endpoints {
        static let characters = "/characters"
        static let comics = "/characters/{characterId}/comics" //TODO: -Replace characterId with actual character ID
        static let series = "/characters/{characterId}/series" //TODO: -Replace characterId with actual character ID
        static let stories = "/characters/{characterId}/stories" //TODO: -Replace characterId with actual character ID
        static let events = "/characters/{characterId}/events" //TODO: -Replace characterId with actual character ID
    }
}
