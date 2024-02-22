//
//  Stories.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation

// MARK: - Stories
struct Stories: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: StoriesResult
}

// MARK: - DataClass
struct StoriesResult: Codable {
    let offset, limit, total, count: Int
    let results: [Story]
}

// MARK: - Result
struct Story: Codable {
    let id: Int
    let title, description: String
    let thumbnail: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

