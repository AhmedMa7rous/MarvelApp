//
//  Comics.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation

// MARK: - Comics
struct Comics: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Comic]
}

// MARK: - Result
struct Comic: Codable {
    let id, digitalID: Int
    let title: String
    let thumbnail: Thumbnail
    let images: [Thumbnail]


    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, thumbnail, images
    }
}
