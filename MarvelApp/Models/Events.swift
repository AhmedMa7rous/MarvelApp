//
//  Events.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation

// MARK: - Events
struct Events: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: EventsData
}

// MARK: - DataClass
struct EventsData: Codable {
    let offset, limit, total, count: Int
    let results: [Event]
}

// MARK: - Result
struct Event: Codable {
    let id: Int
    let title, description: String
    let thumbnail: Thumbnail
}
