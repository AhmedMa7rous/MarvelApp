//
//  Series.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation

// MARK: - Series
struct Series: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SeriesData
}

// MARK: - DataClass
struct SeriesData: Codable {
    let offset, limit, total, count: Int
    let results: [SeriesResult]
}

// MARK: - Result
struct SeriesResult: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let images: [Thumbnail]?
}
