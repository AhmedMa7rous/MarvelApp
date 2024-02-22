//
//  Characters.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation

// MARK: - Characters
struct Characters: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: CharactersData
}

// MARK: - DataClass
struct CharactersData: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: CharacterComics
    let stories: CharacterStories
    let events: CharacterComics
    let urls: [URLElement]
}

// MARK: - Comics
struct CharacterComics: Codable {
    let available: Int
}

// MARK: - Stories
struct CharacterStories: Codable {
    let available: Int
}


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let ext: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
